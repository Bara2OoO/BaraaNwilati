import 'package:baraanwilati/app/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../theme/app_decoration.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../../theme/theme_helper.dart';
import '../../../data/models/task.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../controllers/offline_todos_controller.dart';

class OfflineTodosView extends GetView<OfflineTodosController> {
  const OfflineTodosView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: appTheme.purble,
            onPressed: () {
              Get.bottomSheet(_addTodoSheet());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        appBar: CustomAppBar(
            centerTitle: true, title: AppbarTitle(text: 'Offline Todos'.tr)),
        body: GetX<OfflineTodosController>(
          builder: (controller) => controller.todos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: context.width * 0.5,
                          height: context.width * 0.5,
                          child: Lottie.asset('assets/lottie/empty.json',
                              repeat: false,
                              width: context.width * 0.5,
                              height: context.width * 0.5,
                              fit: BoxFit.cover)),
                      Text(
                        'No Tasks'.tr,
                        style: CustomTextStyles.titleLargeBlack900,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.only(
                      bottom: 100.v, right: 15.h, left: 15.h, top: 10.v),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.v,
                      ),
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) =>
                      todoItem(controller.todos[index])),
        ));
  }

  Widget todoItem(Todos item) {
    return InkWell(
      key: Key(item.id.toString()),
      onTap: () {
        Get.bottomSheet(_editTodoSheet(item));
      },
      onLongPress: () {
        controller.delete(item.id.toString());
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.h,
              vertical: 12.v,
            ),
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.v),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 300.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.todo,
                          style: theme.textTheme.titleSmall,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.v),
                          child: Text(
                            item.id.toString(),
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.changeStatus(
                          item.id.toString(), !item.completed);
                    },
                    child: Icon(item.completed
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addTodoSheet() {
    return Container(
      width: SizeUtils.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Todo',
                  style: CustomTextStyles.titleLargeBlack900,
                ),
                SizedBox(
                  height: 20.v,
                ),
                Form(
                  key: controller.offlineAddformKey,
                  child: CustomTextFormField(
                    autofocus: false,
                    controller: controller.newTaskController,
                    hintText: 'Type here',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Fill In The Field';
                      }
                    },
                    suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 14.v, 13.h, 14.v),
                        child: const SizedBox()),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 22.h,
                      vertical: 8.v,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.v,
                ),
                _saveButton('Add', () {
                  controller.addTask();
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _editTodoSheet(Todos item) {
    controller.editTaskController.text = item.todo;
    return Container(
      width: SizeUtils.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Todo',
                  style: CustomTextStyles.titleLargeBlack900,
                ),
                SizedBox(
                  height: 20.v,
                ),
                Form(
                  key: controller.offlineEditformKey,
                  child: CustomTextFormField(
                    autofocus: false,
                    controller: controller.editTaskController,
                    hintText: 'Type here',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Fill In The Field';
                      }
                    },
                    suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 14.v, 13.h, 14.v),
                        child: const SizedBox()),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 22.h,
                      vertical: 8.v,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.v,
                ),
                _saveButton('Edit', () {
                  controller.editTask(item.id.toString());
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveButton(String title, Function() ontap) {
    return CustomElevatedButton(
      onPressed: () {
        ontap();
      },
      text: title.tr,
      centerIcon: Text(
        title.tr,
        style: CustomTextStyles.titleMediumOnPrimary,
      ),
    );
  }
}
