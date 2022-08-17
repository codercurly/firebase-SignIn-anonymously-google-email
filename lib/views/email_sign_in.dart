import 'package:firebase/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
enum FormStatus {signIn, register, reset}

class EmailSignPage extends StatefulWidget {
  const EmailSignPage({Key? key}) : super(key: key);

  @override
  State<EmailSignPage> createState() => _EmailSignPageState();
}


class _EmailSignPageState extends State<EmailSignPage> {

  FormStatus _formStatus = FormStatus.signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _formStatus == FormStatus.signIn
            ? buildSignForm()
            : _formStatus == FormStatus.register
            ? buildRegisterForm()
            : buildResetForm(),
      ),
    );
  }

  Widget buildSignForm() {
    TextEditingController _Controllerpass =TextEditingController();
    TextEditingController _Controllermail =TextEditingController();
    final _signinformkey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _signinformkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Giriş yapınız', style: TextStyle(fontSize: 25)),
              SizedBox(height:20),
              TextFormField(
                controller: _Controllermail,
                validator: (val) {
                  if(EmailValidator.validate(val!)){
                    return null;
                  }
                  else{
                    return 'geçersiz e-posta adresi';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText:'E-mail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))

                ),

              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _Controllerpass,
                validator: (val){
                  if(val!.length<7){
                    return 'en az 6 karakter!';
                  }
                  else{
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText:'şifre',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))

                ),

              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () async{
                if(_signinformkey.currentState!.validate()){
                  final user = await Provider.of<Auth>(context, listen: false).SignInEmailpass(_Controllermail.text, _Controllerpass.text);
                  if(!user!.emailVerified){
                   await _showMyDialog();
                   await Provider.of<Auth>(context, listen: false).SignOut();
                  }
                    Navigator.pop(context);
                };
              }, child: Text('giriş yap')),
              SizedBox(height: 10),
              TextButton(onPressed: (){
                setState(() {
                  _formStatus=FormStatus.register;
                });
              }, child: Text('üye değilseniz buradan kayıt olunuz')),
              TextButton(onPressed: (){
                setState(() {
                  _formStatus=FormStatus.reset;
                });
              }, child: Text('Şifremi unuttum'))
            ],
          ),
        ),
    );
  }

  Widget buildResetForm() {

    TextEditingController _Controllermail =TextEditingController();
    final _resetformkey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _resetformkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Şifre yenileme', style: TextStyle(fontSize: 25)),
            SizedBox(height:20),
            TextFormField(
              controller: _Controllermail,
              validator: (val) {
                if(EmailValidator.validate(val!)){
                  return null;
                }
                else{
                  return 'geçersiz e-posta adresi';
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText:'E-mail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))

              ),

            ),
            SizedBox(height: 20),

            ElevatedButton(onPressed: () async{
              if(_resetformkey.currentState!.validate()){

              await Provider.of<Auth>(context, listen: false).PassReset(_Controllermail.text);
               await _showResetpassDialog();

                Navigator.pop(context);
              };
            }, child: Text('gönder')),

          ],
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    TextEditingController _Controllerpass =TextEditingController();
    TextEditingController _Controllermail =TextEditingController();
    final _registerformkey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _registerformkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('kayıt ol', style: TextStyle(fontSize: 25),),
            SizedBox(height: 3),
            TextFormField(
              controller: _Controllermail,
              validator: (val) {
                if(EmailValidator.validate(val!)){
                  return null;
                }
                else{
                  return 'geçersiz e-posta adresi';
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText:'E-mail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))

              ),
            ),
            SizedBox(height: 3),
            TextFormField(

              validator: (val){
                if(val!.length<7){
                  return 'en az 6 karakter!';
                }
                else{
                  return null;
                }
              },
              controller: _Controllerpass,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText:'şifre',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))

              ),),
            SizedBox(height: 3),
            TextFormField(
              validator: (val){
                if(val!=_Controllerpass.text){
                  return 'şifre bir önceki şifre ile aynı değil';
                }
                else {
                  return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText:'şifre tekrar',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))

              ),),
            SizedBox(height: 3),
            ElevatedButton(onPressed: () async{
              if(_registerformkey.currentState!.validate()){
                final user = await  Provider.of<Auth>(context, listen: false).CreateUser(_Controllermail.text, _Controllerpass.text);
                print(user?.emailVerified);
                if(!user!.emailVerified){
                  await user.sendEmailVerification();
                }
               await _showMyDialog();
                await Provider.of<Auth>(context, listen: false).SignOut();
                  setState(() {
                    _formStatus =FormStatus.signIn;
                  });

              }
            }, child: Text('kayıt')),
        SizedBox(height: 3),
        TextButton(onPressed: (){
          setState(() {
            _formStatus=FormStatus.signIn;
          });
        }, child: Text('zaten üye misiniz? giriş yapınız'))
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('e-posta adresinizi kontrol edin'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('E-postanızı onaylamanız gerekiyor'),
                Text('mailinize bir onay maili gönderdik'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetpassDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('e-posta adresinize şifre yenileme bağlantısı gönderdik'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('mailinize gelen bağlantı ile şifrenizi yenileyebilirsiniz'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
