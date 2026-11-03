import 'package:flutter/material.dart';

// Cover buku: spinner saat memuat, ikon buku bila kosong / gagal dimuat
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
        color: const Color(0xFFA5B4FC),
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
          color: Color(0xFFA5B4FC),
        ),
      ),
    );
  }

  // Spacer - Widget - Spacer di tengah (vertikal + horizontal)
  Widget _buildCentered(Widget child) {
    return Container(
      color: const Color(0xFF2A2560),
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
