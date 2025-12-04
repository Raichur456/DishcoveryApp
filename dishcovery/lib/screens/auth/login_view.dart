import 'package:flutter/material.dart';
import '../../services/firebase_auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  final authService = FirebaseAuthService();

 @override
  void initState() {
    super.initState();

    // If user already signed in from before, skip login screen
    final user = authService.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }
  Future<void> _login() async {
final form = _formKey.currentState;
if (form == null || !form.validate()) return;

    setState(() => _loading = true);
    try {
      await authService.signIn(_email.text.trim(), _password.text.trim());
      if (mounted) Navigator.pushReplacementNamed(context, '/profile');
    } on Exception catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    v!.isEmpty ? 'Enter your email' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (v) =>
                    v!.length < 6 ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 15),
              if (_error != null)
                Text(_error!,
                    style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Sign In'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text('Create account'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
