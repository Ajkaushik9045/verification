import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:verification/components/Navigation/Router.dart';
import 'package:verification/pages/language_selector.dart';


void main() async {
  //Here , I  initialized the Firebase
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyCBOTKtCOdBCoxRKmHd3jJVZGUbaNNrWRE",
            appId: "1:107772954233:android:938623f2221db7a3d936a8",
            messagingSenderId: "107772954233",
            projectId: "verification-68e77",
          ),
        )
      : await Firebase.initializeApp();

// This is used to Run my App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: LanguageSelector(),
    );
  }
}
