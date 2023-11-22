// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       // Trigger Google Sign In
//       final GoogleSignInAccount? googleSignInAccount =
//       await _googleSignIn.signIn();
//
//       // If the user cancels the sign-in process
//       if (googleSignInAccount == null) return null;
//
//       // Obtain GoogleSignInAuthentication and authenticate with Firebase
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       // Sign in to Firebase using Google credentials
//       final UserCredential authResult =
//       await _auth.signInWithCredential(credential);
//       final User? user = authResult.user;
//
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }