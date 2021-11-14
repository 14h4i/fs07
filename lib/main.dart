import 'package:flutter/material.dart';
import 'package:fs07/app.dart';
import 'package:fs07/modules/firebase/widgets/firebase_initializer.dart';

void main() {
  runApp(
    const FirebaseInitializer(
      child: MyApp(),
    ),
  );
}
