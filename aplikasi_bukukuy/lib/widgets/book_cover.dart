import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BookCover extends StatelessWidget {
  final String? coverUrl;
  final double width;
  final double height;
  final double borderRadius;

  const BookCover({
    super.key,
    this.coverUrl,
    this.width = 110,
    this.height = 160,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final url = coverUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: url == null || url.isEmpty
            ? _buildPlaceholder()
            : Image.network(
                url,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded || frame != null) return child;
                  return _buildSpinner();
                },
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return _buildCentered(
      Icon(
        Icons.menu_book_rounded,
        size: width * 0.35,
        color: AppColors.iconBlue,
      ),
    );
  }

  Widget _buildSpinner() {
    return _buildCentered(
      const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.iconBlue,
        ),
      ),
    );
  }

  Widget _buildCentered(Widget child) {
    return Container(
      color: AppColors.navyLight,
      child: Column(
        children: [
          const Spacer(),
          Row(children: [const Spacer(), child, const Spacer()]),
          const Spacer(),
        ],
      ),
    );
  }
}
