import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The PasswordView class allows the user to change their account password in a safe and secure
// manner
class PasswordView extends StatefulWidget {
  // constructs the password view widget.
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

// The _PasswordViewState class manages the state of the PasswordView
class _PasswordViewState extends State<PasswordView> {
  // key for the password form
  final _formKey = GlobalKey<FormState>();
  // controller for current password field
  final _currentController = TextEditingController();
  // controller for new password field
  final _newController = TextEditingController();
  // controller for confirm password field
  final _confirmController = TextEditingController();

  // true if password update is in progress
  bool _loading = false;
  // error message to display if password update fails
  String? _error;

  @override
  void dispose() {
    // dispose controllers to free resources
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // updates the user's password in Firebase after validating the form
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

      // re-authenticate using the current password
      final cred = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      // update password in Firebase
      await user.updatePassword(newPassword);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );

      // navigates back to the previous screen
      Navigator.pop(context);
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
    // main scaffold for password change screen
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
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
              ],

              // current password
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

              // new password
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

              // confirm new password
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

              // update password button
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
