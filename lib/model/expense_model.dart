class ExpenseModel {
   int? id;
   String? nameTrans;
   int? amount;
   String? date;
   int? incomOrSpending;

  ExpenseModel({
    this.id,
    this.nameTrans,
    this.amount,
    this.date,
    this.incomOrSpending,
  });

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTrans = json['nameTrans'];
    amount = json['amount'];
    date = json['date'];
    incomOrSpending =json['incomOrSpending'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameTrans'] = this.nameTrans;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['incomOrSpending'] = this.incomOrSpending;
    return data;
  }

}
