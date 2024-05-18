// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:formanimal/models/case_animal_model.dart';

import 'package:formanimal/models/swine_code_model.dart';
import 'package:formanimal/utility/app_controller.dart';
import 'package:formanimal/utility/app_service.dart';
import 'package:formanimal/widgets/widget_button.dart';
import 'package:formanimal/widgets/widget_form.dart';
import 'package:formanimal/widgets/widget_icon_button.dart';
import 'package:formanimal/widgets/widget_text.dart';
import 'package:formanimal/widgets/widget_text_rich.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class DisplayDetail extends StatefulWidget {
  const DisplayDetail({
    Key? key,
    required this.swineCodeModel,
  }) : super(key: key);

  final SwineCodeModel swineCodeModel;

  @override
  State<DisplayDetail> createState() => _DisplayDetailState();
}

class _DisplayDetailState extends State<DisplayDetail> {
  AppController appController = Get.put(AppController());

  final keyForm = GlobalKey<FormState>();

  var cases = <String>[];

  @override
  void initState() {
    super.initState();

    appController.display.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetTextRich(
            head: 'swinecode', value: widget.swineCodeModel.swinecode),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: keyForm,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetTextRich(
                      head: 'วันที่ (Start Time)',
                      value: AppService()
                          .changeTimeToString(dateTime: DateTime.now())),
                  WidgetIconButton(icon: Icons.date_range, onPressed: () {  },)
                ],
              ),
              const SizedBox(height: 8),
              WidgetTextRich(
                  head: 'อายุ', value: widget.swineCodeModel.birthdate),
              const SizedBox(height: 8),
              WidgetTextRich(
                  head: 'Farm', value: widget.swineCodeModel.farmfarmcode),
              const SizedBox(height: 8),
              WidgetForm(
                validator: (p0) {
                  if (p0?.isEmpty ?? true) {
                    return 'กรุณากรอก คอก ด้วยคะ';
                  } else {
                    return null;
                  }
                },
                labelText: 'คอก :',
              ),
              const SizedBox(height: 8),
              FutureBuilder(
                future: AppService().readCaseAnimal(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (appController.chooseCaseAnimals.isNotEmpty) {
                      appController.chooseCaseAnimals.clear();
                    }

                    List<CaseAnimalModel>? caseAnimalModels = snapshot.data;
                    for (var element in caseAnimalModels!) {
                      appController.chooseCaseAnimals.add(false);

                      cases.add(element.caseAnimal);
                    }

                    return Obx(
                      () {
                        print(
                            'chooseCaseAnimal ---> ${appController.chooseCaseAnimals.length}');
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.builder(
                              itemCount: caseAnimalModels.length,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => SizedBox(
                                width: Get.width * 0.8,
                                child: CheckboxListTile(
                                  value: appController.chooseCaseAnimals[index],
                                  onChanged: (value) {
                                    appController.chooseCaseAnimals[index] =
                                        value;
                                  },
                                  title: WidgetText(
                                      data: caseAnimalModels[index].caseAnimal),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                            ),
                            appController.display.value
                                ? const WidgetText(
                                    data: 'กรุณาเลือก อาการ อย่างน้อย 1 รายการ',
                                    style: TextStyle(color: GFColors.DANGER),
                                  )
                                : const SizedBox(),
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: WidgetButton(
        text: 'Finish',
        onPressed: () {
          appController.display.value = true;

          if (appController.chooseCaseAnimals.contains(true)) {
            appController.display.value = false;
          }

          if (keyForm.currentState!.validate()) {
            if (!appController.display.value) {
              //ข้อมูลพร้อม

              String swineCode = widget.swineCodeModel.swinecode;
              String farmFarmCode = widget.swineCodeModel.farmfarmcode;
              String age = widget.swineCodeModel.birthdate;
              var listCaseAnimals =
                  AppService().findListCaseAnimal(cases: cases);

              print('swineCode --> $swineCode');
              print('farmFarmCode --> $farmFarmCode');
              print('age --> $age');
              print('listCaseAnimals --> $listCaseAnimals');
            }
          }
        },
        fullWidthButton: true,
      ),
    );
  }
}
