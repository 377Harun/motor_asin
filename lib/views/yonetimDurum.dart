import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/views/Duyurular.dart';
import 'package:get/get.dart';

class YonetimDurum extends StatefulWidget {
  const YonetimDurum({Key? key}) : super(key: key);

  @override
  _YonetimDurumState createState() => _YonetimDurumState();
}

class _YonetimDurumState extends State<YonetimDurum> {
  var controller = Get.put(Controller());

  GetStorage box = GetStorage();

  var db = FirebaseFirestore.instance;
  String kullaniciId = "";

  Future<void> durumDegistirFalse() async {
    /*  await db
        .collection('yonetim')
        .doc(YonetimDocId().yonetimDocId[controller.kullanici.value])
        .update({'durum': false});
*/

    await FirebaseFirestore.instance
        .collection("yonetim")
        .where("email", isEqualTo: controller.kullanici.value)
        .get()
        .then((res) {
      kullaniciId = res.docs[0].id;
    });
    kullaniciId.isNotEmpty
        ? await db
            .collection('yonetim')
            .doc(kullaniciId)
            .update({'durum': false})
        : null;
  }

  Future<void> durumDegistirTrue() async {
    /*  await db
        .collection('yonetim')
        .doc(YonetimDocId().yonetimDocId[controller.kullanici.value])
        .update({'durum': true});*/
    await FirebaseFirestore.instance
        .collection("yonetim")
        .where("email", isEqualTo: controller.kullanici.value)
        .get()
        .then((res) {
      kullaniciId = res.docs[0].id;
    });
    kullaniciId.isNotEmpty
        ? await db
            .collection('yonetim')
            .doc(kullaniciId)
            .update({'durum': true})
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler().scaffoldRenk,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            controller.isAdmin.value == true ? bosluk(0.2) : bosluk(0.02),
            controller.isAdmin.value == true
                ? _musaitDegilimButton()
                : Container(),
            controller.isAdmin.value == true ? bosluk(0.1) : bosluk(0.02),
            controller.isAdmin.value == true ? _musaitimButton() : Container(),
            controller.isAdmin.value == true ? bosluk(0.2) : bosluk(0.02),
            _streamYonetim(),
            bosluk(0.2),
          ],
        ),
      ),
    );
  }

  Padding _streamYonetim() {
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
            stream:
                FirebaseFirestore.instance.collection("yonetim").snapshots(),
            builder: (context, asyncsnapShot) {
              if (asyncsnapShot.hasError) {
                return Text("Hata var");
              } else {
                List<DocumentSnapshot> yonetimList =
                    asyncsnapShot.data?.docs ?? [];
                return ListView.builder(
                    itemCount: yonetimList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.message,
                          color: Renkler().beyaz,
                        ),
                        title: Text(
                          yonetimList[index].data()?["Kisi"],
                          style: _style(),
                        ),
                        trailing: yonetimList[index].data()?["durum"] == true
                            ? Icon(
                                Icons.account_circle,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.account_circle,
                                color: Colors.red,
                              ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }

  Container _musaitDegilimButton() {
    return Container(
      height: Get.height * 0.2,
      width: Get.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () {
          durumDegistirFalse();
          // setState(() {});
        },
        child: Text("Müsait Değilim"),
      ),
    );
  }

  Container _musaitimButton() {
    return Container(
      height: Get.height * 0.2,
      width: Get.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () {
          durumDegistirTrue();
          // setState(() {});
        },
        child: Text("Müsaitim"),
      ),
    );
  }

  bosluk(double height) {
    return SizedBox(
      height: Get.height * height,
    );
  }

  EdgeInsets _padding(double pad) => EdgeInsets.all(pad);

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

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "YONETİM DURUM",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
