import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];

    // ── زرار السابق ──
    items.add(_NavButton(
      icon: Icons.chevron_left,
      onTap: currentPage < totalPages
          ? () => onPageChanged(currentPage + 1)
          : null,
    ));

    // ── النقاط ... ──
    if (currentPage < totalPages - 1) {
      items.add(_DotsSeparator());
    }

    // ── الأرقام ──
    final List<int> pages = _buildPageNumbers();
    for (final page in pages) {
      items.add(_PageButton(
        page: page,
        isActive: page == currentPage,
        onTap: () => onPageChanged(page),
      ));
    }

    // ── زرار التالي ──
    items.add(_NavButton(
      icon: Icons.chevron_right,
      onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items
          .map((e) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: e,
      ))
          .toList(),
    );
  }

  List<int> _buildPageNumbers() {
    if (totalPages <= 3) {
      return List.generate(totalPages, (i) => i + 1).reversed.toList();
    }

    if (currentPage <= 3) {
      return [3, 2, 1];
    }

    if (currentPage >= totalPages - 1) {
      return [
        totalPages,
        totalPages - 1,
        totalPages - 2,
      ];
    }

    return [currentPage + 1, currentPage, currentPage - 1];
  }
}

// ── Page Number Button ──
class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.page,
    required this.isActive,
    required this.onTap,
  });

  final int page;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF3BC577) : Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadius / 2),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? const Color(0xFF3BC577).withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '$page',
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF10B981),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ── Nav Button (السابق / التالي) ──
class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadius / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 20,
          color: isEnabled ? const Color(0xFF3BC577) : Colors.grey.shade300,
        ),
      ),
    );
  }
}

// ── Dots Separator ──
class _DotsSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Text(
          '...',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}