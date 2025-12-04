import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final form = _formKey.currentState;
if (form == null || !form.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        setState(() {
          _error = 'You are not signed in.';
        });
        return;
      }

      final email = user.email;
      if (email == null) {
        setState(() {
          _error = 'No email found for this account.';
        });
        return;
      }

      final currentPassword = _currentController.text.trim();
      final newPassword = _newController.text.trim();

      // Re-authenticate using the current password
      final cred = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      //  Update password in Firebase
      await user.updatePassword(newPassword);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );

      Navigator.pop(context); // go back to settings/profile
    } on FirebaseAuthException catch (e) {
      String msg = 'Failed to update password.';
      if (e.code == 'wrong-password') {
        msg = 'Current password is incorrect.';
      } else if (e.code == 'weak-password') {
        msg = 'New password is too weak (min 6 characters).';
      } else if (e.message != null) {
        msg = e.message!;
      }

      setState(() {
        _error = msg;
      });
    } catch (_) {
      setState(() {
        _error = 'Something went wrong. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              if (_error != null) ...[
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
              ],

              TextFormField(
                controller: _currentController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _newController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.length < 6) {
                    return 'New password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _confirmController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) {
                  if (v != _newController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _updatePassword,
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Update Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
