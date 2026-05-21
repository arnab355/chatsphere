import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatsphere/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Connects the web runtime environment straight to your live database cloud
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDHZ_rj0wQ7aCRWaEe_cUkuthzOeor6UBE",
      authDomain: "chatsphere-ef4a5.firebaseapp.com",
      projectId: "chatsphere-ef4a5",
      storageBucket: "chatsphere-ef4a5.firebasestorage.app",
      messagingSenderId: "946323208000",
      appId: "1:946323208000:web:30bd9199a3a3b635a9eca5",
      measurementId: "G-58VTZFF8KJ",
    ),
  );

  runApp(const ChatSphereApp());
}

class ChatSphereApp extends StatelessWidget {
  const ChatSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatSphere',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121214),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
