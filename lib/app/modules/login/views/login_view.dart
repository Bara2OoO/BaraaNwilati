import 'package:baraanwilati/app/modules/offlineTodos/bindings/offline_todos_binding.dart';
import 'package:baraanwilati/app/modules/offlineTodos/views/offline_todos_view.dart';
import 'package:baraanwilati/app/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/custom_button_style.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../../theme/theme_helper.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          CustomAppBar(centerTitle: true, title: AppbarTitle(text: 'Login'.tr)),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                SizedBox(height: 21.v),
                Text(
                  "Do You Have Account".tr,
                  style: CustomTextStyles.titleLargeBlack900,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.v),
                Text(
                  "Login Now".tr,
                  style: theme.textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.v),
                _buildEmail(),
                SizedBox(height: 33.v),
                _buildPassword(),
                SizedBox(height: 20.v),
                _login(),
                SizedBox(height: 20.v),
                _offlineStorage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Section Widget
Widget _buildEmail() {
  var controller = Get.find<LoginController>();

  return Padding(
    padding: EdgeInsets.only(
      left: 52.h,
      right: 53.h,
    ),
    child: CustomTextFormField(
      autofocus: false,
      validator: (value) {
        if (value!.length < 5) {
          return 'Please enter your username correctly';
        }
      },
      controller: controller.usernameController,
      hintText: "Username...".tr,
      textInputAction: TextInputAction.done,
      suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 14.v, 13.h, 14.v),
          child: const SizedBox()),
      contentPadding: EdgeInsets.only(
        left: 22.h,
        top: 8.v,
        bottom: 8.v,
      ),
    ),
  );
}

/// Section Widget
Widget _buildPassword() {
  return Padding(
    padding: EdgeInsets.only(
      left: 52.h,
      right: 53.h,
    ),
    child: GetX<LoginController>(
      init: Get.find<LoginController>(),
      initState: (_) {},
      builder: (controller) {
        return CustomTextFormField(
          autofocus: false,
          obscureText: !controller.showPassword.value,
          controller: controller.passwordController,
          hintText: "Password...".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          validator: (value) {
            if (value!.length < 6) {
              return 'password must be at least 6 characters';
            }
          },
          suffix: InkWell(
            onTap: () {
              controller.showPassword.value = !controller.showPassword.value;
            },
            child: Container(
                margin: EdgeInsets.fromLTRB(30.h, 14.v, 13.h, 14.v),
                child: Icon(
                    controller.showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey)),
          ),
          contentPadding: EdgeInsets.only(
            left: 22.h,
            top: 8.v,
            bottom: 8.v,
          ),
        );
      },
    ),
  );
}

/// Section Widget
Widget _login() {
  return GetX<LoginController>(
    builder: (controller) {
      return CustomElevatedButton(
        onPressed: () {
          controller.login();
        },
        text: "Login".tr,
        centerIcon: controller.isloading.value
            ? SizedBox(
                height: 30.adaptSize,
                width: 30.adaptSize,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                "Login".tr,
                style: CustomTextStyles.titleMediumOnPrimary,
              ),
        margin: EdgeInsets.only(
          left: 52.h,
          right: 53.h,
        ),
      );
    },
  );
}

Widget _offlineStorage() {
  return CustomElevatedButton(
    onPressed: () {
      Get.to(() => OfflineTodosView(), binding: OfflineTodosBinding());
    },
    text: 'Offline Todos'.tr,
    margin: EdgeInsets.only(left: 53.h, right: 53.h, bottom: 43.v),
    buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
    buttonTextStyle: CustomTextStyles.titleMediumPrimary,
    centerIcon: Text(
      'Offline Todos'.tr,
      style: CustomTextStyles.titleMediumPrimary,
    ),
  );
}
