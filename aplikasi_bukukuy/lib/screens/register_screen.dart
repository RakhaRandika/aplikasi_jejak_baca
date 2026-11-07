import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiController = TextEditingController();
  bool _isSubmitting = false;
  bool _hidePassword = true;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final nama = _namaController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('Semua kolom wajib diisi');
      return;
    }
    if (password.length < 6) {
      _showError('Kata sandi minimal 6 karakter');
      return;
    }
    if (password != _konfirmasiController.text) {
      _showError('Konfirmasi kata sandi tidak sama');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await AuthService.register(nama, email, password);
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

  // Portrait: header navy di atas, form di bawahnya, ajakan di dasar layar
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

  // Landscape: dua kolom, panel navy di kiri dan form di kanan
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

  // Logo + judul besar + keterangan singkat
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
                      text: 'Buat ',
                      style: TextStyle(color: AppColors.white),
                    ),
                    TextSpan(
                      text: 'akun',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: '\nbaru.',
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
                'Simpan buku favorit milikmu sendiri',
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
          'bukukuy',
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

  // Ajakan di dasar layar: Spacer - Widget - Spacer (tengah horizontal)
  Widget _buildPrompt() {
    return Row(
      children: [
        const Spacer(),
        const Text(
          'Sudah punya akun?',
          style: TextStyle(color: AppColors.grey, fontSize: 13),
        ),
        TextButton(
          onPressed: _isSubmitting ? null : () => Get.back(),
          child: const Text(
            'Masuk',
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

  // Tombol selebar form, menampilkan spinner saat proses berjalan
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
          label: 'NAMA',
          hint: 'Nama lengkap',
          controller: _namaController,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 14),
        AuthField(
          label: 'EMAIL',
          hint: 'nama@email.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 14),
        AuthField(
          label: 'KATA SANDI',
          hint: 'Minimal 6 karakter',
          controller: _passwordController,
          obscureText: _hidePassword,
          textInputAction: TextInputAction.next,
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
        const SizedBox(height: 14),
        AuthField(
          label: 'ULANGI KATA SANDI',
          hint: '••••••••',
          controller: _konfirmasiController,
          obscureText: _hidePassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _isSubmitting ? null : _register(),
        ),
        const SizedBox(height: 24),
        _buildSubmitButton('Daftar', _register),
      ],
    );
  }
}
