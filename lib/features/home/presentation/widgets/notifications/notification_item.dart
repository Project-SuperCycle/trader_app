import 'package:flutter/material.dart';
import 'package:trader_app/core/models/notifications_model.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    required this.notContext,
    this.onRead,
    this.onDelete,
  });

  final NotificationModel notification;
  final VoidCallback? onTap;
  final BuildContext notContext;
  final VoidCallback? onRead;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? Colors.grey[200]!
                : const Color(0xFF10B981).withAlpha(100),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildIcon(),
                const SizedBox(height: 16),
                _buildMenuIcon(),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withAlpha(50),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.notifications,
        color: Color(0xFF10B981),
        size: 20,
      ),
    );
  }

  Widget _buildMenuIcon() {
    return Builder(
      builder: (BuildContext iconContext) {
        return GestureDetector(
          onTap: () {
            final RenderBox? renderBox =
                iconContext.findRenderObject() as RenderBox?;
            if (renderBox == null) return;

            final position = renderBox.localToGlobal(Offset.zero);

            // أنشئ overlay entry منفصل للـ menu
            OverlayEntry? menuOverlay;

            menuOverlay = OverlayEntry(
              builder: (overlayContext) => GestureDetector(
                onTap: () {
                  menuOverlay?.remove();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Positioned(
                        left: position.dx - 150,
                        top: position.dy + 30,
                        child: GestureDetector(
                          onTap: () {}, // عشان ميقفلش لما تضغط على الـ menu
                          child: Material(
                            elevation: 16,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildMenuItem(
                                    overlayContext,
                                    icon: Icons.mark_email_read_rounded,
                                    iconColor: const Color(0xFF10B981),
                                    label: 'قراءة',
                                    onTap: () {
                                      menuOverlay?.remove();
                                    },
                                  ),
                                  Divider(height: 1, color: Colors.grey[200]),
                                  _buildMenuItem(
                                    overlayContext,
                                    icon: Icons.delete_rounded,
                                    iconColor: Colors.red,
                                    label: 'حذف',
                                    onTap: () {
                                      menuOverlay?.remove();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            // أدخل الـ overlay
            Overlay.of(notContext).insert(menuOverlay);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            child: const Icon(
              Icons.more_horiz_rounded,
              color: Color(0xFF10B981),
              size: 20,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(label, style: AppStyles.styleMedium14(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: AppStyles.styleBold14(context),
              ),
            ),
            if (!notification.isRead) _buildUnreadBadge(),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          notification.message,
          style: AppStyles.styleMedium12(
            context,
          ).copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          notification.time,
          style: AppStyles.styleRegular12(
            context,
          ).copyWith(color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildUnreadBadge() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFF10B981),
        shape: BoxShape.circle,
      ),
    );
  }
}
