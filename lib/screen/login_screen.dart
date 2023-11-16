import 'package:c_app/screen/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/firebase_auth_methods.dart';
class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void login() {
    print('login');
    context.read<FirebaseAuthMethods>().loginWithEmail(
        email: emailController.value.text.trim(),
        password: passController.value.text.trim(),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withOpacity(0.3),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png'),
          Text('101 C Problems',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Enter your email',
                icon: Icon(Icons.drive_file_rename_outline_sharp),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter your password',
                icon: Icon(Icons.password_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: login,
              label: Text('Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              icon: Icon(Icons.login),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton.icon(
          //       label: Text('Register',
          //           style:
          //               TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          //       onPressed: () {
          //         Navigator.pushNamed(context, Registration.id);
          //       },
          //       icon: Icon(Icons.app_registration)),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                    'Registration to',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 18.0),
                  )),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Registration.id);
                  },
                  child: Text(
                    'click here',
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ],
      )),
    );
  }
}
