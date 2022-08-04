import 'package:box_swan/core/db/db_helper.dart';
import 'package:box_swan/model/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{

  @override
  void onReady() {
    // TODO: implement onReady
    getTasks();
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? task}) async{
    return await DBHelper.insertTask(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.queryTask();
    taskList.assignAll(tasks.map((data) => new TaskModel.fromJson(data)).toList());
  }

  void delete({required TaskModel task}){
    DBHelper.deleteTask(task: task);
    getTasks();
  }

  void markTaskCompleted({required int? id}) async{
    await DBHelper.updateTask(id);
    getTasks();
  }

}