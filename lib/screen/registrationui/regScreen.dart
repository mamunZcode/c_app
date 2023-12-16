import 'package:flutter/material.dart';
import 'reg1.dart';
import 'reg2.dart';
import 'reg3.dart';


class regScreen extends StatefulWidget {
  static const id = 'regScreen';
  @override
  State<regScreen> createState() => _regScreenState();
}
class _regScreenState extends State<regScreen> {
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
                    'Register To APP',
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
            Positioned(top: 290, right: 0, bottom: 0, child: reg1()),
            Positioned(top: 318, right: 0, bottom: 28, child: reg2()),
            Positioned(top: 320, right: 0, bottom: 48, child: reg3()),
          ],
        ),
      ),
    );
  }

}