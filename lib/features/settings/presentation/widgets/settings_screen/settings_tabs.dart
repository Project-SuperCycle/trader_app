import 'package:flutter/material.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/features/settings/data/classes/setting_item.dart';
import 'package:trader_app/features/settings/presentation/widgets/settings_screen/setting_tile.dart';

class SettingsTabs extends StatelessWidget {
  const SettingsTabs({super.key});

  static final List<SettingItem> _items = [
    SettingItem(
      title: 'تغيير البيانات',
      icon: Icons.person_outline_rounded,
      route: EndPoints.placeHolderView,
    ),
    SettingItem(
      title: 'تغيير الصورة',
      icon: Icons.image_outlined,
      route: EndPoints.placeHolderView,
    ),
    SettingItem(
      title: 'تغيير كلمة المرور',
      icon: Icons.lock_outline_rounded,
      route: EndPoints.placeHolderView,
    ),
    SettingItem(
      title: 'تغيير البريد الإلكتروني',
      icon: Icons.mail_outline_rounded,
      route: EndPoints.placeHolderView,
    ),
    SettingItem(
      title: 'صلاحيات الإشعارات',
      icon: Icons.notifications_none_rounded,
      route: EndPoints.placeHolderView,
    ),
    SettingItem(
      title: 'تغيير طرق التحصيل',
      icon: Icons.camera_outlined,
      route: EndPoints.placeHolderView,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: SettingTile(
                item: item,
                accentColor: const Color(0xFF1A7A5E),
              ),
            ),
          )
          .toList(),
    );
  }
}
