import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/firebase_auth_methods.dart';
import '../state/cart_model.dart';

class Registration extends StatefulWidget {
  static const id = 'registration_screen';

  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void register() {
    print('register');
    context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: emailController.value.text,
        password: passController.value.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: Center(
          child: Consumer<CartModel>(
            builder: (context, cart, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "App Registration",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      controller: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                      controller: passController,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: register,
                    label: const Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.app_registration_outlined),
                  )
                ],
              );
            },
          ),
        ));
  }
}
