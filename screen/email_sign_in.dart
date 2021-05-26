import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appasdddddddddd/service/auth.dart';
import 'package:flutter_appasdddddddddd/widgets/denemefalan.dart';
import 'package:provider/provider.dart';


enum FormStatus { signIn, register, reset }

class EmailSignInPage extends StatefulWidget {
  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  FormStatus _formStatus = FormStatus.signIn;




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(
          child: _formStatus == FormStatus.signIn
              ? buildSignInForm()
              : _formStatus == FormStatus.register
                  ? buildRegisterForm()
                  : resetPasswordForm()),
    );
  }

  Widget buildSignInForm() {
    TextStyle signInTextStyle = TextStyle(
        fontSize: 30, color: Colors.blue, fontFamily: 'Ranchers');
    final _signInFormKey = GlobalKey<FormState>();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ChatDate ',style: signInTextStyle,),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return 'Lütfen geçerli bi adres giriniz';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _password,
              validator: (value) {
                if (value.length < 6) {
                  return 'En az 6 karakter giriniz';
                } else {
                  return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 320,
              child: ElevatedButton(
                onPressed: () async {
                  try{
                    if (_signInFormKey.currentState.validate()) {
                      final user = await Provider.of<Auth>(context,
                              listen: false)
                          .signInWithEmailPassword(_email.text, _password.text);

                      if (!user.emailVerified) {
                        await _showMyDialog();
                        await Provider.of<Auth>(context, listen: false)
                            .signOut();
                      }
                     await Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, _) {
                            return SecondScreen();
                          },
                          opaque: false));
                      Navigator.pop(context);
                    }
                  } on FirebaseAuthException catch(e){
                    print('buildsign inde hata');
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            TextButton(

                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.register;
                  });
                },
                child: Text('Dont have an account? Sign Up')),
            TextButton(
                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.reset;
                  });
                },
                child: Text('Forgot your password?'),),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterForm() {

    TextStyle signInTextStyle = TextStyle(
        fontSize: 30, color: Colors.blue, fontFamily: 'Ranchers');
    final _registerFormKey = GlobalKey<FormState>();
    TextEditingController _password = TextEditingController();
    TextEditingController _email = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _registerFormKey,
        child: ListView(
padding: EdgeInsets.fromLTRB(0, 130, 0,0),
          children: [
            Center(child: Text('Register Form',style: signInTextStyle,)),
            SizedBox(height: 25,),
            TextFormField(
              controller: _email,
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return 'Geçerli email giriniz';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (value) {
                if (value.toString() == _password.text) {
                  return null;
                } else {
                  return 'şifreler aaynı olmalı ';
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password again',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 320,
              child: ElevatedButton(


                onPressed: () async {
                  try {
                    if (_registerFormKey.currentState.validate()) {
                      final user =
                          await Provider.of<Auth>(context, listen: false)
                              .createUserWithEmailPassword(
                                  _email.text, _password.text);
                      if (!user.emailVerified) {
                        await user.sendEmailVerification();
                      }
                      await _showMyDialog();
                      await Provider.of<Auth>(context, listen: false).signOut();
                      setState(() {
                        _formStatus = FormStatus.signIn;
                      });
                    }
                  } on FirebaseAuthException catch(e){
                    print('kayıt hatası');
                  }

                },
                child: Text('Sign up',style: TextStyle(fontSize: 25),),
              ),
            ),

            TextButton(
                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.signIn;
                  });
                },
                child: Text('Already have an account?'))
          ],
        ),
      ),
    );
  }

  Widget resetPasswordForm() {
    final _resetFormKey = GlobalKey<FormState>();

    TextEditingController _email = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _resetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Şifre yenileme',style: TextStyle(fontSize: 25),),
            SizedBox(height:25,),
            TextFormField(
              controller: _email,
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return 'Geçerli email giriniz';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height:25,),
            ElevatedButton(
              onPressed: () async {

               await Provider.of<Auth>(context,listen: false).sendResetPassword(_email.text);
                   await _showResetDialog();
              },
              child: Text(
                'Gönder',
                style: TextStyle(fontSize: 25),
              ),
            ),
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
          title: Text('Onay gerekiyor'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hello please check your email .'),
                Text(' Click on the link and login'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showResetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uyarı!!!!1'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hello please check your email .'),
                Text('Reset your password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
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
