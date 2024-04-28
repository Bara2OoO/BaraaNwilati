import 'package:baraanwilati/app/utils/pref_utils.dart';
import 'package:baraanwilati/app/utils/size_utils.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.find<PrefUtils>().init();
    Get.put(SizeUtils());
    // Get.put(ApiClient());
    // Connectivity connectivity = Connectivity();
    // Get.put(NetworkInfo(connectivity));
    // Get.put(BottomNavigationBarController(), permanent: true);
  }
}
