import 'package:flutter/material.dart';
import 'package:pokedex/views/search_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFe73135),
      ),
      home: SearchView(),
    );
  }
}
