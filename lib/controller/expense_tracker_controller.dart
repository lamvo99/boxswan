import 'package:box_swan/core/db/db_helper.dart';
import 'package:box_swan/model/expense_model.dart';
import 'package:get/get.dart';

class ExpenseTrackerController extends GetxController{

  @override
  void onReady() {
    // TODO: implement onReady
    getExpense();
    caculate();
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var expenseList = <ExpenseModel>[].obs;
  RxInt spending = 0.obs;
  RxInt income = 0.obs;

  void getExpense() async {
    List<Map<String, dynamic>> expense = await DBHelper.queryExpense();
    expenseList.assignAll(expense.map((data) => new ExpenseModel.fromJson(data)).toList());
  }

  Future<int> addExpense({ExpenseModel? expense}) async{
    return await DBHelper.insertExpense(expense);
  }

  void caculate()async{
    List<Map<String, dynamic>> expense = await DBHelper.queryExpense();
    var list = <ExpenseModel>[];
    list.assignAll(expense.map((data) => new ExpenseModel.fromJson(data)).toList());
    var spend = 0;
    var incom = 0;
    for(int i =0; i < list.length; i++){
      if(expenseList[i].incomOrSpending == 1 ){
        incom = await incom + int.parse(list[i].amount.toString());
      }else{
        spend = await spend + int.parse(list[i].amount.toString());
      }
    }
    income.value = incom;
    spending.value = spend;
  }



}