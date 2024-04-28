import 'package:get/get.dart';

import '../controllers/offline_todos_controller.dart';

class OfflineTodosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfflineTodosController>(
      () => OfflineTodosController(),
    );
  }
}
