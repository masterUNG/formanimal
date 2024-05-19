import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:formanimal/models/case_animal_model.dart';
import 'package:formanimal/models/heat_detaction_model.dart';
import 'package:formanimal/models/swine_code_model.dart';
import 'package:formanimal/utility/app_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppService {
  AppController appController = Get.put(AppController());

  String changeTimeToString({required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat('yy-MM-dd HH:mm');
    String result = dateFormat.format(dateTime);
    return result;
  }

  Future<void> readSwineCode() async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungdata/getSwineCode.php';

    await Dio().get(urlApi).then((value) async {
      // print('value ---> $value');

      for (var element in json.decode(value.data)) {
        SwineCodeModel swineCodeModel = SwineCodeModel.fromMap(element);
        appController.swineCodeModels.add(swineCodeModel);

        // String urlApiGetHeatDetactionWhereSwineCodeUng =
        //     'https://www.androidthai.in.th/fluttertraining/ungdata/getHeatDetactionWhereSwineCodeUng.php?isAdd=true&swineCode=${swineCodeModel.swinecode}';

        // await Dio().get(urlApiGetHeatDetactionWhereSwineCodeUng).then(
        //   (value) {
        //     if (value.toString() == 'null') {
        //       appController.checkSwineCodes.add(false);
        //     } else {
        //       appController.checkSwineCodes.add(true);
        //     }
        //   },
        // );
      }
    });
  }

  Future<List<HeatDetactionModel>> readHeatDetaction(
      {required String swineCode}) async {
    var heatDetactionModels = <HeatDetactionModel>[];

    String urlApiGetHeatDetactionWhereSwineCodeUng =
        'https://www.androidthai.in.th/fluttertraining/ungdata/getHeatDetactionWhereSwineCodeUng.php?isAdd=true&swineCode=$swineCode';

    var resut = await Dio().get(urlApiGetHeatDetactionWhereSwineCodeUng);

    if (resut.toString() != 'null') {
      for (var element in json.decode(resut.data)) {
        HeatDetactionModel heatDetactionModel =
            HeatDetactionModel.fromMap(element);
        heatDetactionModels.add(heatDetactionModel);
      }
    }
    return heatDetactionModels;
  }

  Future<List<CaseAnimalModel>> readCaseAnimal() async {
    var caseAnimalModels = <CaseAnimalModel>[];

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungdata/getCaseAnimalUng.php';

    var result = await Dio().get(urlApi);

    for (var element in json.decode(result.data)) {
      CaseAnimalModel model = CaseAnimalModel.fromMap(element);
      caseAnimalModels.add(model);
    }

    return caseAnimalModels;
  }

  List<String> findListCaseAnimal({required List<String> cases}) {
    var result = <String>[];

    for (var i = 0; i < cases.length; i++) {
      if (appController.chooseCaseAnimals[i]) {
        result.add(cases[i]);
      }
    }

    return result;
  }

  Future<void> processInsertHeatDetaction(
      {required HeatDetactionModel heatDetactionModel}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungdata/insertHeatDetactionJi.php?isAdd=true&swineCode=${heatDetactionModel.swineCode}&farmFarmCode=${heatDetactionModel.farmFarmCode}&age=${heatDetactionModel.age}&listCaseAnimals=${heatDetactionModel.listCaseAnimals}&startTime=${heatDetactionModel.startTime}&finishTime=${heatDetactionModel.finishTime}&recorder=${heatDetactionModel.recorder}&inspector=${heatDetactionModel.inspector}&weight=${heatDetactionModel.weight}&breastLeft=${heatDetactionModel.breastLeft}&breastRight=${heatDetactionModel.breastRight}&pen=${heatDetactionModel.pen}';

    await Dio().get(urlApi).then((onValue) => Get.back());
  }
}
