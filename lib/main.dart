import 'package:c_app/screen/home_screen.dart';
import 'package:c_app/screen/login_screen.dart';
import 'package:c_app/screen/registration.dart';
import 'package:c_app/screen/setting-screen.dart';
import 'package:c_app/state/all_problems.dart';
import 'package:c_app/state/cart_model.dart';
import 'package:c_app/state/firestore_item_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_demo/screen/setting-screen.dart';
// import 'package:firebase_auth_demo/state/all_problems.dart';
// import 'package:firebase_auth_demo/state/cart_model.dart';
// import 'package:firebase_auth_demo/state/firestore_item_list.dart';
// import 'package:firebase_auth_demo/screen/home_screen.dart';
// import 'package:firebase_auth_demo/screen/login_screen.dart';
// import 'package:firebase_auth_demo/screen/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'service/firebase_auth_methods.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        fontFamily: 'comic',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      // initialRoute: LoginScreen.id,
      routes: {
        Registration.id: (context) => Registration(),
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SettingScreen.id: (context) => SettingScreen(),
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
    return LoginScreen();
  }
}
