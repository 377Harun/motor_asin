import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/Dil.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/service/firebaseNotifiSrvice.dart';
import 'package:motor_asin/views/onBoardWidget.dart';
import 'package:motor_asin/views/registerPage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  /*
  ensure initialized her zaman en üste koy durumu kontrol garanti altına alsın.
  ikinci gönderim
   */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseNotificationService.backGroundMessage);
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.light,
    // systemNavigationBarColor: Colors.white, navigation bar alt kısım
  ));
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (box.read("onboard") == null) {
      box.write("onboard", false);
    }

    print("storage değeri : ${box.read("onboard")}");
  }

  var controller = Get.put(Controller());
  GetStorage box = GetStorage();

  Widget build(BuildContext context) {
    return GetMaterialApp(
      /*   theme: ThemeData().copyWith(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          elevation: 0,

            //bunları ekle

        ),
         //textTheme: Theme.of(context).textTheme.subtitle1,
      ),*/

      translations: Dil(),
      locale: box.read("dil") == null
          ? Get.deviceLocale
          : box.read("dil") == "tr"
              ? Locale("tr", "TR")
              : Locale("en", "US"),
      fallbackLocale: Dil.varsayilan,

      //sda
      debugShowCheckedModeBanner: false,
      title: "Motor Aşin",
      home: SplashScreenView(
        backgroundColor: Color(0xfff7f7f7),
        navigateRoute:
            box.read("onboard") == false ? onBoardScreen() : RegisterPage(),
        duration: 5000,
        imageSize: 150,
        text: "Motor Aşin Ailesine Hoşgeldiniz",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        colors: [
          Colors.red.shade800,
          Colors.red.shade800,
          Colors.red.shade800,
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.grey,
          Colors.grey,
        ],
        imageSrc: "images/motorasinLogo.png",
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
