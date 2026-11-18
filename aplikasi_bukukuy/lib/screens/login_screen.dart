import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../theme/app_colors.dart';
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
        SnackBar(content: Text(message), backgroundColor: AppColors.red),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.orientationOf(context) == Orientation.landscape
          ? _buildLandscape()
          : _buildPortrait(),
    );
  }

  Widget _buildPortrait() {
    return Container(
      color: AppColors.navy,
      child: Column(
        children: [
          Container(
            color: AppColors.navy,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: _buildHeader(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: _buildScrollFill(
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                    child: Column(
                      children: [_buildForm(), const Spacer(), _buildPrompt()],
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

  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: AppColors.navy,
            child: SafeArea(
              right: false,
              child: _buildScrollFill(
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [const Spacer(), _buildHeader(), const Spacer()],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.background,
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

  Widget _buildHeader() {
    return Column(
      children: [
        _buildLogo(),
        SizedBox(
          height: MediaQuery.orientationOf(context) == Orientation.landscape
              ? 16
              : 32,
        ),
        const Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: 'Selamat ',
                      style: TextStyle(color: AppColors.white),
                    ),
                    TextSpan(
                      text: 'datang',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: '\nkembali.',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Row(
          children: [
            Expanded(
              child: Text(
                'Masuk untuk melanjutkan perjalanan membacamu',
                style: TextStyle(color: AppColors.blueFaded, fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/logo_1024.png'),
        ),
        const SizedBox(width: 8),
        const Text(
          'jejak baca',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildPrompt() {
    return Row(
      children: [
        const Spacer(),
        const Text(
          'Belum punya akun?',
          style: TextStyle(color: AppColors.grey, fontSize: 13),
        ),
        TextButton(
          onPressed: _isSubmitting
              ? null
              : () => Get.toNamed(AppRoutes.register),
          child: const Text(
            'Daftar sekarang',
            style: TextStyle(
              color: AppColors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildSubmitButton(String label, VoidCallback onPressed) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.navy,
              foregroundColor: AppColors.white,
              disabledBackgroundColor: AppColors.navy.withValues(alpha: 0.6),
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
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
          ),
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
              color: AppColors.grey,
              size: 20,
            ),
            onPressed: () => setState(() => _hidePassword = !_hidePassword),
          ),
        ),
        const SizedBox(height: 24),
        _buildSubmitButton('Masuk', _login),
      ],
    );
  }
}
