import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBarNoConnection() {
  return Get.snackbar("İnternet Bağlantısı Yok",
      "Lütfen herhangi bir internet kaynağına bağlanın",
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      icon: Icon(
        Icons.wifi,
        color: Colors.white,
      ));
}

void snackBarYesConnection() {
  return Get.snackbar("İnternet Bağlı", "İnternet Bağlantısı Aktif",
      backgroundColor: Colors.green[800],
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      icon: Icon(
        Icons.wifi,
        color: Colors.white,
      ));
}

void snackBarMailOnayla() {
  return Get.snackbar(
    "Mailinizi onaylayın",
    "Lütfen e mail doğrulaması yapın",
    colorText: Colors.white,
    backgroundColor: Colors.red[800],
  );
}

void snackBarGiris() {
  return Get.snackbar("Hoşgeldiniz", "Motor AŞİN'e hoşgeldiniz",
      icon: Icon(
        Icons.check_circle_outline,
        color: Colors.grey.shade200,
      ),
      colorText: Colors.white,
      backgroundColor: Colors.green[600]);
}

void snackBarHata() {
  return Get.snackbar(
    "Hata",
    "Kullanici Adi Veya Şifre Yanlış",
    icon: Icon(
      Icons.account_circle_outlined,
      color: Colors.green[600],
    ),
    backgroundColor: Colors.red[800],
    colorText: Colors.white,
  );
}

Center homeIcon() {
  return Center(
      child: Icon(
    Icons.home_outlined,
    color: Colors.white,
  ));
}

Future<void> connectivityFunction() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    snackBarNoConnection();
  } else {
    snackBarYesConnection();
  }
}
