import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Kargoteslim extends StatefulWidget {
  const Kargoteslim({Key? key}) : super(key: key);

  @override
  _KargoteslimState createState() => _KargoteslimState();
}

class _KargoteslimState extends State<Kargoteslim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        title: Text(
          "KARGO TESLİM",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Material(
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
          ),
          SizedBox(
            height: Get.height * 0.08,
          ),
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
                      print("harun");
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
                      print("harun");
                    },
                    child: Text("Müşteri")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
