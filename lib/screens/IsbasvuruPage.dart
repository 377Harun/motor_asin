import 'package:flutter/material.dart';

class Isbasvurusu extends StatefulWidget {
  const Isbasvurusu({Key? key}) : super(key: key);

  @override
  _IsbasvurusuState createState() => _IsbasvurusuState();
}

class _IsbasvurusuState extends State<Isbasvurusu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "İŞ BAŞVURUSU",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.green[800],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(""),
        ],
      ),
    );
  }
}
