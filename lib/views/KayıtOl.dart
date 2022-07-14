import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_asin/models/Authantication.dart';
import 'package:motor_asin/views/registerPage.dart';

class KayitOl extends StatefulWidget {
  const KayitOl({Key? key}) : super(key: key);

  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  AuthService _auth = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _isimController = TextEditingController();
  TextEditingController _sifreController = TextEditingController();
  TextEditingController _sifre2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: _appBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageMotorAsin(),
              bosluk(0.05),
              _textfieldIsim(),
              _textfieldEmail(),
              _textfieldSifre(),
              _textfieldSifre2(),
              bosluk(0.02),
              SizedBox(
                width: Get.width * 0.85,
                height: Get.height * 0.055,
                child: _kayitolbutton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _kayitolbutton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(), primary: AppColors()._textfieldColor),
      onPressed: () async {
        if (_sifreController.text.length < 6) {
          _snackBarHataliSifre();
        } else {
          if (_sifre2Controller.text != _sifreController.text) {
            _snackBarParolaUyusmaz();
          } else {
            _auth.createPerson(_isimController.text, _emailController.text,
                _sifreController.text);

            _snackBarBasarili();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          }
        }
      },
      child: Text(
        "Kayıt Ol",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  ClipRRect _imageMotorAsin() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        "images/motorasinLogo.png",
        height: Get.height * 0.18,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Kayıt Ol",
        style: TextStyle(fontSize: 17),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  Padding _textfieldSifre() {
    return Padding(
      padding: _padding10(),
      child: TextField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: _sifreController,
        decoration: InputDecoration(
          fillColor: AppColors()._textfieldColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.black),
          hintText: "Şifre",
          hintStyle: _textsstyleWhite(),
          labelStyle: _textsstyleWhite(),
        ),
        obscureText: true,
      ),
    );
  }

  Padding _textfieldSifre2() {
    return Padding(
      padding: _padding10(),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _sifre2Controller,
        decoration: InputDecoration(
            fillColor: AppColors()._textfieldColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.black),
            hintText: "Şifre",
            hintStyle: _textsstyleWhite(),
            labelStyle: _textsstyleWhite()),
        obscureText: true,
      ),
    );
  }

  Padding _textfieldIsim() {
    return Padding(
      padding: _padding10(),
      child: TextField(
        textInputAction: TextInputAction.next,
        controller: _isimController,
        decoration: InputDecoration(
            fillColor: AppColors()._textfieldColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon:
                Icon(Icons.account_circle_outlined, color: Colors.black),
            hintText: "İsim",
            hintStyle: _textsstyleWhite(),
            labelStyle: _textsstyleWhite()),
      ),
    );
  }

  Padding _textfieldEmail() {
    return Padding(
      padding: _padding10(),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: _emailController,
        decoration: InputDecoration(
            fillColor: AppColors()._textfieldColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Icon(Icons.mail_outline, color: Colors.black),
            hintText: "E-Posta",
            hintStyle: _textsstyleWhite(),
            labelStyle: _textsstyleWhite()),
      ),
    );
  }

  void _snackBarBasarili() {
    return Get.snackbar(
        "Kayıt Başarılı", "Lütfen mailinizi onaylayın spam kontrol edin",
        backgroundColor: Colors.green[800], colorText: Colors.white);
  }

  void _snackBarParolaUyusmaz() {
    return Get.snackbar("Hatalı Şifre", "Parolalar uyuşmuyor",
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void _snackBarHataliSifre() {
    return Get.snackbar(
        "Hatalı Şifre", "Lütfen şifrenizi en az 6 karakter giriniz",
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  bosluk(double height) {
    return SizedBox(height: Get.height * height);
  }

  TextStyle _textsstyleWhite() => TextStyle(color: Colors.black);

  EdgeInsets _padding10() {
    return EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25);
  }
}

class AppColors {
  Color _textfieldColor = Colors.grey.shade200;
  Color arkaPlan = Colors.red.shade200;
}
