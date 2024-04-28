import 'package:baraanwilati/app/modules/login/bindings/login_binding.dart';
import 'package:baraanwilati/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    navigateNext();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const LoginView(), binding: LoginBinding());
  }
}
