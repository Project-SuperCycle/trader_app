import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';

class CollectionToggle extends StatefulWidget {
  const CollectionToggle({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<bool> onChanged;

  @override
  State<CollectionToggle> createState() => _CollectionToggleState();
}

class _CollectionToggleState extends State<CollectionToggle> {
  bool isPending = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.35),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // منتظر التحصيل
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isPending = true);
                widget.onChanged(true);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isPending
                      ? Colors.white.withOpacity(0.9)
                      : Colors.transparent,
                  borderRadius:
                  BorderRadius.circular(kButtonBorderRadius - 4),
                ),
                alignment: Alignment.center,
                child: Text(
                  'منتظر التحصيل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: isPending
                        ? const Color(0xFF3BC577)
                        : Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // تم التحصيل
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isPending = false);
                widget.onChanged(false);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isPending
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.9),
                  borderRadius:
                  BorderRadius.circular(kButtonBorderRadius - 4),
                ),
                alignment: Alignment.center,
                child: Text(
                  'تم التحصيل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: isPending
                        ? Colors.white
                        : const Color(0xFF3BC577),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}