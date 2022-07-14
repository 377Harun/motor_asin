import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:motor_asin/controller.dart';

class DuyuruPage extends StatefulWidget {
  const DuyuruPage({Key? key}) : super(key: key);

  @override
  _DuyuruPageState createState() => _DuyuruPageState();
}

class _DuyuruPageState extends State<DuyuruPage> {
  TextEditingController _duyuru = TextEditingController();

  var db = FirebaseFirestore.instance;
  var controller = Get.put(Controller());

  GetStorage box = GetStorage();

  String now = DateFormat("dd/MM/yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Renkler().scaffoldRenk,
      body: _body(),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          bosluk(0.02),
          controller.isAdmin.value
              ? Padding(
                  padding: _paddingSymetric(20),
                  child: TextField(controller: _duyuru),
                )
              : Container(),
          bosluk(0.03),
          controller.isAdmin.value ? _duyuruEkleButton() : Container(),
          bosluk(0.03),
          _textDuyurular(),
          _streamDuyurular(),
        ],
      ),
    );
  }

  Text _textDuyurular() {
    return Text(
      "DUYURULAR",
      style: _style(),
    );
  }

  Padding _streamDuyurular() {
    return Padding(
      padding: _padding(40),
      child: SizedBox(
        height: Get.height * 0.45,
        child: Card(
          color: Renkler().containerRenk,
          shape: _cardShape(),
          shadowColor: Colors.black,
          elevation: 20,
          child: StreamBuilder<QuerySnapshot>(
            stream: db.collection("users").snapshots(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Text("Bir hata oluştu");
              } else {
                List<DocumentSnapshot> duyuruList =
                    asyncSnapshot.data?.docs ?? [];
                return ListView.builder(
                    itemCount: duyuruList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: Icon(
                            Icons.message,
                            color: Renkler().beyaz,
                          ),
                          title: Text(
                            duyuruList[index].data()?["duyuru"],
                            style: _style(),
                          ),
                          subtitle: FittedBox(
                            child: Text(
                              duyuruList[index].data()?["Kullanici"],
                              style: _style(),
                            ),
                          ),
                          trailing: controller.isAdmin.value
                              ? InkWell(
                                  onTap: () {
                                    duyuruList[index].reference.delete();
                                  },
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.arrow_forward_ios,
                                  color: Renkler().beyaz,
                                ));
                    });
              }
            },
          ),
        ),
      ),
    );
  }

  Container _duyuruEkleButton() {
    return Container(
      padding: _paddingSymetric(40),
      width: Get.width * 1,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Renkler().containerRenk, shape: StadiumBorder()),
        onPressed: () {
          final user = <String, dynamic>{
            "Kullanici": controller.kullanici.value,
            "duyuru": _duyuru.text,
          };
          db.collection("users").add(user).then(
                (DocumentReference doc) =>
                    print('DocumentSnapshot added with ID: ${doc.id}'),
              );
        },
        child: Text(
          "Duyuru Ekle",
          style: _style(),
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

  TextStyle _style() => TextStyle(color: Colors.white, fontSize: 13);

  EdgeInsets _padding(double pad) => EdgeInsets.all(pad);

  EdgeInsets _paddingSymetric(double pad) =>
      EdgeInsets.symmetric(horizontal: pad);

  AppBar _appBar() => AppBar(
        centerTitle: true,
        title: Text(
          "DUYURULAR",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      );

  bosluk(double height) {
    return SizedBox(
      height: Get.height * height,
    );
  }
}

class Renkler {
  final Color containerRenk = Colors.red.shade900;
  final beyaz = Colors.white;
  final scaffoldRenk = Colors.red.shade200;
}
