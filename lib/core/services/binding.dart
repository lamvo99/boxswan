import 'package:box_swan/controller/expense_tracker_controller.dart';
import 'package:box_swan/controller/home_view_controller.dart';
import 'package:box_swan/controller/task_controller.dart';
import 'package:get/get.dart';

class Binding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
    Get.lazyPut(() => HomeViewController());
    Get.lazyPut(() => ExpenseTrackerController());
  }
}