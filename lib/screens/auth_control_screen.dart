
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'sign_in_screen.dart';

class AuthControlScreen extends StatelessWidget {
  const AuthControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const MainScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
