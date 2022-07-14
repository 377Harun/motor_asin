import 'package:flutter/material.dart';

class ServisPostLearn extends StatefulWidget {
  const ServisPostLearn({Key? key}) : super(key: key);

  @override
  _ServisPostLearnState createState() => _ServisPostLearnState();
}

class _ServisPostLearnState extends State<ServisPostLearn> {
  //List<PostModel>? _items;
  String? name;
  bool _isLoading = false;
  /*late final Dio _dio;
  var _baseUrl = "https://jsonplaceholder.typicode.com/";
  @override
  void initState() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? ""),
        actions: [
          _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(),
          ),
          TextFormField(),
          TextFormField(),
          TextFormField(),
        ],
      ),
    );
  }
}
