import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:formanimal/models/case_animal_model.dart';
import 'package:formanimal/models/heat_detaction_model.dart';
import 'package:formanimal/models/swine_code_model.dart';
import 'package:formanimal/states/list_swine_code.dart';
import 'package:formanimal/utility/app_constant.dart';
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
        '${AppConstant.domain}getSwineCode.php';

    await Dio().get(urlApi).then((value) async {
      // print('value ---> $value');

      for (var element in json.decode(value.data)) {
        SwineCodeModel swineCodeModel = SwineCodeModel.fromMap(element);
        appController.swineCodeModels.add(swineCodeModel);
      }
    });
  }

  Future<List<HeatDetactionModel>> readHeatDetaction(
      {required String swineCode}) async {
    var heatDetactionModels = <HeatDetactionModel>[];

    String urlApiGetHeatDetactionWhereSwineCodeUng =
        '${AppConstant.domain}getHeatDetactionWhereSwineCodeUng.php?isAdd=true&swineCode=$swineCode';

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

    if (appController.caseAnimals.isNotEmpty) {
      appController.caseAnimals.clear();
    }

    String urlApi =
        '${AppConstant.domain}getCaseAnimalJi.php';

    var result = await Dio().get(urlApi);

    for (var element in json.decode(result.data)) {
      CaseAnimalModel model = CaseAnimalModel.fromMap(element);
      caseAnimalModels.add(model);

      appController.caseAnimals.add(model.caseAnimal);
    }

    return caseAnimalModels;
  }

  List<String> findListCaseAnimal({required List<String> cases}) {
    var result = <String>[];

    for (var i = 0; i < cases.length; i++) {
      if (appController.chooseCaseAnimals[i]) {
        result.add(cases[i]);
      } else {
        result.add('');
      }
    }

    return result;
  }

  Future<void> processInsertHeatDetaction(
      {required HeatDetactionModel heatDetactionModel}) async {
    String urlApi =
        '${AppConstant.domain}insertHeatDetactionJi.php?isAdd=true&swineCode=${heatDetactionModel.swineCode}&farmFarmCode=${heatDetactionModel.farmFarmCode}&age=${heatDetactionModel.age}&listCaseAnimals=${heatDetactionModel.listCaseAnimals}&startTime=${heatDetactionModel.startTime}&finishTime=${heatDetactionModel.finishTime}&recorder=${heatDetactionModel.recorder}&inspector=${heatDetactionModel.inspector}&weight=${heatDetactionModel.weight}&breastLeft=${heatDetactionModel.breastLeft}&breastRight=${heatDetactionModel.breastRight}&pen=${heatDetactionModel.pen}';

    await Dio().get(urlApi).then((onValue) => Get.back());
  }

  Future<List<String>> changeStringToArray({required String string}) async {
    String textString = string;
    textString = textString.substring(1, textString.length - 1);

    var result = textString.split(',');
    for (var i = 0; i < result.length; i++) {
      result[i] = result[i].trim();
    }

    return result;
  }

  Future<void> processDeleteHeatDetactionById({required String id}) async {
    String urlApi =
        '${AppConstant.domain}deleteHeatWhereIdUng.php?isAdd=true&id=$id';

    await Dio().get(urlApi);
  }

  Future<void> findChooseEditCaseAnimals(
      {required String listCaseAnimals}) async {
    String string = listCaseAnimals;

    if (appController.chooseEditCaseAnimals.isNotEmpty) {
      appController.chooseEditCaseAnimals.clear();
    }

    string = string.substring(1, string.length - 1);

    List<String> strings = string.split(',');

    for (var i = 0; i < strings.length; i++) {
      appController.chooseEditCaseAnimals.add(strings[i].trim().isNotEmpty);
    }

    print('choseEditCaseAnimaols --> ${appController.chooseEditCaseAnimals}');
  }

  Future<void> processEditHeatDetaction(
      {required HeatDetactionModel heatDetactionModel}) async {
    print('heatDetactionModel =====> ${heatDetactionModel.toMap()}');

    String urlAPI =
        '${AppConstant.domain}editHeatDetactWhereIdUng.php?isAdd=true&id=${heatDetactionModel.id}&listCaseAnimals=${heatDetactionModel.listCaseAnimals}&startTime=${heatDetactionModel.startTime}&finishTime=${heatDetactionModel.finishTime}&weight=${heatDetactionModel.weight}&breastLeft=${heatDetactionModel.breastLeft}&breastRight=${heatDetactionModel.breastRight}&pen=${heatDetactionModel.pen}';

    await Dio().get(urlAPI).then(
      (value) {
        Get.offAll(const ListSwineCode());
      },
    );
  }
}
