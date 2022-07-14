import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_asin/strings.dart';

import 'package:http/http.dart' as http;

class MusteriPage extends StatefulWidget {
  const MusteriPage({Key? key}) : super(key: key);

  @override
  _MusteriPageState createState() => _MusteriPageState();
}

class _MusteriPageState extends State<MusteriPage> {
  var sikayet = TextEditingController();

  Future? sendEmail(
      {required String? name,
      required String? email,
      required String? subject,
      required String? message}) async {
    final serviceId = "service_fl9y554";
    final templateId = "template_pnx5yzj";
    final userId = "HXoK4D0ms6IVSC-Kr";

    var url = "https://api.emailjs.com/api/v1.0/email/send";

    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          "service_id": serviceId.toString(),
          "template_id": templateId.toString(),
          "user_id": userId,
          "template_params": {
            "user_name": name,
            "user_email": email,
            "user_subject": subject,
            "user_message": message
          }
        }),
        headers: {
          "origin": "http://localhost",
          "Content-Type": "application/json",
        });

    print(" mesaj budur  ${res.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        elevation: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.blueGrey.shade800,
                  Colors.blueGrey.shade800
                ]),
          ),
        ),
        title: Text(
          "sikayetHatti".tr,
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        //backgroundColor: Colors.blueGrey[500],
      ),*/
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            image: DecorationImage(
                image: AssetImage(Strings.tirJpg), fit: BoxFit.fitHeight)),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Görüşleriniz",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                controller: sikayet,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Görüşlerinizi giriniz : ",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              //blurRadius: 100.0,
              // spreadRadius: 20.0,
            )
          ],
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey.shade800,
          icon: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () async {
            if (sikayet.text == "") {
              Get.snackbar(
                  "Lütfen eksiksiz giriniz !", "Görüşlerinizi belirtiniz",
                  icon: Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red[800],
                  colorText: Colors.white);
            } else if (sikayet.text != "") {
              /*  _urlAc(
                'mailto:info@motorasin.com?subject=Şikayetim Var&'
                'body=Merhabalar firma içerisinde yaşadığım problemi sizlere ibraz etmek isterim. \n'
                'konu : ${sikayet.text}\n'
                'değerlendirmenizi isterim.\n'
                'Teşekkürler.',
              );*/

              await sendEmail(
                  name: "Anonim",
                  email: "email",
                  subject: "Etik Hat test emaili",
                  message: sikayet.text);

              Get.snackbar(
                "Gönderildi",
                "Mail başarıyla gönderildi.",
                colorText: Colors.white,
                icon: Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
                backgroundColor: Colors.green[800],
              );
              Duration(seconds: 2);

              Navigator.pop(context, true);
            }
          },
          label: Text(
            "Gönder",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  /*Future _urlAc(String link) async {
    await launch(link, universalLinksOnly: true);
  }*/
}
