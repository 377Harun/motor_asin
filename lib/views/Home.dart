import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/Dil.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/models/AracMarkalari.dart';
import 'package:motor_asin/models/Authantication.dart';
import 'package:motor_asin/views/Anasayfa.dart';
import 'package:motor_asin/views/Duyurular.dart';
import 'package:motor_asin/views/IsbasvuruPage.dart';
import 'package:motor_asin/views/Kargoteslim.dart';
import 'package:motor_asin/views/MusteriPage.dart';
import 'package:motor_asin/views/registerPage.dart';
import 'package:motor_asin/views/yonetimDurum.dart';
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
  void initState() {
    super.initState();

    if (box.read("dil") == "en") {
      controller.yazilar[0] =
          "Figures About Motor Aşin\nWe operate across Turkey and\nin 70 countries with 90\nthousand varieties and 1.5\nmillion products from 130";
      controller.yazilar[1] =
          "Logistics\nWe complete an average of\n 2,500 same day deliveries per\nday in 181 cities";
      controller.yazilar[2] = "We Have Been In Every\nPart For Half a Century";
    } else if (box.read("dil") == "tr") {
      controller.yazilar[0] =
          "Geniş Ürün Yelpazesi\n130 markadan 90 bin çeşit ve \n 1.5 milyon üründe Türkiye'nin her \n yerinde ve 70 ülkedeyiz.";
      controller.yazilar[1] =
          "Hızlı Teslimat \n 81 ilde aynı gün içinde\n 2500 teslimat yapıyoruz.";
      controller.yazilar[2] = "Yarım Asırdır Her\n Parçada Biz Varız.";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _advancedDrawerController.dispose();
    super.dispose();
  }

  final ValueNotifier<String> _notify = ValueNotifier<String>("");

  var controller = Get.put(Controller());

  final _advancedDrawerController = AdvancedDrawerController();

  static final String videoID = 'Un2llWs1KSc';

  var aramaYapiliyor = false;

  var kelime = TextEditingController();

  List<AracMarkalari> markaList = [
    AracMarkalari(imagePath: "images/arabalar/bmw.png", marka: "BMW"),
    AracMarkalari(imagePath: "images/arabalar/mercedes.jpg", marka: "MERCEDES"),
    AracMarkalari(
        imagePath: "images/arabalar/valskwagen.jpg", marka: "VOLKSVAGEN"),
    AracMarkalari(imagePath: "images/arabalar/audi.jpg", marka: "AUDİ"),
    AracMarkalari(imagePath: "images/arabalar/volvo.png", marka: "VOLVO"),
    AracMarkalari(imagePath: "images/arabalar/opel1.jpg", marka: "OPEL"),
    AracMarkalari(imagePath: "images/arabalar/toyota.jpg", marka: "TOYOTA"),
    AracMarkalari(imagePath: "images/arabalar/renault.png", marka: "RENAULT"),
    AracMarkalari(imagePath: "images/arabalar/man.png", marka: "MAN"),
    AracMarkalari(imagePath: "images/arabalar/porsche.jpg", marka: "PORCHE"),
    AracMarkalari(imagePath: "images/arabalar/bmw.png", marka: "BMW"),
    AracMarkalari(imagePath: "images/arabalar/mercedes.jpg", marka: "MERCEDES"),
    AracMarkalari(
        imagePath: "images/arabalar/valskwagen.jpg", marka: "VOLKSVAGEN"),
    AracMarkalari(imagePath: "images/arabalar/audi.jpg", marka: "AUDİ"),
    AracMarkalari(imagePath: "images/arabalar/volvo.png", marka: "VOLVO"),
    AracMarkalari(imagePath: "images/arabalar/opel1.jpg", marka: "OPEL"),
    AracMarkalari(imagePath: "images/arabalar/toyota.jpg", marka: "TOYOTA"),
    AracMarkalari(imagePath: "images/arabalar/renault.png", marka: "RENAULT"),
    AracMarkalari(imagePath: "images/arabalar/man.png", marka: "MAN"),
    AracMarkalari(imagePath: "images/arabalar/porsche.jpg", marka: "PORCHE"),
  ];

  GetStorage box = GetStorage();

  AuthService _auth = AuthService();

  double aspectRatio = 0.57;

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      startAt: 0,
      controlsVisibleAtStart: false,
      useHybridComposition: true,
      autoPlay: false,
      mute: false,
    ),
  );

  Widget build(BuildContext context) {
    return AdvancedDrawer(
      openRatio: 0.7,
      backdropColor: Colors.red.shade900,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      drawer: _drawerPart(),
      controller: _advancedDrawerController,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appbar(),
        body: _body(),
        floatingActionButton: _floatButton(),
        //drawer: _drawer(),
        //endDrawer: _drawerPart(),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Widget _drawerPart() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _bosluk(0.07),
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset(
              "images/motorasinLogo.png",
              height: Get.height * 0.13,
            ),
          ),
          _bosluk(0.03),
          GestureDetector(
            onTap: () {
              Get.to(
                Anasayfa(),
                fullscreenDialog: true,
                duration: Duration(milliseconds: 500),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: Text(
                "anasayfa".tr,
                style: _textstyleWhite(),
              ),
            ),
          ),
          ExpansionTile(
            trailing: SizedBox(),
            title: Text("yonetimKurulu".tr, style: _textstyleWhite()),
            leading: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
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
              title: Text(
                "sikayetHatti".tr,
                style: _textstyleWhite(),
              ),
              leading: Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
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
              title: Text(
                "isBasvurusu".tr,
                style: _textstyleWhite(),
              ),
              leading: Icon(
                Icons.people_alt_outlined,
                color: Colors.white,
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
              title: Text(
                "siparisTakip".tr,
                style: _textstyleWhite(),
              ),
              leading: Icon(
                Icons.car_repair,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _urlAc("https://b4b.motorasin.com/");
              //Get.to(B4bLoginView());
            },
            child: ListTile(
              title: Text(
                "B4B",
                style: _textstyleWhite(),
              ),
              leading: Icon(
                Icons.shop_outlined,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DuyuruPage()));
            },
            child: ListTile(
              title: Text(
                "duyurular".tr,
                style: _textstyleWhite(),
              ),
              leading: Icon(
                Icons.speaker_notes_outlined,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => YonetimDurum()));
            },
            child: ListTile(
              title: Text(
                "yonetimdurumu".tr,
                style: _textstyleWhite(),
              ),
              leading: Icon(
                Icons.people_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
          _bosluk(0.1),
          InkWell(
            onTap: () async {
              box.write("email", "sa");
              box.write("password", "sa");
              box.write("admin", false);
              box.write("giris", false);

              controller.isAdmin.value = false;
              controller.kullanici.value = "";

              await _auth.signOut();
              Get.offAll(
                RegisterPage(),
                fullscreenDialog: true,
                duration: Duration(milliseconds: 600),
              );
            },
            child: Text(
              "cikisyap".tr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          _bosluk(0.02),
          Text(Strings.motorAsin1971,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          _bosluk(0.02),
        ],
      ),
    );
  }

  TextStyle _textstyleWhite() =>
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300);

  FloatingActionButton _floatButton() {
    return FloatingActionButton.extended(
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
    );
  }

  AppBar _appbar() {
    return AppBar(
      elevation: 0,
      brightness: Brightness.light,
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
      leading: IconButton(
        onPressed: _handleMenuButtonPressed,
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: _advancedDrawerController,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
                key: ValueKey<bool>(value.visible),
              ),
            );
          },
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
      children: [
        _imageAnaResim(),
        _bosluk(0.04),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _solOk(),
                _yazi(),
                _sagOk(),
              ],
            ),
            _bosluk(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
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
                Spacer(),
              ],
            ),
          ],
        ),
        _bosluk(0.04),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ulke70(),
                  _bosluk(0.005),
                  _sube7(),
                  _bosluk(0.005),
                ],
              ),
              _bosluk(0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _marka130(),
                  _bosluk(0.005),
                  _kalite(),
                  _bosluk(0.005),
                ],
              ),
            ],
          ),
        ),
        _bosluk(0.04),
        _motorAsinYonetimKuruluTextShape("yonetimKurulu".tr, FontWeight.bold),
        _motorAsinYonetimKuruluTextShape(
            "motorAsinyonetimKurulu".tr, FontWeight.normal),
        _bosluk(0.02),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _yonetimKimdir(
                  "ramazanAsciKimdir".tr,
                  Strings.ramazanAsciKimdirDetay,
                  Strings.ramazanAsciImage,
                  Strings.ramazanAsci),
              _yonetimKimdir(
                  Strings.saimAsciKimdir,
                  Strings.saimAsciKimdirDetay,
                  Strings.saimAsciImage,
                  Strings.saimAsci),
              _yonetimKimdir(
                  Strings.fahrettinAsciKimdir,
                  Strings.fahrettinAsciKimdirDetay,
                  Strings.fahrettinAsciImage,
                  Strings.fahrettinAsci),
            ],
          ),
        ),
        _bosluk(0.04),
        _aspartLogoImage(),
        _textMotorAsinTanitim(),
        _textMotorAsinTanitimDetay(),
        _bosluk(0.02),
        Row(
          children: [
            _textUrunGruplari(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
        //Image.asset(Strings.tirJpg),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Card(
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 20,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _lottieJson(Strings.lottieCarJson)),
                    Expanded(child: _lottieJson(Strings.lottieBusJson)),
                    Expanded(child: _lottieJson(Strings.lottieSuvJson)),
                  ],
                ),
                _bosluk(0.02),
                /*SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _aracMarka3WidgetText([" AUDI ", " BMW ", " CHEVROLET "]),
                      _aracMarka3WidgetText(
                          [" HONDA ", " HYUNDAI ", " IVECO\nTRUCKS "]),
                      _aracMarka3WidgetText(
                          [" MAZDA ", " MITSUBBISHI ", " NISSAN "]),
                      _aracMarka3WidgetText([" SEAT ", " SKODA ", " TOYOTA "]),
                      _aracMarka3WidgetText(
                          [" FORD TRUCKS ", "VOLKSWAGEN", ""]),
                      _aracMarka4WidgetText(
                          [" DAF ", "DEUTZ", "KIA", " RENAULT "]),
                      _aracMarka3WidgetText(
                          [" LAND ROVER", " OPEL ", " PORSCHE "]),
                      _aracMarka3WidgetText(
                          [" MAN  ", " VOLVO  ", " SCANIA  "]),
                    ],
                  ),
                ),*/
                /* Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: Get.height * 0.36,
                    width: Get.width * 1,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: markaList.length,
                        itemBuilder: (context, indeks) {
                          return FlutterSlimyCard(
                            color: Colors.grey.shade700,
                            borderRadius: 5,
                            cardWidth: Get.width * 0.48,
                            bottomCardHeight: Get.height * 0.07,
                            topCardHeight: Get.height * 0.14,
                            topCardWidget:
                                _topCardWidgetSlimy(markaList[indeks]),
                            bottomCardWidget: _slimyBottomCardWidget(
                                markaList[indeks], "50.0"),
                          );
                        }),
                  ),
                ),*/
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: Get.height * 0.32,
                    width: Get.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: Get.width * 0.25,
                            childAspectRatio: 1,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                          ),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: markaList.length,
                          itemBuilder: (context, indeks) {
                            return Card(
                              color: Colors.white,
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(markaList[indeks]
                                          .imagePath
                                          .toString()),
                                      fit: BoxFit.fitWidth),
                                ),
                                child: Center(
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Renkler().beyaz),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _bosluk(0.02),
        GestureDetector(
          onTap: () {
            Get.defaultDialog(
              backgroundColor: Colors.black,
              titleStyle: TextStyle(color: Colors.white, fontSize: 13),
              title: "stratejikVizyon".tr,
              content: _youtubeVideo(),
            );
          },
          child: Card(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              )),
              child: SizedBox(
                  height: Get.height * 0.1,
                  width: Get.width * 0.7,
                  child: _textStratejikVizyon())),
        ),

        _hakkimizdaExpansionTile(),
        Container(
          color: Colors.blueGrey.shade900,
          child: Row(
            children: [
              _turkceButton(),
              Spacer(),
              _ingButton(),
            ],
          ),
        ),
        Divider(height: 1),
        _bizeUlasinText(),
        Container(
            color: Colors.blueGrey.shade900,
            child: Column(
              children: [
                _bosluk(0.01),
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
                _bosluk(0.01),
              ],
            )),
        _boslukRenkli(Colors.blueGrey.shade900, 0.02),
        Container(
          color: Colors.blueGrey.shade900,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _iletisimLaunch("", "images/twitter.png", Colors.white, 0),
                _iletisimLaunch(
                    "https://www.youtube.com/channel/UCp7ruES2GzEuyfRPfo7smUQ",
                    "images/youtube.png",
                    Colors.white,
                    0),
                _iletisimLaunch("https://www.linkden.com/harun-bakirci/",
                    "images/linkden.png", Colors.white, 0),
                _iletisimLaunch("https://www.instagram.com/motor.asin/",
                    "images/instagram.png", Colors.white, 15),
              ],
            ),
          ),
        ),
        Divider(height: 1),
        _herParcaImage(),
        _poweredByText(),
      ],
    );
  }

  Column _topCardWidgetSlimy(String? brand) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          brand.toString(),
          style: _textstyleWhite(),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Row _slimyBottomCardWidget(String brand, String fiyat) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          brand,
          style: TextStyle(color: Colors.white),
        ),
        Spacer(),
        Text(
          "$fiyat ",
          style: TextStyle(color: Colors.white),
        ),
        Icon(
          Icons.car_repair,
          color: Colors.white,
        )
      ],
    );
  }

  Obx _imageAnaResim() {
    return Obx(
      () => ClipRRect(
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
      ),
    );
  }

  Container _poweredByText() {
    return Container(
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
    );
  }

  Image _herParcaImage() {
    return Image.asset(
      "images/her parca.jpg",
      fit: BoxFit.fitWidth,
    );
  }

  GestureDetector _iletisimLaunch(
      String urlText, String imageText, Color renk, double paddingRight) {
    return GestureDetector(
      onTap: () {
        _urlAc(urlText);
      },
      child: Container(
        margin:
            EdgeInsets.only(left: 15, bottom: 10, top: 15, right: paddingRight),
        width: Get.width * 0.1,
        child: Image.asset(
          imageText,
          color: renk,
        ),
      ),
    );
  }

  Container _bosluk(double yukseklik) {
    return Container(
      height: Get.height * yukseklik,
    );
  }

  Container _boslukRenkli(Color renk, double yukseklik) {
    return Container(
      color: renk,
      height: Get.height * yukseklik,
    );
  }

  Container _bizeUlasinText() {
    return Container(
      width: Get.width * 1,
      color: Colors.blueGrey.shade900,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
        child: Text(
          "bizeUlasin".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Container _hakkimizdaExpansionTile() {
    return Container(
      color: Colors.blueGrey[900],
      child: ExpansionTile(
        iconColor: Colors.white,
        title: Text(
          "hakkımızda".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
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
          _boslukRenkli(Colors.transparent, 0.02),
        ],
      ),
    );
  }

  YoutubePlayer _youtubeVideo() {
    return YoutubePlayer(
      width: Get.width * 0.7,
      progressColors: ProgressBarColors(backgroundColor: Colors.red[800]),
      controller: _controller,
      liveUIColor: Colors.amber,
      showVideoProgressIndicator: true,
    );
  }

  Center _textStratejikVizyon() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "stratejikVizyon".tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  SizedBox _aracMarka3WidgetText(List marka) {
    return SizedBox(
      height: Get.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textMarka(marka[0]),
          _textMarka(marka[1]),
          _textMarka(marka[2]),
        ],
      ),
    );
  }

  SizedBox _aracMarka4WidgetText(List marka) {
    return SizedBox(
      height: Get.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textMarka(marka[0]),
          _textMarka(marka[1]),
          _textMarka(marka[2]),
          _textMarka(marka[3]),
        ],
      ),
    );
  }

  Expanded _textMarka(String text) {
    return Expanded(
        child: Text(
      "$text",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ));
  }

  Container _lottieJson(String lottieImage) {
    return Container(
      color: Colors.grey,
      height: Get.height * 0.1,
      child: Lottie.asset(lottieImage),
    );
  }

  Padding _textUrunGruplari() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
      child: Text(
        "urunGrupları".tr,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
      ),
    );
  }

  GestureDetector _textMotorAsinTanitimDetay() {
    return GestureDetector(
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
    );
  }

  Padding _textMotorAsinTanitim() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Text("motorAsinTanitim".tr),
    );
  }

  Align _aspartLogoImage() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 15),
        width: Get.width * 0.4,
        child: Image.asset(Strings.aspartLogoPng),
      ),
    );
  }

  GestureDetector _yonetimKimdir(
    String yonetimKimdir,
    String yonetimKimdirDetay,
    String yonetimKimdirImageText,
    String yonetim,
  ) {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
            radius: 60,
            backgroundColor: Colors.white,
            title: yonetimKimdir,
            titleStyle: TextStyle(color: Colors.black),
            content: Text(yonetimKimdirDetay));
      },
      child: Card(
        child: Container(
          height: Get.height * 0.3,
          width: Get.width * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(yonetimKimdirImageText),
                fit: BoxFit.fitHeight),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 5),
            child: Text(
              yonetim,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }

  Padding _motorAsinYonetimKuruluTextShape(String text, FontWeight fontTipi) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        text,
        style: TextStyle(fontWeight: fontTipi, fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }

  InkWell _kalite() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "kalite".tr,
          radius: 8,
          titleStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          content: Container(
            child: Text("kalitePolitikası".tr),
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
    );
  }

  InkWell _marka130() {
    return InkWell(
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
                    Expanded(child: Image.asset(Strings.aspartLogoPng)),
                    Expanded(child: Image.asset(Strings.nuralPng)),
                    Expanded(child: Image.asset(Strings.wabcoPng)),
                    Expanded(child: Image.asset(Strings.glaycoPng)),
                    Expanded(child: Image.asset(Strings.tenneccoPng)),
                    Expanded(child: Image.asset(Strings.goetzePng)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Image.asset(Strings.aePng)),
                    Expanded(child: Image.asset(Strings.aisinPng)),
                    Expanded(child: Image.asset(Strings.amcPng)),
                    Expanded(child: Image.asset(Strings.atcPng)),
                    Expanded(child: Image.asset(Strings.autlineaPng)),
                    Expanded(child: Image.asset(Strings.behrPng)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Image.asset(Strings.behrhellaPng)),
                    Expanded(child: Image.asset(Strings.borgwarnerPng)),
                    Expanded(child: Image.asset(Strings.beruPng)),
                    Expanded(child: Image.asset(Strings.bogePng)),
                    Expanded(child: Image.asset(Strings.bfPng)),
                    Expanded(child: Image.asset(Strings.bluePng)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Image.asset(Strings.cojaliPng)),
                    Expanded(child: Image.asset(Strings.continentalPng)),
                    Expanded(child: Image.asset(Strings.cortecoPng)),
                    Expanded(child: Image.asset(Strings.championPng)),
                    Expanded(child: Image.asset(Strings.bremiPng)),
                    Expanded(child: Image.asset(Strings.boschPng)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Image.asset(Strings.dasPng)),
                    Expanded(child: Image.asset(Strings.sparePng)),
                    Expanded(child: Image.asset(Strings.delphiPng)),
                    Expanded(child: Image.asset(Strings.euroPng)),
                    Expanded(child: Image.asset(Strings.fagPng)),
                    Expanded(child: Image.asset(Strings.fanPng)),
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
    );
  }

  InkWell _sube7() {
    return InkWell(
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
                    _subeWidget7(Strings.ankara, Strings.ankaraImage),
                    _subeWidget7(Strings.izmir, Strings.izmirImage),
                    _subeWidget7(Strings.istanbul, Strings.istanbulImage),
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
    );
  }

  Container _subeWidget7(String text, String image) {
    return Container(
      width: Get.width * 1,
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  InkWell _ulke70() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "ulkeler".tr,
          titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                      _ulkeListtile(Strings.amerika, Strings.amerikaPng),
                      _ulkeListtile(Strings.fransa, Strings.fransaPng),
                      _ulkeListtile(Strings.almanya, Strings.almanyaPng),
                      _ulkeListtile(Strings.ingiltere, Strings.ingilterePng),
                      _ulkeListtile(Strings.cin, Strings.cinPng),
                      _ulkeListtile(Strings.almanya, Strings.almanyaPng),
                      _ulkeListtile(Strings.almanya, Strings.almanyaPng),
                      _ulkeListtile(Strings.almanya, Strings.almanyaPng),
                      _ulkeListtile(Strings.cin, Strings.cinPng),
                      _ulkeListtile(Strings.ingiltere, Strings.ingilterePng),
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
    );
  }

  ListTile _ulkeListtile(String text, String image) {
    return ListTile(
      title: Text(text),
      leading: Container(
        height: Get.height * 0.04,
        child: Image.asset(
          image,
          gaplessPlayback: true,
        ),
      ),
      trailing: Icon(Icons.flag_rounded),
    );
  }

  ElevatedButton _turkceButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0,
      ),
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
        controller.yazilar[2] = "Yarım Asırdır Her\n Parçada Biz Varız.";
      },
      child: Image.asset(
        "images/ulkeler/turkey.png",
        height: Get.height * 0.05,
      ),
    );
  }

  ElevatedButton _ingButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0,
      ),
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
    );
  }

  Expanded _sagOk() {
    return Expanded(
      child: IconButton(
        onPressed: () {
          if (controller.resim.value == Strings.motorAsinBaslikimage) {
            controller.resim.value = Strings.ellinciYilimage;
          } else if (controller.resim.value == Strings.ellinciYilimage) {
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
    );
  }

  Container _yazi() {
    return Container(
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
    );
  }

  Expanded _solOk() {
    return Expanded(
      child: IconButton(
        onPressed: () {
          Get.to(
            Anasayfa(),
            fullscreenDialog: true,
            duration: Duration(milliseconds: 500),
          );
        },
        icon: Icon(
          Icons.arrow_left,
          color: Colors.black,
        ),
      ),
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
                title: Text("sikayetHatti".tr),
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
                //Get.to(B4bLoginView());
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DuyuruPage()));
              },
              child: ListTile(
                title: Text("duyurular".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.speaker_notes,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YonetimDurum()));
              },
              child: ListTile(
                title: Text("yonetimdurumu".tr),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                leading: Icon(
                  Icons.people_alt,
                ),
              ),
            ),
            _bosluk(0.1),
            InkWell(
              onTap: () async {
                box.write("email", "sa");
                box.write("password", "sa");
                box.write("giris", false);
                box.write("admin", false);

                controller.isAdmin.value = false;
                controller.kullanici.value = "";

                await _auth.signOut();
                Get.offAll(
                  RegisterPage(),
                  fullscreenDialog: true,
                  duration: Duration(milliseconds: 600),
                );
              },
              child: Text(
                "cikisyap".tr,
                style: TextStyle(
                    color: Colors.red[800], fontWeight: FontWeight.bold),
              ),
            ),
            _bosluk(0.02),
            Text(
              Strings.motorAsin1971,
              style: TextStyle(
                  color: Colors.red[800], fontWeight: FontWeight.bold),
            ),
            _bosluk(0.02),
          ],
        ),
      ),
    );
  }
}

Future _urlAc(String link) async {
  await launch(link, universalLinksOnly: true);
}
