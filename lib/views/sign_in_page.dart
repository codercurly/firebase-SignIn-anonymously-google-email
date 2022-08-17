import 'package:firebase/services/auth.dart';
import 'package:firebase/views/email_sign_in.dart';
import 'package:firebase/widgets/myraised.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    bool? _isLoading= false;


    Future<void> _signInAnonymously () async{
setState(() {
  _isLoading=false;
});
      final user = Provider.of<Auth>(context, listen: false).SignInAnonymously();
      print(user);
      setState(() {
        _isLoading= true;
      });
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyRaisedButton(
            onPressed: _isLoading! ? null: () async{

                _signInAnonymously();},

                color: Colors.pink.shade200,  child: Text('sign in anonymously',style: TextStyle(fontSize: 25,color: Colors.white),)),

            SizedBox(
              height: 30,
            ),
            SignInButton(
                buttonType: ButtonType.google,
                buttonSize: ButtonSize.large, // small(default), medium, large
                onPressed: () async {
                  final user = await Provider.of<Auth>(context, listen: false).signInWithGoogle();

                  print('click');
                }),
            SizedBox(
              height: 30,
            ),
            MyRaisedButton(
              onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailSignPage()));},
                color: Colors.pink.shade100,  child: Text('sign in email',style: TextStyle(fontSize: 25,color: Colors.black),)
            ),
          ],
        ),
      ),
    );
  }
}
