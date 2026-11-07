import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// Navbar bawah dua tab: Beranda & Favorit (dibagi dua sama lebar)
class AppButtonNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppButtonNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: MediaQuery.orientationOf(context) == Orientation.landscape
              ? 52
              : 64,
          child: Row(
            children: [
              Expanded(
                child: _buildItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Beranda',
                  index: 0,
                ),
              ),
              Expanded(
                child: _buildItem(
                  icon: Icons.favorite_border,
                  activeIcon: Icons.favorite,
                  label: 'Favorit',
                  index: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.navy : AppColors.grey;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        children: [
          const Spacer(),
          Icon(isActive ? activeIcon : icon, size: 24, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: color,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
