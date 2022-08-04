import 'package:get_storage/get_storage.dart';

class Storage {

  static final box = GetStorage();

  static initGetStorage()async{
    await box.write('firstLoad', true);
  }



}