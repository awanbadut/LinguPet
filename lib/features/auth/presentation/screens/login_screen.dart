// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/core/services/auth_service.dart';
import 'auth_widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl    = TextEditingController();
  final _passCtrl     = TextEditingController();
  bool  _obscurePass  = true;
  bool  _isLoading    = false;
  String? _errorMsg;

  void _login() async {
    setState(() { _isLoading = true; _errorMsg = null; });
    await Future.delayed(const Duration(milliseconds: 700));
    final error = AuthService.login(_emailCtrl.text.trim(), _passCtrl.text);
    setState(() => _isLoading = false);
    if (error != null) {
      setState(() => _errorMsg = error);
    } else {
      if (mounted) context.go('/select-language');
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EEF8),
      body: SafeArea(
        child: Stack(
          children: [

            // Dekorasi globe kiri bawah
            Positioned(
              left: 12, bottom: 60,
              child: Icon(Icons.language_rounded,
                  size: 32, color: const Color(0xFF38D1F5).withOpacity(0.5)),
            ),

            // Dekorasi karakter Jepang kanan atas
            Positioned(
              right: 16, top: 120,
              child: Text('あ',
                  style: TextStyle(
                      fontSize: 28,
                      color: const Color(0xFF38D1F5).withOpacity(0.35),
                      fontWeight: FontWeight.bold)),
            ),

            // Dekorasi omega kanan bawah
            Positioned(
              right: 20, bottom: 40,
              child: Text('Ω',
                  style: TextStyle(
                      fontSize: 26,
                      color: const Color(0xFF38D1F5).withOpacity(0.3))),
            ),

            // Dekorasi bintang kanan atas
            Positioned(
              right: 20, top: 60,
              child: Icon(Icons.star_border_rounded,
                  size: 26, color: const Color(0xFF38D1F5).withOpacity(0.5)),
            ),

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── TOP BAR ──
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/onboarding'),
                          child: Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded,
                                size: 18, color: Color(0xFF1A1A2E)),
                          ),
                        ),
                        const Expanded(
                          child: Text('Log in',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E))),
                        ),
                        const SizedBox(width: 38),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── MASCOT ──
                    Center(
                      child: Image.asset(
                        AppAssets.welcome,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── JUDUL ──
                    const Text('Halo, Friend!',
                    textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A2E),
                            letterSpacing: -0.5)),

                    const SizedBox(height: 6),
                    const Text("Let's help keep regional languages alive!",
                    textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF6B8499))),

                    const SizedBox(height: 28),

                    // ── EMAIL FIELD ──
                    const FieldLabel(text: 'Email'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _emailCtrl,
                      hint: 'name@email.com',
                      icon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

                    // ── PASSWORD FIELD ──
                    const FieldLabel(text: 'Password'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _passCtrl,
                      hint: '••••••••',
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscurePass,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() => _obscurePass = !_obscurePass),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            _obscurePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFFB0BEC5), size: 20),
                        ),
                      ),
                    ),

                    // ── FORGET PASSWORD ──
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('Forget Password?',
                            style: TextStyle(
                                color: Color(0xFFF5A623),
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ),
                    ),

                    // ── ERROR ──
                    if (_errorMsg != null) ...[
                      ErrorBox(message: _errorMsg!),
                      const SizedBox(height: 12),
                    ],

                    const SizedBox(height: 4),

                    // ── BUTTON LOGIN ──
                    OrangeButton(
                      label: 'Log In',
                      isLoading: _isLoading,
                      onPressed: _login,
                    ),

                    const SizedBox(height: 22),

                    // ── REGISTER LINK ──
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "I don't have an account? ",
                          style: const TextStyle(
                              color: Color(0xFF6B8499), fontSize: 13),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => context.go('/register'),
                                child: const Text('Register',
                                    style: TextStyle(
                                        color: Color(0xFFF5A623),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
