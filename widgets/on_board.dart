import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appasdddddddddd/bookView/book_view.dart';
import 'package:flutter_appasdddddddddd/screen/Sıgn_In.dart';

import 'package:flutter_appasdddddddddd/service/auth.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool _isLogged;

  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder<User>(
      stream: _auth.authStatus(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.active){
          return snapshot.data!=null?HomePage():SignIn();
        }
        else{
          return SizedBox(
            height: 300,width: 300,child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
