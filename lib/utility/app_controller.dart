import 'package:formanimal/models/heat_detaction_model.dart';
import 'package:formanimal/models/swine_code_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AppController extends GetxController {
  RxList swineCodeModels = <SwineCodeModel>[].obs;
  RxList checkSwineCodes = <bool>[].obs;

  RxInt amountLoad = 100.obs;
  RxList chooseCaseAnimals = <bool>[].obs;
  RxBool display = false.obs;

  RxList startTimes = <DateTime>[].obs;

  RxList heatDetactionModels = <HeatDetactionModel>[].obs;

  RxBool displayListSearch = false.obs;

  RxList displayStartTimes = <String>[].obs;
  RxList displayFinishTimes = <String>[].obs;
}
