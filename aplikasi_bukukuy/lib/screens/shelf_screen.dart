import 'package:flutter/material.dart';

import '../enums/load_state.dart';
import '../enums/reading_status.dart';
import '../models/book.dart';
import '../theme/app_colors.dart';
import '../widgets/book_cover.dart';

class ShelfScreen extends StatefulWidget {
  final LoadState state;
  final String errorMessage;
  final List<Book> shelf;
  final VoidCallback onRetry;
  final ValueChanged<Book> onRemove;
  final ValueChanged<Book> onOpen;

  const ShelfScreen({
    super.key,
    required this.state,
    required this.errorMessage,
    required this.shelf,
    required this.onRetry,
    required this.onRemove,
    required this.onOpen,
  });

  @override
  State<ShelfScreen> createState() => _ShelfScreenState();
}

class _ShelfScreenState extends State<ShelfScreen> {
  ReadingStatus? _filter;

  int _count(ReadingStatus status) =>
      widget.shelf.where((b) => b.status == status).length;

  List<Book> get _filtered => _filter == null
      ? widget.shelf
      : widget.shelf.where((b) => b.status == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Container(
            color: AppColors.background,
            child: SafeArea(top: false, bottom: false, child: _buildBody()),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.navy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rak Bacaku',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Jejak bacaanmu',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.blueFaded,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (widget.state) {
      case LoadState.initial:
      case LoadState.loading:
        return _buildStateMessage(const [
          CircularProgressIndicator(color: AppColors.navy),
        ]);
      case LoadState.empty:
        return _buildStateMessage(const [
          Icon(Icons.bookmark, size: 72, color: AppColors.purpleFaded),
          SizedBox(height: 16),
          Text(
            'Rak bacamu masih kosong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tekan ikon penanda pada buku untuk menyimpannya ke rak',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grey, fontSize: 14, height: 1.5),
          ),
        ]);
      case LoadState.error:
        return _buildError(widget.errorMessage, widget.onRetry);
      case LoadState.success:
        break;
    }

    return Column(
      children: [
        _buildFilterBar(),
        Expanded(
          child: _filtered.isEmpty
              ? _buildStateMessage(const [
                  Text(
                    'Belum ada buku dengan status ini',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ])
              : _buildList(),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    final chips = <Widget>[_buildFilterChip(null, 'Semua (${widget.shelf.length})')];
    for (final status in ReadingStatus.values) {
      chips.add(const SizedBox(width: 8));
      chips.add(_buildFilterChip(status, '${status.label} (${_count(status)})'));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(children: chips),
    );
  }

  Widget _buildFilterChip(ReadingStatus? status, String label) {
    final isActive = _filter == status;
    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      showCheckmark: false,
      onSelected: (_) => setState(() => _filter = status),
      selectedColor: AppColors.navy,
      backgroundColor: AppColors.white,
      side: const BorderSide(color: AppColors.border),
      labelStyle: TextStyle(
        fontSize: 12,
        color: isActive ? AppColors.white : AppColors.navy,
      ),
    );
  }

  Widget _buildList() {
    final books = _filtered;
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 600 ? 2 : 1;
        final rowCount = (books.length / columns).ceil();

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: rowCount,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, row) {
            final children = <Widget>[];
            for (var col = 0; col < columns; col++) {
              if (col > 0) children.add(const SizedBox(width: 12));
              final index = row * columns + col;
              children.add(
                Expanded(
                  child: index < books.length
                      ? _buildItem(books[index])
                      : const SizedBox(),
                ),
              );
            }
            return Row(children: children);
          },
        );
      },
    );
  }

  Widget _buildItem(Book book) {
    return InkWell(
      onTap: () => widget.onOpen(book),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 104,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            BookCover(
              coverUrl: book.coverUrl,
              width: 56,
              height: 82,
              borderRadius: 8,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.judul,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.penulis,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildStatusLabel(
                        book.status ?? ReadingStatus.wantToRead,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Hapus dari rak',
              icon: const Icon(Icons.bookmark_remove, color: AppColors.grey),
              onPressed: () => widget.onRemove(book),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusLabel(ReadingStatus status) {
    final color = switch (status) {
      ReadingStatus.wantToRead => AppColors.grey,
      ReadingStatus.reading => AppColors.orange,
      ReadingStatus.finished => AppColors.navy,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStateMessage(List<Widget> children) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [Expanded(child: Column(children: children))],
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildError(String message, VoidCallback onRetry) {
    return _buildStateMessage([
      const Icon(Icons.wifi_off, size: 48, color: AppColors.grey),
      const SizedBox(height: 12),
      Text(message, textAlign: TextAlign.center),
      const SizedBox(height: 12),
      ElevatedButton(
        onPressed: onRetry,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy,
          foregroundColor: AppColors.white,
        ),
        child: const Text('Coba lagi'),
      ),
    ]);
  }
}
