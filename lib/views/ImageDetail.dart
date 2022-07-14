import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
Bu sorun, tüm sınıf değişkenleri final olarak bildirilmediğinde oluşur.
 Bunları ya kesinleştirebilir ya da bu uyarıyı dikkate almamak için
  sınıf bildiriminin üstüne aşağıdaki yorumu ekleyebilirsiniz:
 */

class ImageDetail extends StatefulWidget {
  ImageDetail({
    Key? key,
    this.imageUrl,
    this.imageId,
    this.imageBody,
    this.imageTitle,
    this.imageDescription,
    this.imageStock,
    this.imageRating,
    this.imageBrand,
  }) : super(key: key);

  final String? imageUrl;
  final int? imageId;
  final String? imageTitle;
  final String? imageBody;
  final String? imageDescription;
  final int? imageStock;
  final double? imageRating;
  final String? imageBrand;

  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  Color color1 = Colors.grey.shade600;
  Color color2 = Colors.black45;
  Color color3 = Colors.black45;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.imageUrl.toString(),
                  height: Get.height * 0.35,
                  width: Get.width * 1,
                  fit: BoxFit.fill,
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(top: 260),
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
                  child: Column(
                    children: [
                      bosluk(0.02),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 10, bottom: 10),
                          child: Text(
                            "${widget.imageBrand}",
                            textAlign: TextAlign.center,
                            style: _style(),
                          ),
                        ),
                      ),
                      bosluk(0.01),
                      Padding(
                        padding: _padding10(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    color1 = Colors.grey.shade600;
                                    color2 = Colors.black45;
                                    color3 = Colors.black45;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  primary: color1,
                                ),
                                child: FittedBox(child: Text("Markalar")),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    color1 = Colors.black45;
                                    color2 = Colors.grey.shade600;
                                    color3 = Colors.black45;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: color2,
                                  shape: StadiumBorder(),
                                ),
                                child: FittedBox(child: Text("Modeller")),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    color1 = Colors.black45;
                                    color2 = Colors.black45;
                                    color3 = Colors.grey.shade600;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: color3,
                                  shape: StadiumBorder(),
                                ),
                                child: FittedBox(child: Text("Ürünler")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      bosluk(0.02),
                      Padding(
                        padding: _padding10(),
                        child: Card(
                          color: Colors.black45,
                          child: Column(
                            children: [
                              bosluk(0.01),
                              ListTile(
                                leading: Text(
                                  "id : ${widget.imageId}",
                                  style: _style(),
                                ),
                                title: Text(
                                  "${widget.imageTitle}",
                                  style: _style(),
                                ),
                                trailing: Text(
                                  "${widget.imageBody}",
                                  style: _style(),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: _padding10(),
                                  child: Text(
                                    "Ürün Açıklaması : ${widget.imageDescription}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ),
                              bosluk(0.05),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Fiyat : ${widget.imageStock}  TL ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${widget.imageRating} ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    )
                                  ],
                                ),
                              ),
                              bosluk(0.01),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _floatButton(),
    );
  }

  EdgeInsets _padding10() => const EdgeInsets.symmetric(horizontal: 10);

  TextStyle _style() => TextStyle(color: Colors.white, fontSize: 16);

  FloatingActionButton _floatButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.black,
      onPressed: () {},
      label: Text("${widget.imageBrand}",
          style: TextStyle(color: Colors.white, fontSize: 12)),
      icon: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(imageUrl: widget.imageUrl.toString()),
        ),
      ),
    );
  }

  Widget bosluk(double height) {
    return SizedBox(
      height: Get.height * height,
    );
  }
}
