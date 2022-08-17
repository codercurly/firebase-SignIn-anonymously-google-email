import 'package:firebase/services/auth.dart';
import 'package:firebase/views/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/home_page.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({Key? key}) : super(key: key);

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  @override
  Widget build(BuildContext context) {

   // bool? _isLogged = true;
    final _auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder<User?>(
        stream: _auth.authStatus(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.connectionState==ConnectionState.active){
          return  snapshot.data!=null?HomePage():SignInPage();

          }
          else{
            return SizedBox(height:300, width: 300, child: CircularProgressIndicator(),);
          }

        });
  }
}
