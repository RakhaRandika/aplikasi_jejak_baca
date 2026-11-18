import 'package:flutter/material.dart';

import '../models/book.dart';
import 'book_cover.dart';
import '../theme/app_colors.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final double width;
  final bool isInRak;
  final VoidCallback onTap;
  final VoidCallback onRakTap;

  const BookCard({
    super.key,
    required this.book,
    required this.width,
    required this.isInRak,
    required this.onTap,
    required this.onRakTap,
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
                Positioned(top: 6, right: 6, child: _buildRakButton()),
              ],
            ),
            const SizedBox(height: 8),
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
                            color: AppColors.navy,
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
                    style: const TextStyle(fontSize: 11, color: AppColors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRakButton() {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onRakTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            isInRak ? Icons.bookmark : Icons.bookmark_border,
            size: 16,
            color: isInRak ? AppColors.orange : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
