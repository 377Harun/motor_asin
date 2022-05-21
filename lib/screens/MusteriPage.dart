import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MusteriPage extends StatefulWidget {
  const MusteriPage({Key? key}) : super(key: key);

  @override
  _MusteriPageState createState() => _MusteriPageState();
}

class _MusteriPageState extends State<MusteriPage> {
  var telefon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "KAYIT OL",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        //backgroundColor: Colors.blueGrey[500],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            image: DecorationImage(
                image: AssetImage("images/motorasinkargo.jpg"),
                fit: BoxFit.fitHeight)),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Müşterimiz Olmak İster misin ?",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                controller: telefon,
                decoration: InputDecoration(
                    hintText: "Telefon",
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
            if (telefon.text == "") {
              Get.snackbar(
                  "Lütfen eksiksiz giriniz !", "Telefon Numarası giriniz",
                  icon: Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red[800],
                  colorText: Colors.white);
            } else if (telefon.text != "") {
              _urlAc(
                'mailto:info@motorasin.com?subject=Müşteriniz olmak isteriz&body=Merhabalar Motor AŞİN ile çalışmak isteriz bizimle iletişime geçer misiniz ? \nİletişim : ${telefon.text}\n Teşekkürler.',
              );
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

  Future _urlAc(String link) async {
    await launch(link, universalLinksOnly: true);
  }
}
