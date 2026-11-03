import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../widgets/auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      _showError('Email dan kata sandi wajib diisi');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await AuthService.login(email, password);
      Get.offAllNamed(AppRoutes.home);
    } on ApiException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.orientationOf(context) == Orientation.landscape) {
      return Scaffold(body: _buildLandscape());
    }
    return Scaffold(body: _buildPortrait());
  }

  // Portrait: header navy di atas, form di bawahnya, ajakan daftar di dasar layar
  Widget _buildPortrait() {
    return Container(
      color: const Color(0xFF1E1A4D),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF1E1A4D),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: _buildHeaderContent(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFAF8F3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: _buildScrollFill(
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                    child: Column(
                      children: [
                        _buildForm(),
                        const Spacer(),
                        _buildPrompt(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Landscape: dua kolom, panel navy di kiri dan isi di kanan
  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: const Color(0xFF1E1A4D),
            child: SafeArea(
              right: false,
              child: _buildScrollFill(
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Spacer(),
                      _buildHeaderContent(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFFAF8F3),
            child: SafeArea(
              left: false,
              child: _buildScrollFill(
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: Column(
                    children: [
                      const Spacer(),
                      _buildForm(),
                      const Spacer(),
                      _buildPrompt(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Area yang bisa digulir (saat keyboard muncul) tapi tetap memenuhi tinggi layar,
  // supaya Spacer di dalamnya bekerja
  Widget _buildScrollFill(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }

  Widget _buildHeaderContent() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset('assets/logo_1024.png'),
            ),
            const SizedBox(width: 8),
            const Text(
              'bukukuy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: MediaQuery.orientationOf(context) == Orientation.landscape
              ? 16
              : 32,
        ),
        Row(
          children: [
            Expanded(
              child: Text.rich(
                const TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: 'Selamat ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'datang',
                      style: TextStyle(
                        color: Color(0xFFFDBA74),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: '\nkembali.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                'Masuk untuk melanjutkan perjalanan membacamu',
                style: TextStyle(color: Color(0xFFC7D2FE), fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        AuthField(
          label: 'EMAIL',
          hint: 'nama@email.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AuthField(
          label: 'KATA SANDI',
          hint: '••••••••',
          controller: _passwordController,
          obscureText: _hidePassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _isSubmitting ? null : _login(),
          suffixIcon: IconButton(
            icon: Icon(
              _hidePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xFF9E9E9E),
              size: 20,
            ),
            onPressed: () => setState(() => _hidePassword = !_hidePassword),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1A4D),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(
                    0xFF1E1A4D,
                  ).withValues(alpha: 0.6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Masuk',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Spacer - Widget - Spacer (tengah horizontal)
  Widget _buildPrompt() {
    return Row(
      children: [
        const Spacer(),
        const Text(
          'Belum punya akun?',
          style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 13),
        ),
        TextButton(
          onPressed: _isSubmitting
              ? null
              : () => Get.toNamed(AppRoutes.register),
          child: const Text(
            'Daftar sekarang',
            style: TextStyle(
              color: Color(0xFFF97316),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
