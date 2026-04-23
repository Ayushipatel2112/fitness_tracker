import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../globals.dart' as globals;
import '../services/auth_service.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Hey there,',
                  style: TextStyle(fontSize: 16, color: AppColors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter email';
                    if (!value.contains('@')) return 'Enter valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: !_isPasswordVisible,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.gray1,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter password';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => const ForgotPasswordScreen()));
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: AppColors.gray2,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 150), // Spacing to match Figma
                CustomButton(
                  text: 'Login',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      // ── Step 1: Determine user role ──────────────────
                      // In a real app, the API response tells you the role.
                      // Here we use a simple check for demo:
                      // If email contains 'admin' → admin role, else → user role
                      String role = 'user';
                      if (_emailController.text.toLowerCase().contains('admin')) {
                        role = 'admin';
                      }

                      // ── Step 2: Set global variables ─────────────────
                      String prefix = _emailController.text.split('@')[0];
                      globals.currentUserFirstName = prefix[0].toUpperCase() + prefix.substring(1);
                      globals.currentUserName      = globals.currentUserFirstName;
                      globals.currentUserEmail     = _emailController.text;
                      globals.currentUserRole      = role;

                      // ── Step 3: Save session to local storage ─────────
                      await AuthService.login(
                        name: globals.currentUserName,
                        email: _emailController.text,
                        role: role,
                      );

                      // ── Step 4: Navigate based on role ────────────────
                      if (mounted) {
                        if (globals.isAdmin) {
                          // Admin → go to admin dashboard
                          Navigator.pushNamedAndRemoveUntil(
                            context, '/admin_dashboard', (route) => false,
                          );
                        } else {
                          // Regular user → go to main dashboard
                          Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false,
                          );
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.gray3)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or', style: TextStyle(color: AppColors.black)),
                    ),
                    const Expanded(child: Divider(color: AppColors.gray3)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton('assets/images/google.png', () {}),
                    const SizedBox(width: 20),
                    _socialButton('assets/images/facebook.png', () {}),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account yet? ', style: TextStyle(color: AppColors.black)),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/register'),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String iconPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          iconPath,
          height: 20,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.star, size: 20),
        ),
      ),
    );
  }
}
