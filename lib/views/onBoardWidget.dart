import 'package:flutter/material.dart';
import 'package:motor_asin/strings.dart';
import 'package:motor_asin/views/registerPage.dart';

class onBoardScreen extends StatefulWidget {
  const onBoardScreen({Key? key}) : super(key: key);

  @override
  _onBoardScreenState createState() => _onBoardScreenState();
}

class _onBoardScreenState extends State<onBoardScreen> {
  PageController sayfaController = PageController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade100,
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: sayfaController,
        children: [
          _sheet1(Strings.ellinciYilimage),
          _sheet2(Strings.arabaImage),
          _sheet3(Strings.motorAsinBaslikimage),
        ],
      ),
    );
  }

  Icon _ikon(Color renk) {
    return Icon(
      Icons.circle,
      color: renk,
      size: 15,
    );
  }

  Column _sheet3(String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath),
        yukseklik(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Spacer(),
            Spacer(),
            _ikon(Colors.grey),
            Spacer(),
            _ikon(Colors.grey),
            Spacer(),
            _ikon(Colors.black),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text("Skip"),
                  )),
            ),
          ),
        )
      ],
    );
  }

  SizedBox yukseklik() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }

  Column _sheet2(String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath),
        yukseklik(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Spacer(),
            Spacer(),
            _ikon(Colors.grey),
            Spacer(),
            _ikon(Colors.black),
            Spacer(),
            _ikon(Colors.grey),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        )
      ],
    );
  }

  Column _sheet1(String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath),
        yukseklik(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Spacer(),
            Spacer(),
            _ikon(Colors.black),
            Spacer(),
            _ikon(Colors.grey),
            Spacer(),
            _ikon(Colors.grey),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        )
      ],
    );
  }
}
