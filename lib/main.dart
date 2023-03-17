import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leave_management/Ui/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'Utils/Provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider()),
  ], child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntoPage()
    );
  }
}
