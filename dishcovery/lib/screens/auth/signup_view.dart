import 'package:flutter/material.dart';
import '../../services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The SignupView class displays a registration form for new users and manages navigation
// on a sucessful signup
class SignupView extends StatefulWidget {
  // Behavior: constructs the signup view widget
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

// The _SignupViewState class manages the state, validation, registration logic, and navigation
// for SignupView
class _SignupViewState extends State<SignupView> {
  // key for validating the signup form
  final _formKey = GlobalKey<FormState>();

  // stores the user's full name input
  final _nameController = TextEditingController();

  // stores the user's email input
  final _emailController = TextEditingController();

  // stores the user's password input
  final _passwordController = TextEditingController();

  // stores the user's password confirmation input
  final _confirmController = TextEditingController();

  // true if a signup attempt is in progress
  bool _loading = false;

  // holds any error message to display to the user
  String? _error;

  // provides Firebase authentication methods
  final _authService = FirebaseAuthService();

  // Behavior: Disposes of all text controllers when the widget is removed from the widget tree
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Behavior: validates the form, registers the user with Firebase, updates the display name, and
  // navigates to profile on success
  Future<void> _register() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();

      // create the users
      User? user = await _authService.register(email, password);

      // saves name to Firebase profile
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
      }

      if (!mounted) return;

      // redirects to HomeView
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } on Exception catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Enter your email';
                    }
                    if (!v.contains('@') || !v.contains('.')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (v) {
                    if (v == null || v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // confirm password
                TextFormField(
                  controller: _confirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  validator: (v) {
                    if (v != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                if (_error != null)
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 20),

                // sign up button
                ElevatedButton(
                  onPressed: _loading ? null : _register,
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Account'),
                ),

                // back to login button
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
