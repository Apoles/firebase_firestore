import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appasdddddddddd/bookView/book_view.dart';
import 'package:flutter_appasdddddddddd/screen/Sıgn_In.dart';


class OnBoardSetState extends StatefulWidget {
  @override
  _OnBoardSetStateState createState() => _OnBoardSetStateState();
}

class _OnBoardSetStateState extends State<OnBoardSetState> {
  bool _isLogged;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('signout');
        _isLogged = false;
      } else {
        print('sign in');
        _isLogged = true;
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLogged == null
        ? Center(child: CircularProgressIndicator())
        : _isLogged
            ? HomePage()
            : SignIn();
  }
}
