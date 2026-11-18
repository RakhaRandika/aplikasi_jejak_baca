import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/status_baca.dart';
import '../models/book.dart';
import '../theme/app_colors.dart';
import '../widgets/book_cover.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  final Book? rakEntry;
  final Future<bool> Function(Book book) onToggleRak;
  final Future<Book?> Function(Book book, StatusBaca status) onSimpanRak;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.rakEntry,
    required this.onToggleRak,
    required this.onSimpanRak,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Book? _entry = widget.rakEntry;
  bool _isSaving = false;

  bool get _isInRak => _entry != null;

  Future<void> _toggleRak() async {
    setState(() => _isSaving = true);
    final wasInRak = _isInRak;
    final berhasil = await widget.onToggleRak(widget.book);
    if (!mounted) return;
    setState(() {
      if (berhasil) {
        _entry = wasInRak ? null : widget.book.withRak(StatusBaca.ingin);
      }
      _isSaving = false;
    });
  }

  Future<void> _simpan(StatusBaca status) async {
    setState(() => _isSaving = true);
    final updated = await widget.onSimpanRak(widget.book, status);
    if (!mounted) return;
    setState(() {
      if (updated != null) _entry = updated;
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
          tooltip: _isInRak ? 'Hapus dari rak' : 'Simpan ke rak',
          onPressed: _isSaving ? null : _toggleRak,
          icon: Icon(
            _isInRak ? Icons.bookmark : Icons.bookmark_add_outlined,
            color: _isInRak ? AppColors.accent : Colors.white,
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
        _buildSectionTitle('Status baca'),
        const SizedBox(height: 8),
        _buildStatusPicker(),
        const SizedBox(height: 20),
        _buildSectionTitle('Deskripsi'),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.navy,
      ),
    );
  }

  Widget _buildStatusPicker() {
    final children = <Widget>[];
    for (final status in StatusBaca.values) {
      if (children.isNotEmpty) children.add(const SizedBox(width: 8));
      final isActive = _entry?.status == status;
      children.add(
        Expanded(
          child: OutlinedButton(
            onPressed: _isSaving || isActive ? null : () => _simpan(status),
            style: OutlinedButton.styleFrom(
              backgroundColor: isActive ? AppColors.navy : AppColors.white,
              disabledBackgroundColor: isActive
                  ? AppColors.navy
                  : AppColors.white,
              foregroundColor: AppColors.navy,
              disabledForegroundColor: isActive
                  ? AppColors.white
                  : AppColors.grey,
              side: const BorderSide(color: AppColors.border),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    }
    return Row(children: children);
  }
}
