// lib/features/auth/presentation/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/core/services/auth_service.dart';
import 'auth_widgets.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _passCtrl     = TextEditingController();
  bool  _obscurePass  = true;
  bool  _isLoading    = false;
  String? _errorMsg;

  void _register() async {
    setState(() { _isLoading = true; _errorMsg = null; });
    await Future.delayed(const Duration(milliseconds: 700));
    final error = AuthService.register(
      _usernameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _passCtrl.text,
    );
    setState(() => _isLoading = false);
    if (error != null) {
      setState(() => _errorMsg = error);
    } else {
      if (mounted) context.go('/select-language');
    }
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
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
                  size: 32,
                  color: const Color(0xFF38D1F5).withOpacity(0.5)),
            ),

            // Dekorasi karakter Jepang kanan
            Positioned(
              right: 16, top: 180,
              child: Text('あ',
                  style: TextStyle(
                      fontSize: 28,
                      color: const Color(0xFF38D1F5).withOpacity(0.35),
                      fontWeight: FontWeight.bold)),
            ),

            // Dekorasi bintang kanan atas
            Positioned(
              right: 20, top: 60,
              child: Icon(Icons.star_border_rounded,
                  size: 26,
                  color: const Color(0xFF38D1F5).withOpacity(0.5)),
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
                          onTap: () => context.go('/login'),
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
                          child: Text('register',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E))),
                        ),
                        const SizedBox(width: 38),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ── MASCOT ──
                    Center(
                      child: Image.asset(
                        AppAssets.welcome,
                        height: 165,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── JUDUL ──
                    const Text('Start Your Adventure!',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A2E),
                            letterSpacing: -0.5)),
                    const SizedBox(height: 6),
                    const Text('Help protect regional languages with Wiraga.',
                        style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF6B8499))),

                    const SizedBox(height: 22),

                    // ── USERNAME ──
                    const FieldLabel(text: 'Username'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _usernameCtrl,
                      hint: 'username',
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 16),

                    // ── EMAIL ──
                    const FieldLabel(text: 'Email'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _emailCtrl,
                      hint: 'name@email.com',
                      icon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    // ── PASSWORD ──
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

                    // ── ERROR ──
                    if (_errorMsg != null) ...[
                      const SizedBox(height: 12),
                      ErrorBox(message: _errorMsg!),
                    ],

                    const SizedBox(height: 24),

                    // ── BUTTON REGISTER ──
                    OrangeButton(
                      label: 'Register',
                      isLoading: _isLoading,
                      onPressed: _register,
                    ),

                    const SizedBox(height: 22),

                    // ── LOGIN LINK ──
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                              color: Color(0xFF6B8499), fontSize: 13),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => context.go('/login'),
                                child: const Text('Log In',
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
