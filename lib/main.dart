import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/addImage.dart';
import 'package:fluttercrud/firebase_options.dart';
import 'package:fluttercrud/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp;
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  MyApp(token: "asdlkfj");
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  final token;
  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      home: const AddImage(),
    );
  }
}
