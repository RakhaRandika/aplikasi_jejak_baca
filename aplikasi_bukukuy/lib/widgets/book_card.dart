import 'package:flutter/material.dart';

import '../models/book.dart';
import 'book_cover.dart';

// Kartu buku untuk grid di Beranda
class BookCard extends StatelessWidget {
  final Book book;
  final double width;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const BookCard({
    super.key,
    required this.book,
    required this.width,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Stack(
              children: [
                BookCover(
                  coverUrl: book.coverUrl,
                  width: width,
                  height: width * 1.45,
                ),
                Positioned(top: 6, right: 6, child: _buildFavoriteButton()),
              ],
            ),
            const SizedBox(height: 8),
            // Tinggi judul tetap (2 baris) supaya semua kartu dalam satu baris sama tinggi
            SizedBox(
              height: 34,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.judul,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E1A4D),
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
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
                      fontSize: 11,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onFavoriteTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 16,
            color: isFavorite
                ? const Color(0xFFDC2626)
                : const Color(0xFF9E9E9E),
          ),
        ),
      ),
    );
  }
}
