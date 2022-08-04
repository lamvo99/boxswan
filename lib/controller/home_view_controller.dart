import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewController extends GetxController{

  late PageController pageController;
  var currentIndex = 0.obs;
  RxString userName = "".obs;
  GlobalKey bottomNavigationKey = GlobalKey();
  RxBool isFirstShow = false.obs;

  RxString imageBase64 = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
  }

  checkId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseImage = prefs.getString('avatar');
    if (baseImage != null) {
      imageBase64.value = baseImage;
    } else {
      imageBase64.value = "";
    }
    String? userId = prefs.getString('userName');
    if (userId != null) {
      userName.value = userId;
    } else {
      userName.value = '';
    }
  }

  getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      File image = File(pickedFile.path);
      Uint8List imageBytes = image.readAsBytesSync();
      imageBase64.value = base64Encode(imageBytes);
      saveImage(base64Encode(imageBytes));
    }else {
      print('No image selected');
      imageBase64.value = "";
    }
  }

 saveImage(String base64Image) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("avatar", base64Image);
}

  saveUsername(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", userId);
    userName.value = userId;
  }

  // Future<DocumentSnapshot> getUserName({userName})async {
  //   DocumentSnapshot document = await FirebaseFirestore.instance.collection('coupons').doc(userName).get();
  //   return document;
  // }

  deleteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}