// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:formanimal/models/heat_detaction_model.dart';
import 'package:formanimal/models/swine_code_model.dart';
import 'package:formanimal/utility/app_constant.dart';
import 'package:formanimal/utility/app_dialog.dart';
import 'package:formanimal/utility/app_service.dart';
import 'package:formanimal/widgets/widget_button.dart';
import 'package:formanimal/widgets/widget_icon_button.dart';
import 'package:formanimal/widgets/widget_text.dart';
import 'package:formanimal/widgets/widget_text_rich.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class DisplayHeatDetaction extends StatefulWidget {
  const DisplayHeatDetaction({
    Key? key,
    required this.swineCodeModel,
    required this.heatDetactionModels,
  }) : super(key: key);

  final SwineCodeModel swineCodeModel;
  final List<HeatDetactionModel> heatDetactionModels;

  @override
  State<DisplayHeatDetaction> createState() => _DisplayHeatDetactionState();
}

class _DisplayHeatDetactionState extends State<DisplayHeatDetaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetTextRich(
            head: 'SwineCode', value: widget.swineCodeModel.swinecode),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: WidgetText(
              data: 'ข้อมูลทั่วไป :',
              style: AppConstant().h2Style(size: 16),
            ),
          ),
          WidgetTextRich(
              head: 'farmfarmcode', value: widget.swineCodeModel.farmfarmcode),
          WidgetTextRich(
              head: 'officeofficecode',
              value: widget.swineCodeModel.officeofficecode),
          WidgetTextRich(head: 'flock', value: widget.swineCodeModel.flock),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: WidgetText(
              data: 'HeatDaction :',
              style: AppConstant().h2Style(size: 16),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.heatDetactionModels.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: AppConstant().cureBox(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetTextRich(
                          head: 'Id',
                          value: widget.heatDetactionModels[index].id!),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WidgetIconButton(
                            icon: Icons.edit,
                            onPressed: () {},
                            type: GFButtonType.outline2x,
                          ),
                          const SizedBox(width: 4),
                          WidgetIconButton(
                            icon: Icons.delete_forever,
                            onPressed: () {
                              AppDialog().normalDialog(
                                  title: 'Confirm Delete',
                                  content: WidgetText(
                                      data:
                                          'Please Confimr Delete at id = ${widget.heatDetactionModels[index].id}'),
                                  firstAction: WidgetButton(
                                    text: 'Confirm',
                                    onPressed: () {
                                      AppService()
                                          .processDeleteHeatDetactionById(
                                              id: widget
                                                  .heatDetactionModels[index]
                                                  .id!)
                                          .then(
                                        (value) {
                                          Get.back();

                                          widget.heatDetactionModels
                                              .removeAt(index);

                                          if (widget
                                              .heatDetactionModels.isEmpty) {
                                            Get.back();
                                          } else {
                                            setState(() {});
                                          }
                                        },
                                      );
                                    },
                                    type: GFButtonType.outline2x,
                                  ));
                            },
                            color: Colors.red,
                            type: GFButtonType.solid,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetTextRich(
                          head: 'Start',
                          value: widget.heatDetactionModels[index].startTime),
                      WidgetTextRich(
                          head: 'Finish',
                          value: widget.heatDetactionModels[index].finishTime),
                    ],
                  ),
                  WidgetTextRich(
                      head: 'คอก',
                      value: widget.heatDetactionModels[index].pen),
                  WidgetTextRich(
                      head: 'น้ำหนัก',
                      value: widget.heatDetactionModels[index].weight),
                  WidgetTextRich(
                      head: 'เต้านมซ้าย',
                      value: widget.heatDetactionModels[index].breastLeft),
                  WidgetTextRich(
                      head: 'เต้านมขวา',
                      value: widget.heatDetactionModels[index].breastRight),
                  WidgetText(
                    data: 'Case :',
                    style: AppConstant().h2Style(size: 15),
                  ),

                  FutureBuilder(
                    future: AppService().changeStringToArray(
                        string:
                            widget.heatDetactionModels[index].listCaseAnimals),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index2) => Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: WidgetText(data: snapshot.data![index2]),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )

                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: const ScrollPhysics(),
                  //   itemCount:
                  //       heatDetactionModels[index].listCaseAnimals.length,
                  //   itemBuilder: (context, index2) => WidgetText(data: 'data'),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
