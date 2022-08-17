import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/views/sign_in_page.dart';
import 'package:firebase/widgets/onboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create:(context)=>Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: OnBoardWidget(),
      ),
    );

    //const MyHomePage(title: 'Flutter Demo Home Page'),
  }
}

