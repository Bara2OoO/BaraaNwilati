import 'dart:convert';

import 'package:baraanwilati/app/data/apiClient/api_client.dart';
import 'package:baraanwilati/app/data/models/task.dart';
import 'package:baraanwilati/app/utils/pref_utils.dart';
import 'package:baraanwilati/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfflineTodosController extends GetxController {
  //TODO: Implement MainController

  var newTaskController = TextEditingController();
  var editTaskController = TextEditingController();

  final offlineAddformKey = GlobalKey<FormState>();
  final offlineEditformKey = GlobalKey<FormState>();

  var todos = <Todos>[].obs;

  addTask() async {
    if (offlineAddformKey.currentState?.validate() ?? false) {
      Todos newtodo = Todos(
          id: todos.isNotEmpty ? todos.last.id + 1 : 1,
          todo: newTaskController.text,
          completed: false,
          userId: 0);

      todos.add(newtodo);

      var jsonfromstorage = PrefUtils().readString('offlineTodos');

      var oldtodos = <Todos>[].obs;

      if (jsonfromstorage != null) {
        oldtodos.value = List.from(json.decode(jsonfromstorage))
            .map((e) => Todos.fromJson(e))
            .toList();
      }

      oldtodos.add(newtodo);

      PrefUtils().writeString('offlineTodos', json.encode(oldtodos));
      Get.back();
      newTaskController.clear();

      Get.showSnackbar(GetSnackBar(
        message: 'Saved',
        duration: const Duration(seconds: 2),
        backgroundColor: appTheme.purble,
      ));
    }
  }

  changeStatus(String todoID, bool status) async {
    todos.firstWhere((element) => element.id.toString() == todoID).completed =
        status;

    PrefUtils().writeString('offlineTodos', json.encode(todos));

    todos.refresh();
  }

  editTask(String todoID) async {
    if (offlineEditformKey.currentState?.validate() ?? false) {
      todos.firstWhere((element) => element.id.toString() == todoID).todo =
          editTaskController.text;

      PrefUtils().writeString('offlineTodos', json.encode(todos));

      newTaskController.clear();
      Get.back();

      Get.showSnackbar(GetSnackBar(
        message: 'Edited',
        duration: const Duration(seconds: 2),
        backgroundColor: appTheme.purble,
      ));

      todos.refresh();
    }
  }

  void delete(String todoID) {
    todos.removeWhere((element) => element.id.toString() == todoID);
    todos.refresh();
    PrefUtils().writeString('offlineTodos', json.encode(todos));

    Get.showSnackbar(GetSnackBar(
      message: 'Deleted',
      duration: const Duration(seconds: 2),
      backgroundColor: appTheme.purble,
    ));
  }

  gettodos() async {
    var todoList = PrefUtils().readString('offlineTodos');

    if (todoList != null) {
      todos(List.from(json.decode(todoList) ?? [])
          .map((e) => Todos.fromJson(e))
          .toList());
    }
  }

  @override
  void onInit() {
    gettodos();
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
