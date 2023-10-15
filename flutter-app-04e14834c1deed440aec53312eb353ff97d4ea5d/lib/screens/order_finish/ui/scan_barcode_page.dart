import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:europharm_flutter/screens/order_finish/bloc/point_page_bloc.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/camera/camera_shape.dart';
import 'package:europharm_flutter/widgets/snackbar/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

class ScanBarcodePage extends StatefulWidget {
  final GlobalRepository repository;
  final PointPageBloc pointPageBloc;
  const ScanBarcodePage({Key? key, required this.pointPageBloc, required this.repository})
      : super(key: key);

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends State<ScanBarcodePage> {
  MobileScannerController controller = MobileScannerController();
  List<String> codes = [];
  List<bool> isSuccessForSendList = [];
  List<String> successfullySentCodes = [];
  final assetsAudioPlayer = AssetsAudioPlayer();
  final canVibrate = Haptics.canVibrate();

  @override
  void initState() {
    super.initState();
    loadData(); // Загрузка данных при запуске
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('codes', codes);
    await prefs.setStringList('isSuccessForSendList', isSuccessForSendList.map((bool value) => value.toString()).toList());
    await prefs.setStringList('successfullySentCodes', successfullySentCodes);
  }

// Загрузка данных
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      codes = prefs.getStringList('codes') ?? [];
      isSuccessForSendList = (prefs.getStringList('isSuccessForSendList') ?? [])
          .map((String value) => value == 'true')
          .toList();
      successfullySentCodes = prefs.getStringList('successfullySentCodes') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    theme: ThemeData(useMaterial3: true);
    return MaterialApp(
        home: BlocProvider.value(
          value: widget.pointPageBloc,
          child: BlocConsumer<PointPageBloc, PointPageState>(
            listener: (context, state) async {
              if (state is PointPageStateError) {
                showAppDialog(
                  context,
                  title: state.error.message,
                  onTap: () => Navigator.pop(context),
                );
              }
              if (state is PointPageStateLoaded) {
                //Navigator.pop(context);
                showCustomSnackbar(
                  context,
                  'Успешно отсканировано!',
                  color: ColorPalette.green,
                );
                assetsAudioPlayer.open(
                  Audio("assets/sound/done.mp3"),
                );
              }
              if (state is PointPageStateContainerAccepted) {
                showCustomSnackbar(
                  context,
                  'Отправлен на сервер! $codes',
                    color: Colors.blue,
                );
              }
              if (state is PointPageStateContainerAccepted) {
                assetsAudioPlayer.open(
                  Audio("assets/sound/done.mp3"),
                );
                await Haptics.vibrate(HapticsType.success);
              }
              if (state is PointPageStateError) {
                showCustomSnackbar(
                  context,
                  'Ошибка!',
                  color: Colors.red,
                );
                assetsAudioPlayer.open(
                  Audio("assets/sound/error.mp3"),
                );
                await Haptics.vibrate(HapticsType.warning);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                        } else {
                          final String code = barcode.rawValue!;
                          log("BARCODE CODE::::: $code");
                          if (!codes.contains(code)) {
                            codes.add(code);
                            BlocProvider.of<PointPageBloc>(context)
                                .add(PointPageEventScanBarcode(code: code));
                            // controller.stop();
                            // context
                            //     .read<BlocGoodsList>()
                            //     .add(EventScanItem(code: code));
                          }
                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: CameraShaper(
                          paintHeight: MediaQuery.of(context).size.width - 200,
                          paintWidth: MediaQuery.of(context).size.width - 200,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height / 4,
                      child: const Center(
                        child: Text(
                          'Отсканируйте штрих код на обороте коробки',
                          style: TextStyle(color: ColorPalette.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/svg/arrow_back.svg",
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Text(
                                "ФОТО",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/svg/thunder_lightning_notifications.svg",
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.toggleTorch();
                                },
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      showBottomSheetWithScannedCodes(context, codes, widget.repository);
                    },
                    label: Text('Количество сканированных ${codes.length}'),
                    icon: Icon(Icons.check_box, color: Colors.indigoAccent,),
              ),
              );
            },
          ),
        ),
    );
  }
  void showBottomSheetWithScannedCodes(BuildContext scaffoldContext, List<String> codes, repository) {
    isSuccessForSendList = List.generate(codes.length, (index) => false);
    List<String> codesToSend = codes.where((code) => !successfullySentCodes.contains(code)).toList();

    if (codesToSend.isEmpty) {
      // Если нет новых штрихкодов для отправки, покажите уведомление
      showCustomSnackbar(
        context,
        'Нет новых штрихкодов для отправки',
        color: ColorPalette.green,
      );
      return;
    }

    showModalBottomSheet(
      context: scaffoldContext, // Используйте контекст Scaffold
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      children: <Widget>[
                        if (codes.isEmpty)
                          Center(
                            child: Text(
                              'Список пуст',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        else
                          SizedBox(height: 16), // Добавим небольшой отступ
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: codes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final code = codes[index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(code),
                                  if (isSuccessForSendList[index])
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorPalette.green,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.lightGreen,
                                        size: 24,
                                      ),
                                    ),
                                ],
                              ),
                              onTap: () async {
                                // try {
                                //   await widget.repository.acceptContainerOrderScan(code);
                                //   setState(() {
                                //     isSuccessForSendList[index] = true;
                                //   });
                                //   showCustomSnackbar(
                                //     context,
                                //     'Запрос успешно отправлен на сервер $code',
                                //     color: ColorPalette.green,
                                //   );
                                //   assetsAudioPlayer.open(
                                //     Audio("assets/sound/done.mp3"),
                                //   );
                                // } catch (e) {
                                //   showCustomSnackbar(
                                //     context,
                                //     'Ошибка при отправке запроса: $e',
                                //     color: ColorPalette.red,
                                //   );
                                //   print("Ошибка при отправке запроса на сервер $e");
                                // }
                              },
                            );
                          },
                        ),
                      ],
                  ),
              ),
              // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Расположение в нижнем правом углу
              // floatingActionButton: FloatingActionButton.extended( // Более стильная иконка с текстом
              //   onPressed: () async {
              //     try {
              //       for (String code in codes) {
              //         await widget.repository.acceptContainerOrderScan(code);
              //         setState(() {
              //           isSuccessForSendList[codes.indexOf(code)] = true;
              //         });
              //       }
              //
              //       showCustomSnackbar(
              //         context,
              //         'Все штрихкоды успешно отправлены на сервер',
              //         color: ColorPalette.green,
              //       );
              //       saveData();
              //     } catch (e) {
              //       showCustomSnackbar(
              //         context,
              //         'Ошибка при отправке штрихкодов: $e',
              //         color: ColorPalette.red,
              //       );
              //       print("Ошибка при отправке штрихкодов на сервер: $e");
              //     }
              //   },
              //   icon: Icon(Icons.send), // Иконка
              //   label: Text('Отправить все'), // Текст
              // ),
            );
          },
        );
      },
    );
  }
}