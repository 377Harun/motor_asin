import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/Dil.dart';

class Controller extends GetxController {
  var index = 0.obs;
  RxString resim = "images/motorasinBaslik.jpg".obs;
  var renk1 = Colors.black.obs;
  var renk3 = Colors.grey.obs;
  var renk2 = Colors.grey.obs;

  GetStorage box = GetStorage();

  RxBool videoVisibility = true.obs;

  //RxBool aramaYapiliyor = false.obs;

  Map<dynamic, String> yazilar = {
    0: "Geniş Ürün Yelpazesi\n130 markadan 90 bin çeşit ve \n 1.5 milyon üründe Türkiye'nin her \n yerinde ve 70 ülkedeyiz.",
    1: "Hızlı Teslimat \n 81 ilde aynı gün içinde\n 2500 teslimat yapıyoruz.",
    2: "Yarım Asırdır Her\n Parçada Biz Varız."
  }.obs;

  Map<int, Color> renkler = {
    0: Colors.black,
    1: Colors.grey,
    2: Colors.grey,
  }.obs;

  SayiArttir() async {
    if (index.value == 2) {
      index.value = 0;
    } else {
      index.value = index.value + 1;
    }
  }

  var backGroundColor = Colors.black.obs;

  void ColorChange(color) {
    backGroundColor.value = color;
  }
}
