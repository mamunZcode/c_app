import 'package:flutter/material.dart';
import 'login1.dart';
import 'login2.dart';
import 'login3.dart';


class loginScreen extends StatefulWidget {

  static const id = 'loginScreen';

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/primaryBg.png'),
              fit: BoxFit.cover,
            )),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 200,
                left: 59,
                child: Container(
                  child: Text(
                    'Login To APP',
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
            Positioned(top: 290, right: 0, bottom: 0, child: login1()),
            Positioned(top: 318, right: 0, bottom: 28, child: login2()),
            Positioned(top: 320, right: 0, bottom: 48, child: login3()),
          ],
        ),
      ),
    );
  }
}