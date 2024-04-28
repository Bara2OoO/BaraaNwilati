import 'package:baraanwilati/app/data/apiClient/api_client.dart';
import 'package:baraanwilati/app/data/models/task.dart';
import 'package:baraanwilati/app/utils/pref_utils.dart';
import 'package:baraanwilati/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  //TODO: Implement MainController

  var isLoading = true.obs;

  var isLoadingAddTodo = false.obs;

  var tasks = Task(todos: []).obs;

  final addformKey = GlobalKey<FormState>();
  final editformKey = GlobalKey<FormState>();

  var newTaskController = TextEditingController();
  var editTaskController = TextEditingController();

  var pageindex = 0.obs;

  late ScrollController scrollController;

  var atEnd = false.obs;

  var gettingData = false.obs;

  getTasks() async {
    gettingData(true);

    var res = await ApiClient()
        .get('https://dummyjson.com/todos?limit=10&skip=${pageindex * 10}');
    if (res.statusCode == 200) {
      var newtasks = Task.fromJson(res.body);
      newtasks.todos.length < 10 ? atEnd(true) : atEnd(false);

      tasks.value.todos.addAll(newtasks.todos);
      tasks.refresh();
      isLoading(false);
    } else {
      isLoading(false);
      Get.defaultDialog(middleText: 'You Dont Have internet connection');
    }
    gettingData(false);
  }

  addTask() async {
    if (addformKey.currentState?.validate() ?? false) {
      isLoadingAddTodo(true);

      var userid = PrefUtils().readString('id');

      var res = await ApiClient().post('https://dummyjson.com/todos/add', {
        'todo': newTaskController.text,
        'completed': false,
        'userId': userid,
      });
      if (res.statusCode == 200) {
        Get.back();
        newTaskController.clear();
        Get.showSnackbar(
          GetSnackBar(
            message: 'Saved',
            duration: const Duration(seconds: 2),
            backgroundColor: appTheme.purble,
          ),
        );

        isLoadingAddTodo(false);
      } else {
        isLoadingAddTodo(false);
        Get.defaultDialog(middleText: 'You Dont Have internet connection');
      }
    }
  }

  editTask(String todoID, bool status) async {
    if (editformKey.currentState?.validate() ?? false) {
      isLoadingAddTodo(true);

      var userid = PrefUtils().readString('id');

      var res = await ApiClient().put('https://dummyjson.com/todos/$todoID', {
        'todo': editTaskController.text,
        'completed': status,
        'userId': userid,
      });
      if (res.statusCode == 200) {
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            message: 'Edited',
            duration: const Duration(seconds: 2),
            backgroundColor: appTheme.purble,
          ),
        );

        isLoadingAddTodo(false);
      } else {
        isLoadingAddTodo(false);
        Get.defaultDialog(middleText: 'You Dont Have internet connection');
      }
    }
  }

  changeStatus(String todoID, bool status) async {
    var userid = PrefUtils().readString('id');

    var res = await ApiClient().put('https://dummyjson.com/todos/$todoID', {
      'todo': editTaskController.text,
      'completed': status,
      'userId': userid,
    });
    if (res.statusCode == 200) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Edited',
          duration: const Duration(seconds: 2),
          backgroundColor: appTheme.purble,
        ),
      );

      isLoadingAddTodo(false);
    } else {
      isLoadingAddTodo(false);
      Get.defaultDialog(middleText: 'You Dont Have internet connection');
    }
  }

  deleteTask(String todoID) async {
    var res = await ApiClient().delete(
      'https://dummyjson.com/todos/$todoID',
    );
    if (res.statusCode == 200) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Deleted',
          duration: const Duration(seconds: 2),
          backgroundColor: appTheme.purble,
        ),
      );

      isLoadingAddTodo(false);
    } else {
      isLoadingAddTodo(false);
      Get.defaultDialog(middleText: 'You Dont Have internet connection');
    }
  }

  @override
  void onInit() {
    scrollController = ScrollController()
      ..addListener(() async {
        print(scrollController.offset);
        print(scrollController.position.maxScrollExtent);
        if (scrollController.offset >
            scrollController.position.maxScrollExtent - 100) {
          if (gettingData.value == false && atEnd.value == false) {
            print(pageindex);

            pageindex++;
            getTasks();
          }
        }
      });
    getTasks();
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
