import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../globals.dart' as globals;
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _acceptTerms = false;

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
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: 'First Name',
                  prefixIcon: Icons.person_outline,
                  controller: _firstNameController,
                  validator: (value) => value!.isEmpty ? 'Enter first name' : null,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Last Name',
                  prefixIcon: Icons.person_outline,
                  controller: _lastNameController,
                  validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                ),
                const SizedBox(height: 15),
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
                    if (value.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'By continuing you accept our Privacy Policy and Term of Use',
                        style: TextStyle(fontSize: 10, color: AppColors.gray2),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Register',
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _acceptTerms) {

                      // ── Step 1: Set global user info ──────────────────
                      globals.currentUserName      = '${_firstNameController.text} ${_lastNameController.text}';
                      globals.currentUserFirstName = _firstNameController.text;
                      globals.currentUserLastName  = _lastNameController.text;
                      globals.currentUserEmail     = _emailController.text;
                      globals.currentUserRole      = 'user'; // new users are always 'user'

                      // ── Step 2: Save session to local storage ─────────
                      await AuthService.login(
                        name: globals.currentUserName,
                        email: _emailController.text,
                        role: 'user',
                      );

                      // ── Step 3: Go to next onboarding screen ──────────
                      if (mounted) {
                        Navigator.pushNamed(context, '/gender_selection');
                      }
                    } else if (!_acceptTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please accept terms and conditions')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.gray3)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or', style: TextStyle(color: AppColors.black)),
                    ),
                    Expanded(child: Divider(color: AppColors.gray3)),
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
                    const Text('Already have an account? ', style: TextStyle(color: AppColors.black)),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: const Text(
                        'Login',
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
