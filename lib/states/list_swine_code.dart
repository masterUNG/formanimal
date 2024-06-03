import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:formanimal/models/swine_code_model.dart';
import 'package:formanimal/states/display_detail.dart';
import 'package:formanimal/utility/app_constant.dart';
import 'package:formanimal/utility/app_controller.dart';
import 'package:formanimal/utility/app_debouncer.dart';
import 'package:formanimal/utility/app_service.dart';
import 'package:formanimal/widgets/widget_form.dart';
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

  EasyRefreshController? easyRefreshController;

  var searchSwineCodeModels = <SwineCodeModel>[];

  final appDebouncer = AppDebouncer(milliSecond: 500);

  @override
  void initState() {
    super.initState();

    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    AppService().readSwineCode().then(
      (value) {
        for (var element in appController.swineCodeModels) {
          searchSwineCodeModels.add(element);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetForm(
          onChanged: (p0) {
            appDebouncer.run(
              () {
                searchSwineCodeModels.clear();

                for (var element in appController.swineCodeModels) {
                  searchSwineCodeModels.add(element);
                }

                searchSwineCodeModels = searchSwineCodeModels
                    .where(
                      (element) => element.swinecode
                          .toLowerCase()
                          .contains(p0.toLowerCase()),
                    )
                    .toList();

                setState(() {});
              },
            );
          },
          onTap: () {
            appController.displayListSearch.value = true;
          },
          prefixIcon: const Icon(Icons.search),
          hindText: 'Swine Code',
          keyboardType: TextInputType.number,
        ),
      ),
      body: SafeArea(
          child: Obx(() => ((appController.swineCodeModels.isEmpty))
              ? const SizedBox()
              : appController.displayListSearch.value
                  ? ListView.builder(
                      itemCount: searchSwineCodeModels.length,
                      itemBuilder: (context, index) => contentListView(
                          swineCodeModel: searchSwineCodeModels[index]),
                    )
                  : EasyRefresh(
                      controller: easyRefreshController,
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 3)).then(
                          (value) {
                            AppService().readSwineCode();
                            easyRefreshController!.finishRefresh();
                          },
                        );
                      },
                      onLoad: () async {
                        await Future.delayed(const Duration(seconds: 3))
                            .then((value) {
                          appController.amountLoad.value =
                              appController.amountLoad.value + 100;
                          easyRefreshController!.finishLoad();
                        });
                      },
                      child: ListView.builder(
                        itemCount: appController.amountLoad.value,
                        itemBuilder: (context, index) => contentListView(
                            swineCodeModel:
                                appController.swineCodeModels[index]),
                      ),
                    ))),
    );
  }

  InkWell contentListView({required SwineCodeModel swineCodeModel}) {
    return InkWell(
      onTap: () {
        Get.to(DisplayDetail(
          swineCodeModel: swineCodeModel,
        ))?.then(
          (value) {
            setState(() {});
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: AppConstant().cureBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WidgetText(
                  data: swineCodeModel.swinecode,
                  style: AppConstant().h2Style(),
                ),
                FutureBuilder(
                  future: AppService()
                      .readHeatDetaction(swineCode: swineCodeModel.swinecode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var result = snapshot.data;

                      if (result!.isEmpty) {
                        return const SizedBox();
                      } else {
                        return const Icon(Icons.check_box);
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
            WidgetTextRich(
              head: 'OfficeCode',
              value: swineCodeModel.officeofficecode,
            ),
            WidgetTextRich(
              head: 'gendergendercode',
              value: swineCodeModel.gendergendercode,
            ),
            WidgetTextRich(
              head: 'livestockcodelivestockcode',
              value: swineCodeModel.livestockcodelivestockcode,
            ),
          ],
        ),
      ),
    );
  }
}
