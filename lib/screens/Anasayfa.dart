import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motor_asin/controller.dart';

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
  @override
  void initState() {
    // TODO: implement initState

    controller.backGroundColor.value = Colors.pink;
  }
/*  void didUpdateWidget(covariant Anasayfa oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.backgroundcolor !=widget.initialColor ){
      changeBackColor(widget.initialColor);
    }
  }*/

  var hastalikController = TextEditingController();

  var controller = Get.put(Controller());

  GetStorage box = GetStorage();

  File? image;
  final _picker = ImagePicker();
  bool? showSnipper;

  Future<List<dynamic>?> KisiAl() async {
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php";
    var res = await http.get(Uri.parse(url));
    var veri = jsonDecode(res.body);
    return veri["kisiler"];
  }

  Future<void> getImageCamera() async {
    var pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
      box.write("resimKamera", pickedFile.path);
    } else {
      print("No selected");
    }
  }

  Future<void> getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
      box.write("resim", pickedFile.path);
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage() async {}

  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: controller.backGroundColor.value,
          appBar: _appbar(),
          body: _body(),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.green,
            unselectedFontSize: 12,
            selectedFontSize: 15,
            onTap: _BottomDegis,
            items: [
              BottomNavigationBarItem(
                icon: _Container(Colors.purple),
                label: "red",
              ),
              BottomNavigationBarItem(
                icon: _Container(Colors.yellow),
                label: "yellow",
              )
            ],
          ),
        ));
  }

  void _BottomDegis(value) {
    print(value);
    if (value == ChangeColr.purple.index) {
      controller.ColorChange(Colors.purple);
    } else if (value == ChangeColr.yellow.index) {
      controller.ColorChange(Colors.yellow);
    }
  }

  Container _Container(Color renk) => Container(
        height: 20,
        width: 20,
        color: renk,
      );

  AppBar _appbar() {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            onPressed: () {
              controller.ColorChange(Colors.pink);
            },
            icon: Icon(Icons.clear),
          ),
        )
      ],
      backgroundColor: Colors.blue,
      title: Text(
        "ANASAYFA",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      centerTitle: true,
    );
  }

  Center _body() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bosluk(),
            Padding(
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
                      color: Colors.red[
                          100 * (int.parse(currentLength.toString()) ~/ 2)],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
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
            ),
            Bosluk(),
            FutureBuilder<List<dynamic>?>(
              future: KisiAl(),
              builder: (context, snapshot) {
                var veri = snapshot.data;
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      color: Colors.blue,
                      child: Container(
                        height: Get.height * 0.2,
                        child: ListView.builder(
                          itemCount: veri?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                veri?[index]["kisi_ad"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else
                  return CircularProgressIndicator(
                    color: Colors.red,
                  );
              },
            ),
            GaleridenSecText(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                getImage();
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
            SizedBox(height: Get.height * 0.05),
            KamradanSecText(),
            SizedBox(height: Get.height * 0.02),
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
            SizedBox(height: Get.height * 0.02),
            ElevatedButton(
              onPressed: () {
                box.write("resimKamera", null);
                setState(() {});
              },
              child: Text("kamera Sil"),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Text KamradanSecText() =>
      Text("Kameradan Seç", style: TextStyle(color: Colors.white));

  Text GaleridenSecText() {
    return Text(
      "Galeriden Seç",
      style: TextStyle(color: Colors.white),
    );
  }

  SizedBox Bosluk() {
    return SizedBox(
      height: Get.height * 0.02,
    );
  }

  Card _card() {
    return Card(
      color: Colors.red[800],
      child: Container(
        height: Get.height * 0.15,
        width: Get.width * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              Divider(
                color: Colors.white,
                height: 2,
                thickness: 0.6,
              ),
              Text(
                "A",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
