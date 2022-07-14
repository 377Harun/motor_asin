import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:motor_asin/controller.dart';

class Kargoteslim extends StatefulWidget {
  const Kargoteslim({Key? key}) : super(key: key);

  @override
  _KargoteslimState createState() => _KargoteslimState();
}

class _KargoteslimState extends State<Kargoteslim> {
  String qrCode = 'Bilinmeyen';

  DateTime zaman = DateTime.now();

  Controller controller = Get.put(Controller());

  double enlem = 0.0;
  double boylam = 0.0;

  String urun = "";
  String musteri = "";

  var db = FirebaseFirestore.instance;

  Future<void> konumBilgisiAl() async {
    var konum = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      enlem = konum.latitude;
      boylam = konum.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: _appBar(),
      body: Column(
        children: [
          _paletSvg(),
          bosluk(0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 80,
                width: 80,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      shadowColor: Colors.black,
                      elevation: 50,
                    ),
                    onPressed: () {
                      scanQRCodeUrun();
                    },
                    child: Text("Ürun")),
              ),
              Container(
                height: 80,
                width: 80,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      shadowColor: Colors.black,
                      elevation: 50,
                    ),
                    onPressed: () {
                      scanQRCodeMusteri();
                    },
                    child: Text("Müşteri")),
              ),
            ],
          ),
          bosluk(0.08),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "ÜRÜN",
                style: _style(),
              ),
            ),
          ),
          Obx(
            () => FittedBox(
              child: Text(
                "${controller.qrcodeDegerUrun}",
                style: _style(),
              ),
            ),
          ),
          bosluk(0.03),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "MÜŞTERİ",
                style: _style(),
              ),
            ),
          ),
          Obx(() => FittedBox(
                child: Text(
                  "${controller.qrcodeDegerMusteri}",
                  style: _style(),
                ),
              )),
          bosluk(0.03),
          _teslimEtButton(),
        ],
      ),
    );
  }

  Material _paletSvg() {
    return Material(
      shadowColor: Colors.black,
      color: Colors.transparent,
      elevation: 50,
      child: Container(
        height: Get.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.red[800],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SvgPicture.asset("svg/palet.svg"),
        ),
      ),
    );
  }

  Material _teslimEtButton() {
    return Material(
      shadowColor: Colors.black,
      color: Colors.transparent,
      elevation: 50,
      child: SizedBox(
        width: Get.width * 0.65,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(), primary: Colors.red[800]),
          onPressed: () async {
            await konumBilgisiAl();
            print("kullanici : ${controller.kullanici}");
            print("ürün : ${controller.qrcodeDegerUrun}");
            print("Müşteri : ${controller.qrcodeDegerMusteri}");
            print("zaman : $zaman");
            print("enlem  : $enlem");
            print("boylam  : $boylam");

            setState(() {
              urun = controller.qrcodeDegerUrun.toString();
              musteri = controller.qrcodeDegerMusteri.toString();
            });

            await db.collection("SiparisTakip").add({
              "Boylam": boylam,
              "Enlem": enlem,
              "Zaman": zaman.toString(),
              "Musteri": musteri,
              "Teslim Eden": controller.kullanici.value,
              "Urun": urun,
            });
          },
          child: Text("Teslim Et"),
        ),
      ),
    );
  }

  SizedBox bosluk(double yukseklik) {
    return SizedBox(
      height: Get.height * yukseklik,
    );
  }

  TextStyle _style() =>
      TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold);

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.red[800],
      elevation: 0,
      title: Text(
        "KARGO TESLİM",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      centerTitle: true,
    );
  }

  Future<void> scanQRCodeUrun() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'İptal',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        controller.qrcodeDegerUrun.value = qrCode;
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

  Future<void> scanQRCodeMusteri() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'İptal',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        controller.qrcodeDegerMusteri.value = qrCode;
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
