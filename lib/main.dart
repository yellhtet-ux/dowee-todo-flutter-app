import 'package:dowee_app/model/task.dart';
import 'package:dowee_app/pages/dowee_home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<Task> dooWeeBox;

const String taskBoxName = "doo-wee-box";

void main() async {
  //! Initialize Hive
  await Hive.initFlutter();

  //! Open the box
  Hive.registerAdapter<Task>(TaskAdapter());

  dooWeeBox = await Hive.openBox<Task>(taskBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dowee",
      home: DoweeHomePage(),
    );
  }
}
