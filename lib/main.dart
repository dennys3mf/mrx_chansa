import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mrx_chansa/auth_gate.dart';
import 'package:mrx_chansa/home.dart';
import 'package:provider/provider.dart';
import 'models/emotion_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String userId = ''; // Obtén el userId del usuario autenticado
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmotionModel(userId)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Emotions App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(), // Cambia a HomeScreen()
    );
  }
}
