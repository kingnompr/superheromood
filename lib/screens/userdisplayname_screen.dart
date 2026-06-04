import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserDisplayNameScreen extends StatefulWidget {
  static const String id = 'userdisplayname_screen';
  const UserDisplayNameScreen({super.key});

  @override
  State<UserDisplayNameScreen> createState() => _UserDisplayNameScreenState();
}

class _UserDisplayNameScreenState extends State<UserDisplayNameScreen> {
  String? _setDisplayName;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Nonaktifkan tombol back sistem android (clue no. 8)
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Display Name'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Masukkan nama tampilan Anda',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              // TextField untuk input nama (clue no. 9)
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  hintText: 'Masukkan nama Anda...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) {
                  _setDisplayName = value;
                },
              ),
              const SizedBox(height: 24.0),
              // Row berisi tombol Back dan Submit (sesuai widget tree modul)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tombol Back
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                  // Tombol Submit (clue no. 10)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      try {
                        // Simpan display name ke state lokal
                        // (versi tanpa Firebase Auth - sesuai scope modul Fase 3)
                        if (_setDisplayName != null &&
                            _setDisplayName!.isNotEmpty) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await user.updateProfile(displayName: _setDisplayName);
                          }
                          if (mounted) {
                            Navigator.pop(context, _setDisplayName);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Nama tidak boleh kosong!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
