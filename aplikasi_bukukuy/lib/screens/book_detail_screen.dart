import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/book.dart';
import '../widgets/book_cover.dart';
import '../theme/app_colors.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  final bool isFavorite;
  final Future<bool> Function(Book book) onToggleFavorite;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late bool _isFavorite = widget.isFavorite;
  bool _isSaving = false;

  Future<void> _toggleFavorite() async {
    setState(() => _isSaving = true);
    final berhasil = await widget.onToggleFavorite(widget.book);
    if (!mounted) return;
    setState(() {
      if (berhasil) _isFavorite = !_isFavorite;
      _isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.orientationOf(context) == Orientation.landscape) {
      return Scaffold(body: _buildLandscape());
    }
    return Scaffold(body: _buildPortrait());
  }

  Widget _buildPortrait() {
    return Column(
      children: [
        Container(
          color: AppColors.navy,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
              child: Column(
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      BookCover(
                        coverUrl: widget.book.coverUrl,
                        width: 140,
                        height: 205,
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.background,
            child: SafeArea(top: false, child: _buildContent()),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: AppColors.navy,
            child: SafeArea(
              right: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
                child: Column(
                  children: [
                    _buildTopBar(),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        BookCover(
                          coverUrl: widget.book.coverUrl,
                          width: 110,
                          height: 160,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: AppColors.background,
            child: SafeArea(left: false, child: _buildContent()),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        const Spacer(),
        IconButton(
          tooltip: _isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
          onPressed: _isSaving ? null : _toggleFavorite,
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? AppColors.red : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    final book = widget.book;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          book.judul,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          book.penulis,
          style: const TextStyle(fontSize: 14, color: AppColors.orange),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildInfo('Penerbit', book.penerbit)),
            const SizedBox(width: 12),
            Expanded(child: _buildInfo('Tahun terbit', book.tahunTerbit)),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Deskripsi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          (book.deskripsi ?? '').isEmpty
              ? 'Belum ada deskripsi.'
              : book.deskripsi!,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  // Kotak kecil berisi label dan nilai, contoh: Penerbit / Gramedia
  Widget _buildInfo(String label, String? value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: AppColors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  (value ?? '').isEmpty ? '-' : value!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
