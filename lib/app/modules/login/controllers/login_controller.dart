import 'package:baraanwilati/app/data/apiClient/api_client.dart';
import 'package:baraanwilati/app/modules/main/bindings/main_binding.dart';
import 'package:baraanwilati/app/modules/main/views/main_view.dart';
import 'package:baraanwilati/app/utils/pref_utils.dart';
import 'package:baraanwilati/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  var showPassword = false.obs;

  var isloading = false.obs;

  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  login() async {
    if (formKey.currentState?.validate() ?? false) {
      isloading(true);
      var res = await ApiClient().post('https://dummyjson.com/auth/login', {
        'username': usernameController.text,
        'password': passwordController.text,
        'expiresInMins': 60,
      });

      if (res.statusCode == 200) {
        isloading(false);
        PrefUtils().writeString('token', res.body['token']);
        PrefUtils().writeString('id', res.body['id'].toString());
        Get.showSnackbar(GetSnackBar(
          message: 'Welcome To Baraa Nwilati Todo App',
          backgroundColor: appTheme.purble,
          duration: const Duration(seconds: 2),
        ));
        Get.to(() => const MainView(), binding: MainBinding());
      } else {
        Get.showSnackbar(
          GetSnackBar(
            message: res.body['message'],
            backgroundColor: appTheme.purble,
            duration: const Duration(seconds: 2),
          ),
        );
      }
      print(res.bodyString);
      isloading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
