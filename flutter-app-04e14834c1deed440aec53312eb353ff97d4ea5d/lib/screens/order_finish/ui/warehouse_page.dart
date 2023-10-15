import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/screens/map_screen/data/bloc/map_cubit.dart';
import 'package:europharm_flutter/screens/map_screen/data/repo_map.dart';
import 'package:europharm_flutter/screens/map_screen/map.dart';
import 'package:europharm_flutter/screens/order_card/bloc/order_detail_bloc.dart';
import 'package:europharm_flutter/screens/order_finish/bloc/point_page_bloc.dart';
import 'package:europharm_flutter/screens/order_finish/ui/scan_choose_page.dart';
import 'package:europharm_flutter/screens/order_finish/ui/widgets/success_order_finished.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_bottom_sheet.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/app_loader_overlay.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:europharm_flutter/widgets/main_text_field/app_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:europharm_flutter/screens/order_finish/ui/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarehousePage extends StatefulWidget {
  final OrderDTO order;
  final bool isScan;
  final PointDTO point;
  final GlobalRepository repository;
  final PointPageStateLoaded? state;

  const WarehousePage({
    Key? key,
    required this.order,
    required this.isScan,
    required this.point,
    required this.repository,
    this.state,
  }) : super(key: key);

  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController pageController;
  int? productId;
  late bool isScan;
  bool isExpansionTileOpen = false;
  String floatingActionButtonText = 'Подтвердить заказ';
  String floatingTextButton = 'Отправить на подпись';
  int? selectedContainerId;
  Map<int, bool> containerSentStatus = {};
  late List<int> completedContainerIds;
  Set<int> successfullySentContainers = {};
  bool isFloatingActionButtonForSignature = false;

  @override
  void initState() {
    super.initState();
    completedContainerIds = [];
    selectedContainerId = null;
    isScan = widget.isScan;
    _tabController = TabController(length: 2, vsync: this);
    pageController = PageController();
    setupTabControllerListener();
  }

  void setupTabControllerListener() {
    if (_tabController == null) {
      return;
    }
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          if (kDebugMode) {
            print(_tabController.index);
          }
        });
      }
    });
  }

  bool areAllContainersSent() {
    final containers = widget.state!.orderPoint.containers ?? [];
    return containers.every((container) => successfullySentContainers.contains(container.containerId));
  }

  Future<List<int>?> loadCompletedContainerIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('completedContainerIds')?.map(int.parse).toList();
    return ids;
  }

  bool shouldEnableConfirmButton(PointPageStateLoaded state) {
    final containers = state.orderPoint.containers ?? [];
    return containers.every((container) => successfullySentContainers.contains(container.containerId));
  }

  void _handleContainerSelection(int containerId, String code) {
    final isANGContainer = code != null ? code.contains("ANG") : false;

    if (selectedContainerId == containerId) {
      setState(() {
        selectedContainerId = null;
        floatingActionButtonText = 'Подтвердить заказ';
      });
    } else {
      setState(() {
        selectedContainerId = containerId;
        floatingActionButtonText = isANGContainer ? 'Отсканировать' : 'Подтвердить заказ';
      });
    }
    // При выборе контейнера, считаем его неподтвержденным
    successfullySentContainers.remove(containerId);

    print('Выбран контейнер с id: $containerId и code: $code');
    print('Текущий выбор: selectedContainerId = $selectedContainerId');
  }

  void _handleConfirmOrder(BuildContext context, int? containerId, String? code) async {
    if (containerId == null || code == null) {
      // Некорректные данные, ничего не делаем
      return;
    }

    try {
      showLoadingDialog(context);

      final containerKey = 'container_$containerId';

      // Если контейнер еще не был отправлен
      if (!successfullySentContainers.contains(containerId)) {
        await _sendContainerRequest(context, containerId, code);

        final pointPageBloc = BlocProvider.of<PointPageBloc>(context);
        pointPageBloc.updateContainerState(containerId, code, isScanned: true);

        Navigator.pop(context);
        showSuccessDialog(context);

        // Помечаем контейнер как отправленный
        successfullySentContainers.add(containerId);
        print('Запрос для контейнера с container_id: $containerId был успешно отправлен.');
      } else {
        // Контейнер уже был отправлен
        Navigator.pop(context);
        showPreviouslySentDialog(context);
        print('Запрос для контейнера с container_id: $containerId уже был успешно отправлен ранее.');
      }
    } catch (e) {
      Navigator.pop(context);
      showErrorDialog(context);
      print('Произошла ошибка при отправке запроса для контейнера с container_id: $containerId. Ошибка: $e');
    }
  }

  // Future<void> saveCompletedContainerIds(List<int> completedIds) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('completedContainerIds', completedIds.map((id) => id.toString()).toList());
  // }

  // This function sends the container request
  Future<void> _sendContainerRequest(BuildContext context, int containerId, String code) async {
    try {
      // Send the container request using widget.repository.acceptContainerOrder
      // await widget.repository.acceptContainerOrder(containerId, code);

      // Обновите состояние контейнера после подтверждения
      final pointPageBloc = BlocProvider.of<PointPageBloc>(context);
      pointPageBloc.updateContainerState(containerId, code, isScanned: true);
      setState(() {
        containerSentStatus[containerId] = true;
      });
    } catch (e) {
      // Handle any errors that occur during the request
      // You can display an error message or take other actions here
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AppLoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "${widget.point.name} в ${widget.point.from}",
              style: ProjectTextStyles.ui_16Medium,
            ),
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/images/svg/arrow_back.svg",
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: ColorPalette.white,
          body: SafeArea(
            child: BlocConsumer<PointPageBloc, PointPageState>(
              listener: (context, state) {
                if (state is PointPageStateLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (state is PointPageStateFinished) {
                  AppRouter.pushReplacement(
                    context,
                    const SuccessOrderFinished(),
                  );

                  BlocProvider.of<OrderDetailBloc>(context)
                      .add(OrderDetailRefreshEvent(
                    orderId: widget.order.id,
                  ));
                }

                if (state is PointPageStateError) {
                  showAppDialog(
                    context,
                    title: state.error.message,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  );
                }
              },

              buildWhen: (p, c) => c is PointPageStateLoaded,
              builder: (context, state) {
                if (state is PointPageStateLoaded) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MapSection(
                        order: widget.order,
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.startDate != null
                                      ? DateFormat("dd MMMM, HH:mm")
                                      .format(widget.order.startDate!)
                                      : "",
                                  style: ProjectTextStyles.ui_12Medium.copyWith(
                                    color: ColorPalette.commonGrey,
                                  ),
                                ),
                                Text(
                                  "#0000000${widget.order.id}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('', style: ProjectTextStyles.ui_12Medium),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isFloatingActionButtonForSignature = !isFloatingActionButtonForSignature;
                                    });
                                  },
                                  child: Text(isFloatingActionButtonForSignature
                                      ? 'Отменить отправку на подпись'
                                      : 'Отправить на подпись',
                                    style: TextStyle(
                                      color: isFloatingActionButtonForSignature ? Colors.red : Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 60),
                          child: state.orderPoint.containers != null &&
                              state.orderPoint.containers!.isNotEmpty
                              ? ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.orderPoint.containers!.length,
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 8,
                            ), //state.orderPoint.products?.length,
                            itemBuilder: (context, index) {
                              final container = state.orderPoint.containers![index];
                              final code = container.code;
                              final pointId = container.containerId;
                              final isSent = successfullySentContainers.contains(pointId);
                              final isANGContainer = code != null && code.contains("ANG") && pointId != null;
                              final isScannedOrStatus = container.isScanned || container.status == 1;
                              // Проверяем, содержит ли код "ANG"
                              // Если code не содержит "ANG", то показываем ElevatedButton
                              final shouldShowButton = !isANGContainer && !container.isScanned;
                              // final bool isSent = containerSentStatus[pointId] ?? false;

                              return InkWell(
                                onTap: () {
                                  if (shouldShowButton) {
                                    _handleContainerSelection(
                                      container.containerId!.toInt(),
                                      container.code.toString(),
                                    );
                                  } else {
                                    // Если пользователь нажимает на контейнер с "ANG", сбросить выбор.
                                    setState(() {
                                      selectedContainerId = null;
                                      floatingActionButtonText;
                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: shouldShowButton
                                        ? (state.orderPoint.containers?[index].containerId == productId) == true
                                        ? ColorPalette.main.withOpacity(0.1)
                                        : null
                                        : null, // Устанавливаем null, чтобы не было цвета у контейнера
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(9),
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: ColorPalette.orange.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/svg/box.svg",
                                              color: ColorPalette.orange,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            code ?? "No data",
                                            style: ProjectTextStyles.ui_14Medium.copyWith(
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                      if (isScannedOrStatus || isSent)
                                        SvgPicture.asset(
                                          "assets/images/svg/ic_check.svg",
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                              : const Center(
                            child: Text('Товаров нет'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isFloatingActionButtonForSignature
                  ? GestureDetector(
                onTap: () {
                  BlocProvider.of<PointPageBloc>(context).add(
                    PointPageEventFinishingPoint(
                      pointId: widget.point.id,
                      containers: widget.point.containers ?? [],
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        "Отправить на подпись",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  : SizedBox(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BlocBuilder<PointPageBloc, PointPageState>(
                    builder: (context, state) {
                      if (state is PointPageStateLoaded &&
                          (state.orderPoint.status != "Завершен")) {
                        return SizedBox(
                          height: 70,
                          child: GestureDetector(
                            onTap: () {
                              if (selectedContainerId != null &&
                                  floatingActionButtonText == 'Подтвердить заказ') {
                                final selectedContainer = state.orderPoint
                                    .containers!
                                    .firstWhere(
                                      (container) =>
                                  container.containerId == selectedContainerId,
                                  orElse: null,
                                );

                                if (selectedContainer != null) {
                                  _handleConfirmOrder(
                                    context,
                                    selectedContainer.containerId!,
                                    selectedContainer.code!,
                                  );
                                }
                              } else if (selectedContainerId == null) {
                                AppRouter.push(
                                  context,
                                  ScanChoosePage(
                                    order: widget.order,
                                    pointPageBloc: BlocProvider.of<PointPageBloc>(context),
                                    repository: context.read<GlobalRepository>(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedContainerId == null
                                    ? Colors.black87 // Цвет фона для "Отсканировать"
                                    : Colors.green, // Цвет фона для "Принять и подписать"
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    selectedContainerId == null
                                        ? "Отсканировать"
                                        : floatingActionButtonText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapSection extends StatelessWidget {
  final OrderDTO order;

  const MapSection({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: ColorPalette.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              MapWidget(order: order),
              LiveStatusIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class LiveStatusIndicator extends StatelessWidget {
  const LiveStatusIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 5,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4.5,
          horizontal: 8,
        ),
        child: Row(
          children: [
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                color: ColorPalette.red,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "LIVE",
              style: ProjectTextStyles.ui_12Medium,
            ),
          ],
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final OrderDTO order;

  const MapWidget({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(
        mapRepository: MapRepository(),
        repository: context.read<GlobalRepository>(),
      ),
      child: SessionPage(
        orderId: order.id,
        order: order,
        orderPoints: const [], // TODO
      ),
    );
  }
}

void showCreatePasswordBottomDialog(BuildContext context, int productId) {
  showAppBottomSheet(
    context,
    initialChildSize: 0.45,
    useRootNavigator: true,
    child: ScanMethodChooser(
      onScan: (code) {
        context.read<PointPageBloc>().add(
          PointPageEventProductFinish(
            productId: productId,
            code: code.toString(),
          ),
        );
      },
    ),
  );
}

class ScanMethodChooser extends StatelessWidget {
  final Function onScan;

  const ScanMethodChooser({required this.onScan, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          const Text(
            "Выберите способ сканирования",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 25),
          ScanMethodButton(
            title: "Сфотографировать",
            onTap: () async {
              // Здесь можно добавить код для сканирования фотографией
              final barcode = "123456"; // Пример результата сканирования
              onScan.call(barcode);
            },
          ),
          const SizedBox(height: 25),
          ScanMethodButton(
            title: "Ручной сканнер",
            onTap: () {
              // Здесь можно добавить код для ручного сканирования
              final barcode = "789012"; // Пример результата сканирования
              onScan.call(barcode);
            },
          ),
        ],
      ),
    );
  }
}

class ScanMethodButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ScanMethodButton({required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
    );
  }
}

// class _BuildScanMethodChoose extends StatelessWidget {
//   final Function onScan;
//
//   const _BuildScanMethodChoose({Key? key, required this.onScan})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               "Выберите способ сканирования",
//               style: ProjectTextStyles.ui_16Medium.copyWith(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           GestureDetector(
//             onTap: () async {
//               Navigator.pop(context);
//               String barcode = await FlutterBarcodeScanner.scanBarcode(
//                 '#ff6666',
//                 'Cancel',
//                 true,
//                 ScanMode.BARCODE,
//               );
//
//               if (barcode.isNotEmpty) {
//                 // ignore: use_build_context_synchronously
//                 Navigator.pop(context, barcode);
//                 onScan.call(barcode);
//                 // blocContext.read<BlocOrderFinish>().add(EventOrderProductFinish(
//                 //     productId: productId, code: barcode));
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: ColorPalette.main,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   "Сфотографировать",
//                   style: ProjectTextStyles.ui_16Medium.copyWith(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//               showBarcodeEnterDialog(context, onScan);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: ColorPalette.main,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   "Ручной сканнер",
//                   style: ProjectTextStyles.ui_16Medium.copyWith(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

void showBarcodeEnterDialog(BuildContext context, Function onScan) {
  showAppBottomSheet(
    context,
    initialChildSize: 0.45,
    useRootNavigator: true,
    child: BarcodeEnterDialog(onScan: onScan),
  );
}

class BarcodeEnterDialog extends StatelessWidget {
  final Function onScan;

  const BarcodeEnterDialog({required this.onScan, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          const Text(
            "Введите код",
            style: ProjectTextStyles.ui_20Medium,
          ),
          const SizedBox(height: 20),
          BarcodeEnterField(onScan: onScan),
        ],
      ),
    );
  }
}

class BarcodeEnterField extends StatefulWidget {
  final Function onScan;

  const BarcodeEnterField({required this.onScan, Key? key}) : super(key: key);

  @override
  _BarcodeEnterFieldState createState() => _BarcodeEnterFieldState();
}

class _BarcodeEnterFieldState extends State<BarcodeEnterField> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Введите код",
          style: ProjectTextStyles.ui_20Medium,
        ),
        const SizedBox(height: 20),
        AppTextField(
          controller: controller,
          hintStyle: ProjectTextStyles.ui_16Medium.copyWith(
            color: ColorPalette.commonGrey,
          ),
        ),
        const SizedBox(height: 20),
        MainButton(
          title: "Подтвердить",
          onTap: () {
            Navigator.pop(context, controller.text);
            widget.onScan(controller.text);
          },
        ),
      ],
    );
  }
}


class _BuildBarcodeEnterField extends State<BuildBarcodeEnterField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Введите код",
            style: ProjectTextStyles.ui_20Medium,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            controller: controller,
            hintStyle: ProjectTextStyles.ui_16Medium.copyWith(
              color: ColorPalette.commonGrey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            title: "Подтвердить",
            onTap: () {
              Navigator.pop(context, controller.text);
              widget.onScan(controller.text);
            },
          )
        ],
      ),
    );
  }
}

// class _BuildScanMethodChoose extends StatelessWidget {
//   final Function onScan;
//
//   const _BuildScanMethodChoose({Key? key, required this.onScan})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               "Выберите способ сканирования",
//               style: ProjectTextStyles.ui_16Medium.copyWith(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           GestureDetector(
//             onTap: () async {
//               Navigator.pop(context);
//               String barcode = await FlutterBarcodeScanner.scanBarcode(
//                 '#ff6666',
//                 'Cancel',
//                 true,
//                 ScanMode.BARCODE,
//               );
//
//               if (barcode.isNotEmpty) {
//                 Navigator.pop(context, barcode);
//                 onScan.call(barcode);
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: ColorPalette.main,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   "Сфотографировать",
//                   style: ProjectTextStyles.ui_16Medium.copyWith(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//               showBarcodeEnterDialog(context, onScan);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: ColorPalette.main,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   "Ручной сканнер",
//                   style: ProjectTextStyles.ui_16Medium.copyWith(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void showBarcodeEnterDialog(BuildContext context, Function onScan) {
//   showAppBottomSheet(
//     context,
//     initialChildSize: 0.45,
//     useRootNavigator: true,
//     child: BuildBarcodeEnterField(onScan: onScan),
//   );
// }
//
// class BuildBarcodeEnterField extends StatefulWidget {
//   final Function onScan;
//
//   const BuildBarcodeEnterField({Key? key, required this.onScan})
//       : super(key: key);
//
//   @override
//   State<BuildBarcodeEnterField> createState() => _BuildBarcodeEnterField();
// }
//
// class _BuildBarcodeEnterField extends State<BuildBarcodeEnterField> {
//   TextEditingController controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 10,
//       ),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "Введите код",
//             style: ProjectTextStyles.ui_20Medium,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           AppTextField(
//             controller: controller,
//             hintStyle: ProjectTextStyles.ui_16Medium.copyWith(
//               color: ColorPalette.commonGrey,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           MainButton(
//             title: "Подтвердить",
//             onTap: () {
//               Navigator.pop(context, controller.text);
//               widget.onScan(controller.text);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

/*
floatingActionButton: Container(
            margin: EdgeInsets.all(10),
            width: double.infinity, // Сделаем кнопку максимально широкой
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (isExpansionTileOpen) {
                    // Выполните действия для случая, когда ExpansionTile открыт
                    // Например, показать сообщение о подтверждении заказа
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка при отправке запроса на сервер')),
                    );
                  } else {
                    // Выполните действия для случая, когда ExpansionTile закрыт
                    // Например, выполнить подтверждение заказа
                    // и изменить текст кнопки на "Заказ подтверждён"
                    _handleConfirmOrder;
                  }
                });
              },
              backgroundColor: isExpansionTileOpen
                ? Colors.green // Цвет фона при тексте "Заказ подтверждён"
                : Colors.black87, // Тёмный цвет фона
              foregroundColor: Colors.white, // Белый цвет для текста и иконки
              label: Text(
                isExpansionTileOpen ? 'Подтвердить заказ' : 'Выберите контейнер',
                style: ProjectTextStyles.ui_16Medium.copyWith(
                  color: ColorPalette.white,
                ), // Размер шрифта
              ),
              icon: isExpansionTileOpen
                  ? Icon(Icons.check) // Иконка для "Заказ подтверждён"
                  : Icon(Icons.arrow_forward),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Радиус границ
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
 */

