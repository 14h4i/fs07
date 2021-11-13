import 'package:flutter/material.dart';
import 'package:fs07/modules/authentication/pages/login_page.dart';
import 'package:fs07/modules/firebase/widgets/firebase_initializer.dart';

void main() {
  runApp(
    const FirebaseInitializer(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FS 07',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (context) => const LoginPage(),
      },
    );
  }
}
