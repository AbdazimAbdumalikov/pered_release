import 'package:europharm_flutter/screens/order_card/bloc/order_detail_bloc.dart';
import 'package:europharm_flutter/screens/order_card/ui/accident.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

List<String> items = [
  "Перекус - 3 раза в сутки",
  "Сон - 1 раз в сутки",
  "Перерыв на 15 минут - 3 раз в сутки",
  "Другая причина",
  "Передаю заказ другому водителю",
  "Сообщить о ДТП!"
];

class BuildCauses extends StatefulWidget {
  const BuildCauses({Key? key}) : super(key: key);

  @override
  State<BuildCauses> createState() => _BuildCausesState();
}

class _BuildCausesState extends State<BuildCauses> {
  final TextEditingController accidentMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    accidentMessageController.dispose();
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
          const Center(
            child: Text(
              "Выберите причину остановки",
              style: ProjectTextStyles.ui_20Medium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorPalette.lightGrey,
            ),
            child: Text(
              "Частые опции",
              style: ProjectTextStyles.ui_12Medium
                  .copyWith(color: ColorPalette.darkGrey),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(items[index]);
                },
                child: _BuildItem(
                  item: items[index],
                  isRedBackground: items[index] == "Сообщить о ДТП!",
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: ColorPalette.lightGrey,
              );
            },
            itemCount: items.length,
          ),
        ],
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  final String item;
  final bool isRedBackground;

  const _BuildItem({Key? key, required this.item, this.isRedBackground = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isRedBackground ? Colors.red : null,
        borderRadius: isRedBackground ? BorderRadius.circular(8.0) : null, // Применяем круглый угол для красного фона
      ),
      child: SizedBox(
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Добавляем отступы для текста
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isRedBackground ? Colors.white : Colors.black, // Задаем цвет текста
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (isRedBackground)
              Container(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
              )
            else
              SvgPicture.asset("assets/images/svg/chevrone_right.svg"),
          ],
        ),
      ),
    );
  }
}