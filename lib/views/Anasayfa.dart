import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motor_asin/controller.dart';
import 'package:motor_asin/models/ImageModel.dart';
import 'package:motor_asin/models/Model.dart';
import 'package:motor_asin/views/FancyBottomNavigationBar.dart';
import 'package:motor_asin/views/ImageDetail.dart';
import '../strings.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

enum ChangeColr {
  purple,
  yellow,
}

class _AnasayfaState extends State<Anasayfa> {
  var _fecthData;

  void initState() {
    _fecthData = resimAlFutureiki();
    super.initState();
    controller.backGroundColor.value = Colors.blueGrey;
  }

  @override
  void dispose() {
    pageController.dispose();
    hastalikController.dispose();
    super.dispose();
  }

  final pageController = PageController(initialPage: 1);

  var hastalikController = TextEditingController();

  var controller = Get.put(Controller());

  GetStorage box = GetStorage();

  bool isCrossfadeFirst = true;

  File? image;
  final _picker = ImagePicker();
  bool? showSnipper;
  List<PostModel>? items;
  List<ImageModel>? itemsImage;
  bool? isLoading;

  Future<List<ImageModel>?> resimAlFutureiki() async {
    List<ImageModel>? resimler;
    var url = "https://dummyjson.com/products";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == HttpStatus.ok) {
      var veri = jsonDecode(res.body)["products"];

      if (veri is List) {
        setState(() {
          resimler = veri.map((e) => ImageModel.fromJson(e)).toList();
        });
      }
      return resimler;
    }
  }

  Future<void> getImageCamera() async {
    var pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
      box.write("resimKamera", pickedFile.path);
    }
  }

  Future<void> getImageGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
      box.write("resim", pickedFile.path);
    }
  }

  // sayfa bu sekildede değiştirilebilir.
  // sayfalar liste içerisine alınıp liste indeksi body kısmına yazıdıırılabilir.
  //  sayfaListesi[0]

  Future<void> uploadImage() async {}

  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: controller.backGroundColor.value,
          appBar: _appbar(),
          body: controller.pageIndex.value == 0
              ? _body()
              : controller.pageIndex.value == 1
                  ? Container(
                      color: controller.backGroundColor.value,
                      child: Center(
                          child: Text(
                        "Sayfa 2 ",
                        style: TextStyle(color: Colors.white),
                      )),
                    )
                  : Container(
                      color: controller.backGroundColor.value,
                      child: Center(
                          child: Text(
                        "Sayfa 3",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: controller.backGroundColor.value,
            color: Colors.blueGrey.shade800,
            buttonBackgroundColor: Colors.blueGrey.shade800,
            onTap: (index) {
              controller.pageIndex.value = index;
            },
            items: [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.menu,
                color: Colors.white,
              ),
              Icon(
                Icons.school,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }

  Center _body() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () {
          _fecthData = resimAlFutureiki();
          return _fecthData;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bosluk(),
              _textFormField(),
              bosluk(),
              Text("FutureBuilder iki", style: _styleWhite()),
              bosluk(),
              bosluk(),
              FutureBuilder<List<ImageModel>?>(
                  future: _fecthData,
                  builder: (context, snapshot) {
                    List<ImageModel>? veri = snapshot.data;
                    if (snapshot.hasData) {
                      return Container(
                        height: Get.height * 0.3,
                        child: ListView.builder(
                            itemCount: veri?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: _horizontalPadding(),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      ImageDetail(
                                        imageUrl: veri?[index].thumbnail,
                                        imageBody: veri?[index].category,
                                        imageId: veri?[index].id,
                                        imageTitle: veri?[index].title,
                                        imageDescription:
                                            veri?[index].description,
                                        imageStock: veri?[index].stock,
                                        imageRating: veri?[index].rating,
                                        imageBrand: veri?[index].brand,
                                      ),
                                      fullscreenDialog: true,
                                      duration: Duration(milliseconds: 500),
                                    );
                                  },
                                  child: Card(
                                    elevation: 30,
                                    shadowColor: Colors.black,
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          veri?[index].thumbnail.toString() ??
                                              "https://dummyjson.com/image/i/products/1/thumbnail.jpg",
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Text(
                                            "${veri?[index].title}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.black,
                      );
                    }
                  }),
              bosluk(),
              bosluk(),
              galeridenSecText(),
              bosluk(),
              InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  child: box.read("resim") == null
                      ? Center(child: Text("Pick Image"))
                      : Container(
                          child: Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              File(File(box.read("resim")).path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )),
                        ),
                ),
              ),
              bosluk(),
              bosluk(),
              kamradanSecText(),
              bosluk(),
              InkWell(
                onTap: () {
                  getImageCamera();
                },
                child: Container(
                  child: box.read("resimKamera") == null
                      ? Center(child: Text("Pick Image From Kamera"))
                      : Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              File(File(box.read("resimKamera")).path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              bosluk(),
              _elevatedResimKameraSil(),
              bosluk(),
              _popUpMenuButton(),
              _pageControllerButton(),
              SizedBox(
                height: Get.height * 0.3,
                width: Get.width * 1,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  onPageChanged: (index) {
                    print("page ${index + 1}");
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: _containerPageview(
                          "Merhaba",
                          "bu bir altyazıdır merhabalar sanjrsak ksakjsak\nsakösmaskamksamkasksaa jajaj jjsajsajj \nsajsaj jjsajajj",
                          Strings.motorAsinBaslikimage,
                          [Colors.black, Colors.grey, Colors.grey]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: _containerPageview(
                          "Merhaba",
                          "bu bir altyazıdır sasakk ksasakm\n sajjajJ SJSAJ JSAJsjsj jsjsjjj\snaja",
                          Strings.ellinciYilimage,
                          [Colors.grey, Colors.black, Colors.grey]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: _containerPageview(
                          "Merhaba",
                          "altyazı eklendir sakaskak",
                          Strings.arabaImage,
                          [Colors.grey, Colors.grey, Colors.black]),
                    ),
                  ],
                ),
              ),
              bosluk(),
              bosluk(),
              bosluk(),
              bosluk(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: Get.height * 0.25,
                      width: Get.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage(
                            Strings.arabaImage,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.18,
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        Strings.arabaImage,
                      ),
                      fit: BoxFit.fitHeight,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          title: Text("Merhaba",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "Merhaba sajshajhsajsahsjah\nsajshahsa",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              "Merhaba",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bosluk(),
              bosluk(),
              bosluk(),
              bosluk(),
              FutureBuilder<List<ImageModel>?>(
                future: _fecthData,
                builder: (context, snapshot) {
                  List<ImageModel>? resimListesi = snapshot.data;
                  return Container(
                    height: snapshot.hasData ? Get.height * 0.7 : 30,
                    width: snapshot.hasData ? Get.width * 0.7 : 30,
                    child: snapshot.hasData
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: resimListesi?.length,
                            itemBuilder: (context, indeks) {
                              return Row(
                                children: [
                                  FlutterSlimyCard(
                                    color: Colors.teal,
                                    borderRadius: 30,
                                    cardWidth: Get.width * 0.7,
                                    topCardWidget: _topCardWidgetSlimy(
                                      resimListesi?[indeks]
                                          .thumbnail
                                          .toString(),
                                      "${resimListesi?[indeks].brand}",
                                      "${resimListesi?[indeks].description}",
                                    ),
                                    bottomCardWidget: _slimyBottomCardWidget(
                                        resimListesi?[indeks]
                                            .thumbnail
                                            .toString(),
                                        "${resimListesi?[indeks].brand}",
                                        "${resimListesi?[indeks].price}"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              );
                            })
                        : CircularProgressIndicator(),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(FancyBottomSample());
                },
                child: Text(
                  "Fancy Button",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              bosluk(),
              bosluk(),
              Text(
                "Harun",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "Harun",
                style: context.textTema().headline2,
              ),
              Text(
                "Tema size",
                style: context.textTema().subtitle1,
              ),
              Text(
                "${10.onKati()}",
                style: context.textTema().bodyText1,
              ),
              Text(
                  "style: context.textTema().subtitle1,\nextension buildContextExtension on BuildContext {\nTextTheme textTema() {\nreturn Theme.of(this).textTheme;\n}}"),
              bosluk(),
              bosluk(),
              _pageviewNoktaDinamik(),
              bosluk(),
              _animatedCrossFade(),
              bosluk(),
              bosluk(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCrossfadeFirst = !isCrossfadeFirst;
                  });
                },
                child: Text("Animated Change"),
              ),
              bosluk(),
              bosluk(),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedCrossFade _animatedCrossFade() {
    return AnimatedCrossFade(
      firstChild: Container(
        color: Colors.blue,
        height: 12,
        width: Get.width * 0.5,
      ),
      secondChild: Text(
        "Harun Baba",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      crossFadeState: isCrossfadeFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      sizeCurve: Curves.elasticIn,
      firstCurve: Curves.bounceOut,
      secondCurve: Curves.easeInQuad,
      duration: Duration(seconds: 2),
    );
  }

  SizedBox _pageviewNoktaDinamik() {
    return SizedBox(
      height: 100,
      width: 200,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          controller.noktaIndex.value = value;
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.asset(Strings.motorAsinBaslikimage),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 3; i = i + 1)
                    Obx(() => Icon(
                          Icons.cloud,
                          color: controller.noktaIndex.value == i
                              ? Colors.black
                              : Colors.white,
                        ))
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Column _topCardWidgetSlimy(
      String? imagePath, String aciklama, String aciklamaDetay) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: imagePath ??
                "https://dummyjson.com/image/i/products/1/thumbnail.jpg",
            fit: BoxFit.fitWidth,
            width: Get.width * 0.4,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text(
            aciklama,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            aciklamaDetay,
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  ListTile _slimyBottomCardWidget(
      String? imagePath, String brand, String fiyat) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imagePath ??
              "https://dummyjson.com/image/i/products/1/thumbnail.jpg",
          fit: BoxFit.fitWidth,
          width: Get.width * 0.1,
        ),
      ),
      title: Text(
        brand,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$fiyat ",
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.monetization_on,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  PopupMenuButton<int> _popUpMenuButton() {
    return PopupMenuButton(
      child: Icon(Icons.open_in_new),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("harun 1"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("harun 2"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("harun 3"),
        ),
        PopupMenuItem(
          value: 4,
          child: Text("Button"),
        )
      ],
      onCanceled: () {
        //print("Seçim yapılmadı");
      },
      onSelected: (menuItemValue) {
        if (menuItemValue == 1) {
          // print("harun 1 seçildi.");
        } else if (menuItemValue == 2) {
          // print("harun 2 seçildi.");
        } else if (menuItemValue == 3) {
          // print("harun 3 seçildi.");
        }
      },
    );
  }

  Row _pageControllerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              pageController.previousPage(
                duration: Duration(seconds: 2),
                curve: Curves.bounceOut,
              );
            },
            icon: Icon(Icons.arrow_left)),
        IconButton(
            onPressed: () {
              pageController.nextPage(
                duration: Duration(seconds: 2),
                curve: Curves.bounceOut,
              );
            },
            icon: Icon(Icons.arrow_right)),
      ],
    );
  }

  Column _containerPageview(String title, String subtitle, String imagePath,
      List<Color?> renklistesi) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: Get.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.fitHeight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bosluk(),
                ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    subtitle,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      Text(
                        "4,5",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Harun BAKIRCI",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
        ),
        bosluk(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Spacer(),
            Spacer(),
            Icon(Icons.circle, color: renklistesi[0], size: 12.5),
            Spacer(),
            Icon(Icons.circle, color: renklistesi[1], size: 12.5),
            Spacer(),
            Icon(Icons.circle, color: renklistesi[2], size: 12.5),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ],
    );
  }

  ElevatedButton _elevatedResimKameraSil() {
    return ElevatedButton(
      onPressed: () {
        box.write("resimKamera", null);
        setState(() {});
      },
      child: Text("kamera Sil"),
    );
  }

  EdgeInsets _horizontalPadding() => const EdgeInsets.symmetric(horizontal: 50);

  Padding _textFormField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        autocorrect: true,
        keyboardType: TextInputType.number,
        controller: hastalikController,
        style: TextStyle(color: Colors.white),
        maxLength: 19,
        readOnly: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.white,
          ),
          suffixIcon: InkWell(
            onTap: () {
              hastalikController.clear();
            },
            child: Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
          ),
          fillColor: Colors.black,
          filled: true,
          hintText: "Mail",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        buildCounter: (_,
            {int? currentLength, int? maxLength, bool? isFocused}) {
          return Container(
            decoration: BoxDecoration(
              color:
                  Colors.red[100 * (int.parse(currentLength.toString()) ~/ 2)],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
            ),
            width: 15.0 * (int.parse(currentLength.toString()) / 2),
            height: Get.height * 0.02,
            child: Text(
              "Merhaba",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          );
        },
      ),
    );
  }

  TextStyle _styleWhite() => TextStyle(color: Colors.white, fontSize: 16);

  Text kamradanSecText() =>
      Text("Kameradan Seç", style: TextStyle(color: Colors.white));

  Text galeridenSecText() {
    return Text(
      "Galeriden Seç",
      style: TextStyle(color: Colors.white),
    );
  }

  SizedBox bosluk() {
    return SizedBox(
      height: Get.height * 0.02,
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _TextAnasayfa(),
      centerTitle: true,
    );
  }
}

class _TextAnasayfa extends StatelessWidget {
  const _TextAnasayfa({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "ANASAYFA",
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }
}

extension buildContextExtension on BuildContext {
  TextTheme textTema() {
    return Theme.of(this).textTheme;
  }
}

extension buildExtensionInt on int {
  onKati() {
    return this * 10;
  }
}
