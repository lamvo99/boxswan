import 'package:box_swan/controller/expense_tracker_controller.dart';
import 'package:box_swan/controller/home_view_controller.dart';
import 'package:box_swan/core/constant/app_colors.dart';
import 'package:box_swan/core/constant/app_images.dart';
import 'package:box_swan/core/constant/app_themes.dart';
import 'package:box_swan/core/language/trans_helper.dart';
import 'package:box_swan/model/expense_model.dart';
import 'package:box_swan/model/show_case_key.dart';
import 'package:box_swan/screen/expense_tracker/widgets/add_expense_button.dart';
import 'package:box_swan/screen/expense_tracker/widgets/balance_card.dart';
import 'package:box_swan/screen/expense_tracker/widgets/my_transaction.dart';
import 'package:box_swan/widgets/custom_show_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  final RxString selectedLang;

  const ExpenseTrackerScreen({Key? key, required this.selectedLang}) : super(key: key);

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final _nameTransController = TextEditingController();
  final _amountTransController = TextEditingController();
  String datetime = DateFormat().format(DateTime.now()).toString();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  final ExpenseTrackerController expenseTrackerController = Get.find();
  final HomeViewController homeViewController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text(TransHelper.newTrans),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
                contentPadding: EdgeInsets.only(top: 10.0, right: 6.w, left: 6.w),
                content: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(TransHelper.spending),
                            Switch(
                              value: _isIncome,
                              onChanged: (newValue) {
                                setState(() {
                                  _isIncome = newValue;
                                });
                              },
                            ),
                            Text(TransHelper.income),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: TransHelper.amount,
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return TransHelper.enterAmount;
                                        }
                                        return null;
                                      },
                                      controller: _amountTransController,
                                    ),
                                    SizedBox(height: 8.h),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: TransHelper.forWhat,
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return TransHelper.enterNameTrans;
                                        }
                                        return null;
                                      },
                                      controller: _nameTransController,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: AppColors.pinkClr,
                    child: Text(TransHelper.cancel, style: TextStyle(color: AppColors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  MaterialButton(
                    color: AppColors.bluishClr,
                    child: Text(TransHelper.ok, style: TextStyle(color: AppColors.white)),
                    onPressed: () => _validate(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                ],
              );
            },
          );
        });
  }
  _validate(){
    if (_formKey.currentState!.validate()) {
      _addExpenseToDb();
      expenseTrackerController.getExpense();
      expenseTrackerController.caculate();
      Get.back();
      EasyLoading.showSuccess("Add Expense Transacion Successfully!");
    }
  }
  _addExpenseToDb()async{
    int value = await expenseTrackerController.addExpense(
      expense: ExpenseModel(
        nameTrans: _nameTransController.text,
        amount: int.parse(_amountTransController.text),
        date: DateFormat.yMd().format(DateTime.now()).toString(),
        incomOrSpending: _isIncome ? 1 : 0
      )
    );
    _nameTransController.clear();
    _amountTransController.clear();
    print("My expense id is" + "$value");
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>  Stack(
          children: [
            Container(
              child: Column(
                children: [
                  BalanceCard(
                    balance: (expenseTrackerController.income.value-expenseTrackerController.spending.value).toString(),
                    income: expenseTrackerController.income.value.toString(),
                    spending:expenseTrackerController.spending.value.toString(),
                    locale: widget.selectedLang,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: expenseTrackerController.expenseList.length ==0 ? Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.list),
                            Text(
                              TransHelper.notBudget1,
                              style: textMercury18W600,
                            ),
                            Text(
                              TransHelper.notBudget2,
                              style: textMercury16W600,
                            )
                          ],
                        ),
                      ),
                    ) :ListView.builder(
                      itemCount: expenseTrackerController.expenseList.length,
                      itemBuilder: (_, index){
                        ExpenseModel expense = expenseTrackerController.expenseList[expenseTrackerController.expenseList.length - (index +1)];
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: Row(
                                  children: [
                                    MyTransaction(expense:expense ,selectedtLang: widget.selectedLang),
                                  ],
                                ),
                              ),
                            )
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: CustomShowCaseWidget(
                description: TransHelper.keyEight,
                globalKey: ShowKey.keySeven,
                child: AddExpenseButton(
                  onTap: () {
                    _newTransaction();
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}
