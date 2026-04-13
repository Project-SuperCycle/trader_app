import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/settings/data/classes/setting_item.dart';

class SettingTile extends StatefulWidget {
  final SettingItem item;
  final Color accentColor;

  const SettingTile({super.key, required this.item, required this.accentColor});

  @override
  State<SettingTile> createState() => SettingTileState();
}

class SettingTileState extends State<SettingTile> {
  bool _pressed = false;

  void _navigate() {
    GoRouter.of(context).push(widget.item.route, extra: widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        _navigate();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: _pressed ? const Color(0xFFE8EDEB) : const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ── Icon badge (RHS in RTL = right side visually) ──
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.item.icon,
                  color: widget.accentColor,
                  size: 22,
                ),
              ),

              // ── Label ──
              Text(
                widget.item.title,
                style: AppStyles.styleMedium16(
                  context,
                ).copyWith(color: Color(0xFF2C2C2C)),
              ),

              // ── Arrow (LHS in RTL = left side visually) ──
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade400,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
