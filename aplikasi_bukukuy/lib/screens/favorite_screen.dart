import 'package:flutter/material.dart';

import '../enums/load_state.dart';
import '../models/book.dart';
import '../theme/app_colors.dart';
import '../widgets/book_cover.dart';

class FavoriteScreen extends StatelessWidget {
  final LoadState state;
  final String errorMessage;
  final List<Book> favorites;
  final VoidCallback onRetry;
  final ValueChanged<Book> onRemove;
  final ValueChanged<Book> onOpen;

  const FavoriteScreen({
    super.key,
    required this.state,
    required this.errorMessage,
    required this.favorites,
    required this.onRetry,
    required this.onRemove,
    required this.onOpen,
  });

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
    final isReady = state == LoadState.success || state == LoadState.empty;

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
                      'Buku Favorit',
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isReady
                          ? '${favorites.length} buku tersimpan'
                          : 'Buku yang kamu simpan',
                      style: const TextStyle(
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
    switch (state) {
      case LoadState.initial:
      case LoadState.loading:
        return _buildStateMessage(const [
          CircularProgressIndicator(color: AppColors.navy),
        ]);
      case LoadState.empty:
        return _buildStateMessage(const [
          Icon(Icons.favorite, size: 72, color: AppColors.purpleFaded),
          SizedBox(height: 16),
          Text(
            'Belum ada favorit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tekan ikon hati pada buku yang kamu suka untuk menyimpannya di sini',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grey, fontSize: 14, height: 1.5),
          ),
        ]);
      case LoadState.error:
        return _buildError(errorMessage, onRetry);
      case LoadState.success:
        break;
    }
    return _buildList();
  }

  Widget _buildList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 600 ? 2 : 1;
        final rowCount = (favorites.length / columns).ceil();

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
                  child: index < favorites.length
                      ? _buildItem(favorites[index])
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
      onTap: () => onOpen(book),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 92,
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
              width: 48,
              height: 70,
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
                          maxLines: 2,
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
                  const SizedBox(height: 4),
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
                  const Spacer(),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Hapus dari favorit',
              icon: const Icon(Icons.favorite, color: AppColors.red),
              onPressed: () => onRemove(book),
            ),
          ],
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
