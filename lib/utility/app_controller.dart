import 'package:formanimal/models/swine_code_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxList swineCodeModels = <SwineCodeModel>[].obs;
  RxInt amountLoad = 100.obs;
  RxList chooseCaseAnimals = <bool>[].obs;
  RxBool display = false.obs;

  RxList startTimes = <DateTime>[].obs;
}
