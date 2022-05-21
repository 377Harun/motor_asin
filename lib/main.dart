import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/Dil.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/screens/Home.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
//import 'package:splash_screen_view/splash_screen_view.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.light,
    // systemNavigationBarColor: Colors.white, navigation bar alt kısım
  ));
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var controller = Get.put(Controller());
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /*  theme: ThemeData().copyWith(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
        navigateRoute: Home(),
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
