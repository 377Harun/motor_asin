import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:motor_asin/components/noConnectionSnackBar.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/models/Authantication.dart';
import 'package:motor_asin/service/firebaseNotifiSrvice.dart';
import 'package:motor_asin/views/Home.dart';
import 'package:motor_asin/views/Kay%C4%B1tOl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var db = FirebaseFirestore.instance.collection("users");

  void initState() {
    super.initState();
    FirebaseNotificationService().connectNotification();
    connectivityFunction();
  }

  bool obstr = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService _auth = AuthService();

  var controller = Get.put(Controller());

  bool isLogin = false;

  GetStorage box = GetStorage();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().arkaPlan,
      body: SingleChildScrollView(
        child: Column(
          children: [
            bosluk(0.1),
            _arabaUcakJson(),
            Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                color: AppColors()._cardColor,
                shape: _cardShape(),
                child: Padding(
                  padding: _padding10(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bosluk(0.03),
                        homeIcon(),
                        bosluk(0.03),
                        _textfieldKullaniciAdi(),
                        bosluk(0.02),
                        _textfieldSifre(),
                        bosluk(0.04),
                        _girisYapButton(context),
                        bosluk(0.02),
                        _kayitOlButton(),
                        bosluk(0.03),
                        _textSifremiUnuttum(),
                        bosluk(0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _arabaUcakJson() {
    return Align(
      alignment: Alignment.topCenter,
      child: Lottie.asset("images/ucakAraba.json",
          height: Get.height * 0.17, fit: BoxFit.cover),
    );
  }

  Padding _textSifremiUnuttum() {
    return Padding(
      padding: EdgeInsets.only(right: 30),
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Şifremi Unuttum",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white,
            fontStyle: FontStyle.normal,
            wordSpacing: 1,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder _cardShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    ));
  }

  EdgeInsets _padding10() => const EdgeInsets.all(10);

  Container _kayitOlButton() {
    return Container(
      width: Get.width * 0.7,
      height: Get.height * 0.055,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppColors()._textfieldColor,
        onPressed: () {
          Get.to(KayitOl());
        },
        child: Text(
          "Kayıt Ol",
          style: _textsstyleWhite(),
        ),
      ),
    );
  }

  Container _girisYapButton(BuildContext context) {
    return Container(
      width: Get.width * 0.7,
      height: Get.height * 0.055,
      child: FlatButton(
        minWidth: Get.width * 0.6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppColors()._textfieldColor,
        onPressed: () async {
          /*
        okumaya ve yazmaya izin verilmediği için veriyi göremiyoruz.
        sadece otantikeolanlar görebiliyor.*/

          var user =
              _auth.signIn(emailController.text, passwordController.text);
          user.then((value) async {
            if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
              await FirebaseFirestore.instance
                  .collection("Person")
                  .where('email', isEqualTo: emailController.text)
                  .get()
                  .then((res) {
                if (res.docs.length > 0) {
                  res.docs[0]["isAdmin"] == true
                      ? controller.isAdmin.value = true
                      : controller.isAdmin.value = false;
                } else {
                  controller.isAdmin.value = false;
                }
              }, onError: (e) {
                // print("Hayır admin değil.");
              });
              _loginYonlendirme(context);
              snackBarGiris();
              box.write("onboard", true);
            } else {
              snackBarMailOnayla();
            }
          }).onError((error, stackTrace) {
            snackBarHata();
          });
          controller.kullanici.value = emailController.text;
        },
        child: Text(
          "Giriş Yap",
          style: _textsstyleWhite(),
        ),
      ),
    );
  }

  void _loginYonlendirme(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Home(),
      ),
    );
  }

  Container _textfieldSifre() {
    return Container(
      width: Get.width * 0.7,
      child: TextFormField(
        controller: passwordController,
        style: _textsstyleWhite(),
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        autocorrect: true,
        decoration: InputDecoration(
            fillColor: AppColors()._textfieldColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.black),
            suffixIcon: IconButton(
              icon: obstr
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  obstr = !obstr;
                });
              },
            ),
            hintText: "Şifre",
            hintStyle: _textsstyleWhite(),
            labelStyle: _textsstyleWhite()),
        obscureText: obstr,
      ),
    );
  }

  Container _textfieldKullaniciAdi() {
    return Container(
      width: Get.width * 0.7,
      child: TextFormField(
        controller: emailController,
        style: _textsstyleWhite(),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: AppColors()._textfieldColor,
            filled: true,
            prefixIcon:
                Icon(Icons.account_circle_outlined, color: Colors.black),
            hintText: "Kullanıcı Adı",
            labelStyle: _textsstyleWhite(),
            hintStyle: _textsstyleWhite()),
        textInputAction: TextInputAction.next,
        obscureText: false,
      ),
    );
  }

  TextStyle _textsstyleWhite() => TextStyle(color: Colors.black);

  SizedBox bosluk(double height) {
    return SizedBox(
      height: Get.height * height,
    );
  }
}

class AppColors {
  Color _cardColor = Colors.red.shade900;
  Color _textfieldColor = Colors.grey.shade200;
  Color arkaPlan = Colors.red.shade200;
}
