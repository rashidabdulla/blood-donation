
import 'package:blooddonation/blood.dart';
import 'package:blooddonation/detail.dart';
import 'package:blooddonation/update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo App",
      routes: {
        '/':(context) => Blood(),
        '/Details':(context) => Details(),
        '/Update':(context) => UpdateDonor(),
      },
      initialRoute: '/',
    );
  }
}