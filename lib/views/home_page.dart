import 'package:firebase/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            Provider.of<Auth>(context, listen: false).SignOut();

          }, icon:Icon(Icons.logout))
        ],
      ),
      body: Center(child: Column(children: [Text('home page')],),),
    );
  }
}
