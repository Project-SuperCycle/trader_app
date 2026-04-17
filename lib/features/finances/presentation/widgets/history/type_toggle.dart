import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class TypeToggle extends StatefulWidget {
  const TypeToggle({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<TypeToggle> createState() => _TypeToggleState();
}

class _TypeToggleState extends State<TypeToggle> {
  String type = '';
  bool isTapped = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // داخل التعاقد
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isTapped = true);
                widget.onChanged('monthly');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isTapped
                      ? Colors.white.withValues(alpha: 0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'داخل التعاقد',
                  textDirection: TextDirection.rtl,
                  style: AppStyles.styleBold14(context).copyWith(
                    color: isTapped ? const Color(0xFF3BC577) : Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // تم التحصيل
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isTapped = false);
                widget.onChanged("external");
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isTapped
                      ? Colors.transparent
                      : Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'خارج التعاقد',
                  textDirection: TextDirection.rtl,
                  style: AppStyles.styleBold14(context).copyWith(
                    color: isTapped ? Colors.white : const Color(0xFF3BC577),
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
