import 'dart:io';

import 'package:baraanwilati/app/utils/size_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/custom_text_style.dart';
import '../../../theme/theme_helper.dart';
import '../../modules/splash/views/splash_view.dart';

class ApiClient extends GetConnect {
  noNetwork() {
    Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          '',
                          style: CustomTextStyles.titleLargeBlack900,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text('الرجاء معاودة تسجيل الدخول',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge!.copyWith(
                                color: appTheme.black900,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.fSize)),
                        const SizedBox(height: 20),
                        //Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(0, 45),
                                  backgroundColor: appTheme.purble,
                                  foregroundColor: const Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Get.offAll(() => const SplashView());
                                },
                                child: Text(
                                  'تسجيل الدخول',
                                  style: CustomTextStyles.titleSmallOnPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(0, 45),
                                  backgroundColor: Colors.white,
                                  foregroundColor: appTheme.purble,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: appTheme.purble),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  exit(0);
                                },
                                child: Text(
                                  'الخروج',
                                  style: CustomTextStyles.titleSmallPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        barrierDismissible: false);
  }

  Future<dynamic> getData(
      {required String url, String? token, Map<String, dynamic>? param}) async {
    try {
      final dioClient = dio.Dio();
      Map<String, dynamic>? header = token == null
          ? {'lang': Get.locale!.languageCode}
          : {
              'Authorization': 'Bearer $token',
              'lang': Get.locale!.languageCode
            };
      var response = await dioClient.get(url,
          queryParameters: param,
          options: dio.Options(
            contentType: 'application/json',
            headers: header,
            validateStatus: (status) {
              return status! < 500;
            },
          ));

      return response;
    } catch (e) {
      print(e);

      // noNetwork();
    }
  }

  Future<dynamic> posttData(
      {required String url,
      required Map body,
      String? token,
      Map<String, dynamic>? param}) async {
    try {
      final dioClient = dio.Dio();
      var header = token == null
          ? {
              'lang': Get.locale!.languageCode,
              'Content-type': 'application/json',
            }
          : {
              'lang': Get.locale!.languageCode,
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token'
            };

      var response = await dioClient.post(
        url,
        queryParameters: param,
        options: dio.Options(
          headers: header,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
        data: body,
      );

      if (response.statusCode == 419) {
        // endSetion();
      } else {
        return response;
      }
    } catch (e) {
      // noNetwork();
      print(e);
    }
  }

  Future<dynamic> postMultipart(
      {required String url,
      Map<String, dynamic>? param,
      required dio.FormData data}) async {
    try {
      final dioClient = dio.Dio();

      var response = await dioClient.post(
        url,
        queryParameters: param,
        options: dio.Options(),
        data: data,
      );

      if (response.statusCode == 419) {
        // endSetion();
      } else {
        return response;
      }
    } catch (e) {
      // noNetwork();
      print(e);
    }
  }
}
