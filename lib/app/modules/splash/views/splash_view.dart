import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: InkWell(
                      onTap: () {
                        // controller.showLangDialog();
                      },
                      child: Lottie.asset('assets/lottie/splash1.json',
                          repeat: false)),
                )
                // SizedBox(
                //     width: double.maxFinite,
                //     child: Column(children: [
                //       const Spacer(flex: 25),
                //       SizedBox(
                //           width: 240,
                //           child: Column(
                //             children: [
                //               Text('Welcome'.tr,
                //                   style: CustomTextStyles.headlineLargeffffffff),
                //               RichText(
                //                 text: TextSpan(children: [
                //                   TextSpan(
                //                       text: 'To'.tr,
                //                       style:
                //                           CustomTextStyles.headlineLargeffffffff),
                //                   TextSpan(
                //                       text: "Yasham".tr,
                //                       style: CustomTextStyles
                //                           .headlineLargeffffffffBold),
                //                 ]),
                //               ),
                //               Text('Discount Card'.tr,
                //                   style: CustomTextStyles.headlineLargeffffffff),
                //             ],
                //           )),
                // const Spacer(flex: 27),
                // ScaleTransition(
                //   scale: controller.animation,
                //   child: CustomElevatedButton(
                //       onPressed: () {
                //         controller.navigateNext();
                //       },
                //       height: 50,
                //       width: 130,
                //       text: "التالي".tr,
                //       centerIcon: Text('التالي',
                //           style: theme.textTheme.titleMedium!
                //               .copyWith(color: Colors.black)),
                //       leftIcon: Container(
                //           margin: EdgeInsets.only(right: 11),
                //           child: CustomImageView(
                //               imagePath: 'assets/images/img_next_1.png',
                //               height: 19,
                //               width: 21)),
                //       buttonStyle: CustomButtonStyles.outlineBlack,
                //       buttonTextStyle: theme.textTheme.titleMedium!
                //           .copyWith(color: Colors.black)),
                // ),
                // const Spacer(flex: 30),
                // GetX<SplashController>(
                //   builder: (_) {
                //     return AnimatedContainer(
                //       curve: Curves.bounceIn,
                //       alignment: Alignment(controller.cardx.value, 1),
                //       duration: const Duration(milliseconds: 500),
                //       child: CustomImageView(
                //         imagePath: 'assets/images/img_front_1.png',
                //         height: 280,
                //         width: 333,
                //       ),
                //     );
                //   },
                // )
                // ])));
                )));
  }
}
