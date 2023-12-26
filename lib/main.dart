import 'package:c_app/screen/devloper.dart';
import 'package:c_app/screen/home_screen.dart';
import 'package:c_app/screen/registrationui/regScreen.dart';
import 'package:c_app/screen/setting-screen.dart';
import 'package:c_app/state/all_problems.dart';
import 'package:c_app/state/cart_model.dart';
import 'package:c_app/state/firestore_item_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'service/firebase_auth_methods.dart';
import 'screen/loginui/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => AllProblems()),
        ChangeNotifierProvider(create: (context) => MyItemList()),
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C-Learner App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'comic',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      // initialRoute: LoginScreen.id,
      routes: {
        regScreen.id:(context) => regScreen(),
        loginScreen.id: (context) =>loginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        Devloper.id:(context) => Devloper(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    print('USER ${firebaseUser?.email}');

    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return loginScreen();
  }
}
