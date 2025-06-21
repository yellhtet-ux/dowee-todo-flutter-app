import 'package:dowee_app/pages/dowee_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dowee",
      home: Scaffold(
        body: DoweeHomePage(),
        appBar: AppBar(title: Text("Dowee Todo List"), elevation: 0),
      ),
    );
  }
}
