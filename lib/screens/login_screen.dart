import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superheromood/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'SuperHero Moods',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24.0),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        if (email.trim().isEmpty || password.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Email dan password tidak boleh kosong')),
                          );
                          return;
                        }
                        
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          // Coba login terlebih dahulu
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (mounted) {
                            Navigator.pushReplacementNamed(
                                context, MainScreen.id);
                          }
                        } on FirebaseAuthException catch (e) {
                          // Jika user tidak ditemukan, coba register otomatis
                          if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if (mounted) {
                                Navigator.pushReplacementNamed(
                                    context, MainScreen.id);
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text('Login / Register'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
