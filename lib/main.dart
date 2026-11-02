import 'package:flutter/material.dart';

void main() => runApp(const AuthApp());

const Color kPrimary = Color(0xFF0A47B3);
const Color kBackground = Color(0xFFEEF1F6);
const Color kHint = Color(0xFF9AA3B2);

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
        scaffoldBackgroundColor: kBackground,
      ),
      home: const LoginPage(),
    );
  }
}

/// ---------------------------------------------------------------- LOGIN
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue header with logo
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: const SafeArea(child: Center(child: _Logo())),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _FieldLabel('Email'),
                    AuthField(
                      controller: _email,
                      hint: 'email@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Enter your email';
                        }
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _FieldLabel('Password'),
                    AuthField(
                      controller: _password,
                      hint: '••••••••',
                      obscure: _obscure,
                      suffix: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: kHint,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      validator: (v) => (v == null || v.length < 6)
                          ? 'Minimum 6 characters'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(label: 'Login', onPressed: _submit),
                    const SizedBox(height: 20),
                    const _OrDivider(),
                    const SizedBox(height: 20),
                    const _SocialRow(),
                    const SizedBox(height: 24),
                    Center(
                      child: _SwitchText(
                        question: "Don't Have Any Account? ",
                        action: 'Sign Up',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpPage()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------------------------------------------------------- SIGN UP
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue header with back arrow + title
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 28),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.lightBlueAccent),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // balances the back button
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabel('First name'),
                    AuthField(
                      controller: _first,
                      hint: 'John',
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Enter your first name'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel('Last name'),
                    AuthField(
                      controller: _last,
                      hint: 'Doe',
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Enter your last name'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel('Email'),
                    AuthField(
                      controller: _email,
                      hint: 'login@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Enter your email';
                        }
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel('Password'),
                    AuthField(
                      controller: _password,
                      hint: '••••••••',
                      obscure: _obscure,
                      suffix: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: kHint,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      validator: (v) => (v == null || v.length < 6)
                          ? 'Minimum 6 characters'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel('Confirm Password'),
                    AuthField(
                      controller: _confirm,
                      hint: '••••••••',
                      obscure: _obscure,
                      validator: (v) =>
                      v != _password.text ? 'Passwords do not match' : null,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(label: 'Sign Up', onPressed: _submit),
                    const SizedBox(height: 20),
                    const _OrDivider(),
                    const SizedBox(height: 20),
                    const _SocialRow(),
                    const SizedBox(height: 24),
                    Center(
                      child: _SwitchText(
                        question: 'Have An Account? ',
                        action: 'Login.',
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------- SHARED WIDGETS
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Container(
          width: 22,
          height: 28,
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    ),
  );
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AuthField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kHint, fontSize: 13),
        suffixIcon: suffix,
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E5EC))),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE1E5EC))),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimary, width: 1.5)),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const PrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFD5DAE3))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Or', style: TextStyle(fontSize: 12, color: kHint)),
        ),
        Expanded(child: Divider(color: Color(0xFFD5DAE3))),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
            child: Text('G',
                style: TextStyle(
                    color: Color(0xFFDB4437),
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        SizedBox(width: 16),
        _SocialButton(
            child: Icon(Icons.flutter_dash,
                color: Color(0xFF1DA1F2), size: 22)), // Twitter placeholder
        SizedBox(width: 16),
        _SocialButton(
            child: Icon(Icons.facebook, color: Color(0xFF1877F2), size: 24)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget child;
  const _SocialButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF0FB),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _SwitchText extends StatelessWidget {
  final String question;
  final String action;
  final VoidCallback onTap;
  const _SwitchText(
      {required this.question, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: question,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          children: [
            TextSpan(
              text: action,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}