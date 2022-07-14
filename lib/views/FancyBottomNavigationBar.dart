import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class FancyBottomSample extends StatefulWidget {
  const FancyBottomSample({Key? key}) : super(key: key);

  @override
  _FancyBottomSampleState createState() => _FancyBottomSampleState();
}

class _FancyBottomSampleState extends State<FancyBottomSample> {
  var currentPage = 0;

  List<Text> sheetList = [
    Text("Sayfa 1111"),
    Text("Sayfa 2222"),
    Text("Sayfa 3333"),
    Text("Sayfa 44444"),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Center(child: sheetList[currentPage]),
      bottomNavigationBar: FancyBottomNavigation(
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.blue,
        circleColor: Colors.blue,
        barBackgroundColor: Colors.white,
        textColor: Colors.black,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.search, title: "Search"),
          TabData(iconData: Icons.shopping_cart, title: "Basket"),
          TabData(iconData: Icons.people_alt, title: "User"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text("Fancy Bottom Navigation"),
    );
  }
}
