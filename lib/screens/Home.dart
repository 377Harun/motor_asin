import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/Dil.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/screens/Anasayfa.dart';
import 'package:motor_asin/screens/IsbasvuruPage.dart';
import 'package:motor_asin/screens/Kargoteslim.dart';
import 'package:motor_asin/screens/Konum.dart';
import 'package:motor_asin/screens/MusteriPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:motor_asin/strings.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  //@override
  var controller = Get.put(Controller());

  static final String videoID = 'Un2llWs1KSc';

  var aramaYapiliyor = false;

  var kelime = TextEditingController();

  GetStorage box = GetStorage();

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(),
      body: _body(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.phone,
          color: Colors.white,
        ),
        onPressed: () {
          _urlAc("tel:${Strings.tel}");
        },
        label: Text(
          "ara".tr,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black45,
        //splashColor: Colors.black,
      ),
      drawer: _drawer(),
    );
  }

  AppBar _appbar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.red.shade900,
                Colors.red.shade800,
                Colors.red.shade800,
                Colors.grey.shade800,
                Colors.grey.shade500,
                Colors.grey
              ]),
        ),
      ),
      title: aramaYapiliyor
          ? TextFormField(
              style: TextStyle(color: Colors.white),
              controller: kelime,
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (kelime.text == Strings.iss) {
                  Get.to(
                    Isbasvurusu(),
                    fullscreenDialog: true,
                    duration: Duration(milliseconds: 500),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                } else if (kelime.text == Strings.musteri) {
                  Get.to(
                    MusteriPage(),
                    fullscreenDialog: true,
                    duration: Duration(milliseconds: 500),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Arama",
                hintStyle: TextStyle(color: Colors.white),
              ),
            )
          : Text(
              Strings.motorAsin,
              style: TextStyle(fontSize: 15),
            ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            kelime.clear();
            FocusManager.instance.primaryFocus?.unfocus();

            setState(() {
              if (aramaYapiliyor == true) {
                aramaYapiliyor = false;
              } else if (aramaYapiliyor == false) {
                aramaYapiliyor = true;
              }
            });
          },
          icon: aramaYapiliyor
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.cancel_sharp,
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _body() {
    return ListView(
      scrollDirection: Axis.vertical,
      //physics: BouncingScrollPhysics(),
      children: [
        Obx(() => ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                topRight: Radius.circular(0),
                topLeft: Radius.circular(0),
              ),
              child: Image.asset(
                controller.resim.value,
                fit: BoxFit.fitWidth,
                gaplessPlayback: true,
              ),
            )),
        SizedBox(
          height: Get.height * 0.04,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      print("harun");
                      Get.to(
                        Anasayfa(),
                        fullscreenDialog: true,
                        duration: Duration(milliseconds: 500),
                      );
                      /*  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => Anasayfa(),
                        ),
                      );*/
                    },
                    icon: Icon(
                      Icons.arrow_left,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.08,
                  child: Obx(
                    () => Center(
                      child: Text(
                        "${controller.yazilar[controller.index.value].obs}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      if (controller.resim.value ==
                          Strings.motorAsinBaslikimage) {
                        controller.resim.value = Strings.ellinciYilimage;
                      } else if (controller.resim.value ==
                          Strings.ellinciYilimage) {
                        controller.resim.value = Strings.arabaImage;
                      } else if (controller.resim.value == Strings.arabaImage) {
                        controller.resim.value = Strings.motorAsinBaslikimage;
                      }

                      if (controller.index.value == 0) {
                        controller.index.value = controller.index.value + 1;
                        controller.renkler[0] = Colors.grey;
                        controller.renkler[1] = Colors.black;
                        controller.renkler[2] = Colors.grey;
                      } else if (controller.index.value == 1) {
                        controller.index.value = controller.index.value + 1;
                        controller.renkler[0] = Colors.grey;
                        controller.renkler[1] = Colors.grey;
                        controller.renkler[2] = Colors.black;
                      } else if (controller.index.value == 2) {
                        controller.index.value = 0;
                        controller.renkler[0] = Colors.black;
                        controller.renkler[1] = Colors.grey;
                        controller.renkler[2] = Colors.grey;
                      }
                    },
                    icon: Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      Dil.dil = false;
                    });

                    Get.updateLocale(Locale("tr", "TR"));
                    box.write("dil", "tr");

                    controller.yazilar[0] =
                        "Geniş Ürün Yelpazesi\n130 markadan 90 bin çeşit ve \n 1.5 milyon üründe Türkiye'nin her \n yerinde ve 70 ülkedeyiz.";
                    controller.yazilar[1] =
                        "Hızlı Teslimat \n 81 ilde aynı gün içinde\n 2500 teslimat yapıyoruz.";
                    controller.yazilar[2] =
                        "Yarım Asırdır Her\n Parçada Biz Varız.";
                  },
                  child: Image.asset(
                    "images/ulkeler/turkey.png",
                    height: Get.height * 0.05,
                  ),
                ),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Obx(
                  () => Icon(
                    Icons.circle,
                    color: controller.renkler[0],
                    size: 8,
                  ),
                ),
                Spacer(),
                Obx(
                  () => Icon(
                    Icons.circle,
                    color: controller.renkler[1],
                    size: 8,
                  ),
                ),
                Spacer(),
                Obx(
                  () => Icon(
                    Icons.circle,
                    color: controller.renkler[2],
                    size: 8,
                  ),
                ),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      Dil.dil = true;
                    });

                    Get.updateLocale(Locale("en", "US"));
                    box.write("dil", "en");

                    controller.yazilar[0] =
                        "Figures About Motor Aşin\nWe operate across Turkey and\nin 70 countries with 90\nthousand varieties and 1.5\nmillion products from 130";

                    controller.yazilar[1] =
                        "Logistics\nWe complete an average of\n 2,500 same day deliveries per\nday in 181 cities";
                    controller.yazilar[2] =
                        "We Have Been In Every\nPart For Half a Century";
                  },
                  child: Image.asset(
                    Strings.ingilterePng,
                    height: Get.height * 0.045,
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.04),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          backgroundColor: Colors.white,
                          title: "ulkeler".tr,
                          titleStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          titlePadding: EdgeInsets.only(top: 20),
                          content: Column(
                            children: [
                              Container(
                                height: Get.height * 0.2,
                                child: Lottie.asset("images/world.json"),
                              ),
                              Container(
                                height: Get.height * 0.35,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(Strings.amerika),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.amerikaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.fransa),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.fransaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.ingiltere),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child:
                                              Image.asset(Strings.ingilterePng),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.cin),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.cinPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                      ListTile(
                                        title: Text(Strings.almanya),
                                        leading: Container(
                                          height: Get.height * 0.04,
                                          child: Image.asset(
                                            Strings.almanyaPng,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                        trailing: Icon(Icons.flag_rounded),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: Get.width * 0.09,
                              child: Image.asset(
                                Strings.ulkeIconPng,
                                color: Colors.white,
                                gaplessPlayback: true,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(
                              "ulke".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.005),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: Get.height * 0.5,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 1,
                                      height: Get.height * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(Strings.ankaraImage),
                                            fit: BoxFit.fitWidth),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          Strings.ankara,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 1,
                                      height: Get.height * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(Strings.izmirImage),
                                            fit: BoxFit.fitWidth),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          Strings.izmir,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 1,
                                      height: Get.height * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                Strings.istanbulImage),
                                            fit: BoxFit.fitWidth),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          Strings.istanbul,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Image.asset(Strings.motorAsinBaslikimage),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.09,
                              child: Image.asset(
                                Strings.konumPng,
                                color: Colors.white,
                                gaplessPlayback: true,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(
                              "sube".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.005),
                  ],
                ),
                SizedBox(height: Get.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            backgroundColor: Colors.white,
                            title: "markalar".tr,
                            radius: 8,
                            titleStyle: TextStyle(
                              //color: Colors.red.shade800, fontWeight: FontWeight.bold,),
                              color: Colors.black, fontWeight: FontWeight.bold,
                            ),
                            content: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                      Strings.aspartLogoPng,
                                      gaplessPlayback: true,
                                    )),
                                    Expanded(
                                        child: Image.asset(Strings.nuralPng)),
                                    Expanded(
                                        child: Image.asset(Strings.wabcoPng)),
                                    Expanded(
                                        child: Image.asset(Strings.glaycoPng)),
                                    Expanded(
                                        child:
                                            Image.asset(Strings.tenneccoPng)),
                                    Expanded(
                                        child: Image.asset(Strings.goetzePng)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Image.asset(Strings.aePng)),
                                    Expanded(
                                        child: Image.asset(Strings.aisinPng)),
                                    Expanded(
                                        child: Image.asset(Strings.amcPng)),
                                    Expanded(
                                        child: Image.asset(Strings.atcPng)),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/autlinea.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/behr.png")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/behrhella.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/borgwarner.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/beru.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/boge.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/bf.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/blue.png")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/cojali.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/continental.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/corteco.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/champion.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/bremi.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/bosch.png")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/das.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/spare.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/delphi.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/euro.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/fag.png")),
                                    Expanded(
                                        child: Image.asset(
                                            "images/markalar/fan.png")),
                                  ],
                                ),
                              ],
                            ));
                      },
                      child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.09,
                              child: Image.asset(
                                Strings.markaPng,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(
                              "marka".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.005),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          backgroundColor: Colors.white,
                          title: "markalar".tr,
                          radius: 8,
                          titleStyle: TextStyle(
                            //color: Colors.red.shade800, fontWeight: FontWeight.bold,),
                            color: Colors.black, fontWeight: FontWeight.bold,
                          ),
                          content: Container(
                            child: Text("Kalite Politikası"),
                          ),
                        );
                      },
                      child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.09,
                              child: Icon(
                                Icons.high_quality_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "kalite".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.005),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.04),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "yonetimKurulu".tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "motorAsinyonetimKurulu".tr,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    title: "ramazanAsciKimdir".tr,
                    titleStyle: TextStyle(color: Colors.black),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset(
                                Strings.ramazanAsciImage,
                                width: 50,
                              ),
                            ),
                            Text(Strings.ramazanAsci),
                          ],
                        ),
                        Text(Strings.ramazanAsciKimdirAciklama),
                      ],
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    height: Get.height * 0.3,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            Strings.ramazanAsciImage,
                          ),
                          fit: BoxFit.fitHeight),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 5),
                      child: Text(
                        Strings.ramazanAsci,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      //backgroundColor: Colors.red.shade200,
                      backgroundColor: Colors.white,
                      title: Strings.saimAsciKimdir,
                      titleStyle: TextStyle(color: Colors.black),
                      content: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Strings.saimAsciKimdirDetay,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ));
                },
                child: Card(
                  child: Container(
                    height: Get.height * 0.3,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Strings.saimAsciImage),
                          fit: BoxFit.fitHeight),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: Text(
                        Strings.saimAsci,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      backgroundColor: Colors.white,
                      title: Strings.fahrettinAsciKimdir,
                      titleStyle: TextStyle(color: Colors.black),
                      content: Text(Strings.fahrettinAsciKimdirDetay));
                },
                child: Card(
                  child: Container(
                    height: Get.height * 0.3,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Strings.fahrettinAsciImage),
                          fit: BoxFit.fitHeight),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: Text(
                        Strings.fahrettinAsci,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(left: 15),
            width: Get.width * 0.4,
            child: Image.asset(Strings.aspartLogoPng),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text("motorAsinTanitim".tr),
        ),
        GestureDetector(
          onTap: () {
            Get.defaultDialog(
                backgroundColor: Colors.white,
                title: Strings.aspart,
                radius: 10,
                content: Text(
                  "motorAsinTanitimDetay".tr,
                ));
          },
          child: ListTile(
            title: Text(
              "dahaFazla".tr,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            // trailing: Icon(Icons.arrow_forward),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
          child: Text(
            "urunGrupları".tr,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Card(
            color: Colors.grey[300],
            shadowColor: Colors.black,
            elevation: 0,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[500],
                        height: Get.height * 0.1,
                        child: Lottie.asset(
                          Strings.lottieCarJson,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[500],
                        height: Get.height * 0.1,
                        child: Lottie.asset(Strings.lottieBusJson),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[500],
                        height: Get.height * 0.1,
                        child: Lottie.asset(Strings.lottieSuvJson),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.audiPng)),
                            Expanded(child: Image.asset(Strings.bmwPng)),
                            Expanded(
                              child: Image.asset(Strings.chevroletPng),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.hondaPng)),
                            Expanded(child: Image.asset(Strings.hyundaiPng)),
                            Expanded(child: Image.asset(Strings.ivecoPng)),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.mazdaPng)),
                            Expanded(child: Image.asset(Strings.mitsubishiPng)),
                            Expanded(child: Image.asset(Strings.nissanPng)),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.seatPng)),
                            Expanded(child: Image.asset(Strings.skodaPng)),
                            Expanded(child: Image.asset(Strings.toyotaPng)),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.fordPng)),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(child: Image.asset(Strings.volkswagenPng)),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.dafPng)),
                            Expanded(child: Image.asset(Strings.deutzPng)),
                            Expanded(child: Image.asset(Strings.kiaPng)),
                            Expanded(child: Image.asset(Strings.renaultPng)),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.height * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(Strings.landRoverPng)),
                            Expanded(child: Image.asset(Strings.opelPng)),
                            Expanded(child: Image.asset(Strings.porschePng)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: Get.height * 0.3,
                          child: Column(
                            children: [
                              Expanded(child: Image.asset(Strings.manPng)),
                              Expanded(child: Image.asset(Strings.volvoPng)),
                              Expanded(
                                child: Image.asset(Strings.scalaPng),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        GestureDetector(
          onTap: () {
            if (controller.videoVisibility.value == false) {
              controller.videoVisibility.value = true;
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "stratejikVizyon".tr,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.videoVisibility.value,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: YoutubePlayer(
                  progressColors:
                      ProgressBarColors(backgroundColor: Colors.red[800]),
                  controller: _controller,
                  liveUIColor: Colors.amber,
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          color: Colors.blueGrey[900],
          child: ExpansionTile(
            iconColor: Colors.white,
            title: Text(
              "hakkımızda".tr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.merhaba,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.merhaba,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.merhaba,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          width: Get.width * 1,
          color: Colors.blueGrey.shade900,
          child: Padding(
            padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
            child: Text(
              "bizeUlasin".tr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
            color: Colors.blueGrey.shade900,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      _urlAc("tel:${Strings.tel}");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Text(
                          "+90 (212) 473 49 49",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _urlAc("mailto:${Strings.mail}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Text(
                          Strings.mail,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        Strings.adres,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                )
              ],
            )),
        Container(
          color: Colors.blueGrey[900],
          height: 10,
        ),
        Container(
          color: Colors.blueGrey.shade900,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    print("harun");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, bottom: 10, top: 15),
                    width: Get.width * 0.1,
                    child: Image.asset(
                      "images/twitter.png",
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _urlAc(
                        "https://www.youtube.com/channel/UCp7ruES2GzEuyfRPfo7smUQ");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, bottom: 10, top: 15),
                    width: Get.width * 0.1,
                    child: Image.asset(
                      "images/youtube.png",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _urlAc("https://www.linkden.com/harun-bakirci/");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, bottom: 10, top: 15),
                    width: Get.width * 0.1,
                    child: Image.asset(
                      "images/linkden.png",
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _urlAc("https://www.instagram.com/motor.asin/");
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, bottom: 10, top: 15, right: 15),
                    width: Get.width * 0.08,
                    child: Image.asset(
                      "images/instagram.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          child: Image.asset(
            "images/her parca.jpg",
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          color: Colors.black,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "© 2022 MOTOR AŞİN | TÜM HAKLARI SAKLIDIR Powered By Harun BAKIRCI",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xfff7f7f7),
              child: Image.asset(
                "images/motorasinLogo.png",
                height: Get.height * 0.25,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  Anasayfa(),
                  fullscreenDialog: true,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text("anasayfa".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            ExpansionTile(
              title: Text("yonetimKurulu".tr),
              leading: Icon(Icons.account_circle),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.arrow_forward_ios),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset("images/saim asci.jpg"),
                      ),
                    ),
                    title: Text(Strings.saimAsci),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset("images/ramazan asci.jpg"),
                      ),
                    ),
                    title: Text(Strings.ramazanAsci),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          "images/fahrettin asci.jpg",
                        ),
                      ),
                    ),
                    title: Text(
                      Strings.fahrettinAsci,
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  MusteriPage(),
                  fullscreenDialog: true,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: ListTile(
                title: Text("musterimizOl".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.add_shopping_cart,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  Isbasvurusu(),
                  fullscreenDialog: true,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: ListTile(
                title: Text("isBasvurusu".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.people_alt,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  Kargoteslim(),
                  fullscreenDialog: true,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: ListTile(
                title: Text("siparisTakip".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.car_repair,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _urlAc("https://b4b.motorasin.com/");
              },
              child: ListTile(
                title: Text("B4B"),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.shop,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Konum()));
              },
              child: ListTile(
                title: Text("konum".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.location_on,
                ),
              ),
            ),
            //Spacer(),
            SizedBox(
              height: Get.height * 0.2,
            ),
            Text(
              Strings.motorAsin1971,
              style: TextStyle(
                  color: Colors.red[800], fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

Future _urlAc(String link) async {
  await launch(link, universalLinksOnly: true);
}
