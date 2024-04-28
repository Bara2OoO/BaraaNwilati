import 'package:baraanwilati/app/data/models/task.dart';
import 'package:baraanwilati/app/utils/size_utils.dart';
import 'package:baraanwilati/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../../../../theme/app_decoration.dart';
import '../../../../theme/custom_text_style.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
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
            centerTitle: true, title: AppbarTitle(text: 'My Todo List'.tr)),
        body: GetX<MainController>(
            builder: (controller) => ListView(
                  controller: controller.scrollController,
                  padding: EdgeInsets.fromLTRB(20.h, 10.v, 20.h, 100.v),
                  children: [
                    ListView.separated(
                        padding: EdgeInsets.only(
                          bottom: 10.v,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.v,
                            ),
                        itemCount: controller.isLoading.value
                            ? 4
                            : controller.tasks.value.todos.length,
                        itemBuilder: (context, index) => controller
                                .isLoading.value
                            ? Container(
                                height: 100.v,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: appTheme.gray400),
                                child: LinearProgressIndicator(
                                  color: Colors.grey.shade200,
                                  backgroundColor: Colors.grey.shade100,
                                ))
                            : todoItem(controller.tasks.value.todos[index])),
                    GetX<MainController>(
                        builder: (controller) => controller.atEnd.value == false
                            ? Container(
                                height: 100.v,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: appTheme.gray400),
                                child: LinearProgressIndicator(
                                  color: Colors.grey.shade200,
                                  backgroundColor: Colors.grey.shade100,
                                ))
                            : Container())
                  ],
                )));
  }

  Widget todoItem(Todos item) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(_editTodoSheet(item));
      },
      onLongPress: () {
        Get.showOverlay(
            loadingWidget: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: appTheme.purble,
              ),
            ),
            asyncFunction: () async {
              await controller.deleteTask(item.id.toString());
            });
      },
      child: Stack(
        children: [
          Container(
            width: 400.h,
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
                      Get.showOverlay(
                          loadingWidget: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              color: appTheme.purble,
                            ),
                          ),
                          asyncFunction: () async {
                            await controller.changeStatus(
                                item.id.toString(), true);
                          });
                    },
                    child: Icon(item.completed
                        ? Icons.check_box_outline_blank
                        : Icons.check_box_outlined),
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
                  key: controller.addformKey,
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
                  key: controller.editformKey,
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
                  controller.editTask(item.id.toString(), false);
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveButton(String title, Function() ontap) {
    return GetX<MainController>(
      builder: (controller) {
        return CustomElevatedButton(
          onPressed: () {
            ontap();
          },
          text: title.tr,
          centerIcon: controller.isLoadingAddTodo.value
              ? SizedBox(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  title.tr,
                  style: CustomTextStyles.titleMediumOnPrimary,
                ),
        );
      },
    );
  }
}
