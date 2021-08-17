import 'package:flutter/material.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        //darkest color
        backgroundColor: Color(0xff0b151f),
        appBar: AppBar(
          title: Text(
            'MovieHunt',
            style: TextStyle(color: Colors.cyan),
          ),
          // second darkest color
          backgroundColor: Color(0xff121b28),
          centerTitle: true,
        ),
        body: Home(),
      ),
    );
  }
}
