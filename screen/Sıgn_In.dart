import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appasdddddddddd/screen/email_sign_in.dart';
import 'package:flutter_appasdddddddddd/service/auth.dart';
import 'package:flutter_appasdddddddddd/widgets/my_raised_button.dart';

import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    final user =
        await Provider.of<Auth>(context, listen: false).signInAnonymosly();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    final user =
        await Provider.of<Auth>(context, listen: false).signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle signInTextStyle = TextStyle(
        fontSize: 30, color: Colors.blue, fontFamily: 'Ranchers');

    return Scaffold(
      appBar: AppBar(title: Text("Welcome ChatDate",style: signInTextStyle,),centerTitle: true,backgroundColor: Colors.white,),
      body: Container(
        height: size.height,
        width: size.width,

        child: ListView(

          children: [
            SizedBox(height: 50,),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [

                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(color: Colors.blue,fontSize: 25),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    MyRaisedButton(
                        color: Colors.white70,
                        child: Text('Sıgn In Anonymusly',style: TextStyle()),
                        onPressed: _isLoading ? null : _signInAnonymously),
                    SizedBox(
                      height: 20,
                    ),
                    MyRaisedButton(
                      color: Colors.white70,
                      child: Text('Sıgn In Email',style: TextStyle()),
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EmailSignInPage()));
                            },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyRaisedButton(
                      color: Colors.white70,
                      child: Text('Sıgn In Google',style: TextStyle()),
                      onPressed: _isLoading ? null : _signInWithGoogle,
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
