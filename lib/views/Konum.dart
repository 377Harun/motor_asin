import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Konum extends StatefulWidget {
  const Konum({Key? key}) : super(key: key);

  @override
  _KonumState createState() => _KonumState();
}

class _KonumState extends State<Konum> {
  double enlem = 0.0;
  double boylam = 0.0;

  Future<void> konumBilgisiAl() async {
    var konum = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      enlem = konum.latitude;
      boylam = konum.longitude;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("ENLEM : $enlem", style: TextStyle(fontSize: 30)),
            Text("BOYLAM : $boylam", style: TextStyle(fontSize: 30)),
            ElevatedButton(
                onPressed: () {
                  konumBilgisiAl();
                },
                child: Text("Konum Bilgisi Al")),
          ],
        ),
      ),
    );
  }
}
