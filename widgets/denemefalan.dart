import 'package:flutter/material.dart';

import 'package:flutter_appasdddddddddd/service/auth.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 2000),
                  builder: (context, value, child) {
                    return ShaderMask(
                        shaderCallback: (rect) {
                          return RadialGradient(
                                  radius: value * 5,
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                    Colors.black54,
                                    Colors.black12
                                  ],
                                  stops: [0.0, 0.5, 0.5, 1.0],
                                  center: FractionalOffset(0.90, 0.95))
                              .createShader(rect);
                        },
                        child: SecondScreenS());
                  }),
            );
          },
        ));
  }
}

class SecondScreenS extends StatefulWidget {
  @override
  _SecondScreenSState createState() => _SecondScreenSState();
}

class _SecondScreenSState extends State<SecondScreenS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AlertDialog(
        title: Text('Hello Friend'),
        content: Text(
            "You need to read and confirm the agreement to use the application."),
        actions: [
          TextButton(
            child: Text('I confirm'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('I do not confirm'),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.pop(context);
            },
          )
        ],
      )),
    );
  }
}
