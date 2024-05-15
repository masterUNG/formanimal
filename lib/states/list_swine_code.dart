import 'package:flutter/material.dart';
import 'package:formanimal/utility/app_constant.dart';
import 'package:formanimal/utility/app_controller.dart';
import 'package:formanimal/utility/app_service.dart';
import 'package:formanimal/widgets/widget_text.dart';
import 'package:formanimal/widgets/widget_text_rich.dart';
import 'package:get/get.dart';

class ListSwineCode extends StatefulWidget {
  const ListSwineCode({
    super.key,
  });

  @override
  State<ListSwineCode> createState() => _ListSwineCodeState();
}

class _ListSwineCodeState extends State<ListSwineCode> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().readSwineCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => appController.swineCodeModels.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  itemCount: appController.amountLoad.value,
                  itemBuilder: (context, index) => Container(padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    decoration: AppConstant().cureBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetText(
                            data: appController.swineCodeModels[index].swinecode
                                .toString()),
                        WidgetTextRich(
                          head: 'OfficeCode',
                          value: appController
                              .swineCodeModels[index].officeofficecode,
                        ),
                        WidgetTextRich(
                          head: 'gendergendercode',
                          value: appController
                              .swineCodeModels[index].gendergendercode,
                        ),
                        WidgetTextRich(
                          head: 'livestockcodelivestockcode',
                          value: appController.swineCodeModels[index]
                              .livestockcodelivestockcode,
                        ),
                      ],
                    ),
                  ),
                ))),
    );
  }
}
