import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatsphere/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _handleAuth(bool isSignUp) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar("Please fill in all fields");
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (isSignUp) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        _showSnackbar("Account created successfully!");
      } else {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackbar(e.message ?? "Authentication failed");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.forum_rounded,
                size: 80,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 16),
              const Text(
                'ChatSphere',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const Text(
                'Real-time Team Workspace',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                ElevatedButton(
                  onPressed: () => _handleAuth(false),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _handleAuth(true),
                  child: const Text(
                    'Create an Account',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
