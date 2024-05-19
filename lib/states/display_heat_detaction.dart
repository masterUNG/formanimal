// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:formanimal/models/heat_detaction_model.dart';
import 'package:formanimal/models/swine_code_model.dart';
import 'package:formanimal/utility/app_constant.dart';
import 'package:formanimal/utility/app_service.dart';
import 'package:formanimal/widgets/widget_text.dart';
import 'package:formanimal/widgets/widget_text_rich.dart';

class DisplayHeatDetaction extends StatelessWidget {
  const DisplayHeatDetaction({
    Key? key,
    required this.swineCodeModel,
    required this.heatDetactionModels,
  }) : super(key: key);

  final SwineCodeModel swineCodeModel;
  final List<HeatDetactionModel> heatDetactionModels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            WidgetTextRich(head: 'SwineCode', value: swineCodeModel.swinecode),
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
              head: 'farmfarmcode', value: swineCodeModel.farmfarmcode),
          WidgetTextRich(
              head: 'officeofficecode', value: swineCodeModel.officeofficecode),
          WidgetTextRich(head: 'flock', value: swineCodeModel.flock),
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
            itemCount: heatDetactionModels.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: AppConstant().cureBox(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetTextRich(
                      head: 'Id', value: heatDetactionModels[index].id!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetTextRich(
                          head: 'Start',
                          value: heatDetactionModels[index].startTime),
                      WidgetTextRich(
                          head: 'Finish',
                          value: heatDetactionModels[index].finishTime),
                    ],
                  ),
                  WidgetTextRich(
                      head: 'คอก', value: heatDetactionModels[index].pen),
                  WidgetTextRich(
                      head: 'น้ำหนัก',
                      value: heatDetactionModels[index].weight),
                  WidgetTextRich(
                      head: 'เต้านมซ้าย',
                      value: heatDetactionModels[index].breastLeft),
                  WidgetTextRich(
                      head: 'เต้านมขวา',
                      value: heatDetactionModels[index].breastRight),
                  WidgetText(
                    data: 'Case :',
                    style: AppConstant().h2Style(size: 15),
                  ),

                  FutureBuilder(
                    future: AppService().changeStringToArray(
                        string: heatDetactionModels[index].listCaseAnimals),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index2) =>
                              Padding(
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
