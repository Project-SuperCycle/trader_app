import 'package:flutter/material.dart';
import 'package:trader_app/core/models/notifications_model.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.notContext,
    this.onTap,
    required this.onRead,
    required this.onDelete,
  });

  final NotificationModel notification;
  final BuildContext notContext;
  final VoidCallback? onTap;
  final VoidCallback onRead;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.seen ? Colors.white : const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.seen
                ? Colors.grey[200]!
                : const Color(0xFF10B981).withAlpha(100),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildIcon(),
                const SizedBox(height: 16),
                _buildMenuIcon(context),
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

  Widget _buildMenuIcon(BuildContext context) {
    return Builder(
      builder: (iconContext) {
        return GestureDetector(
          onTap: () {
            final box = iconContext.findRenderObject() as RenderBox?;
            if (box == null) return;

            final position = box.localToGlobal(Offset.zero);
            OverlayEntry? overlay;

            overlay = OverlayEntry(
              builder: (_) => GestureDetector(
                onTap: () => overlay?.remove(),
                child: Stack(
                  children: [
                    Positioned(
                      left: position.dx - 150,
                      top: position.dy + 30,
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
                                context: context,
                                icon: Icons.mark_email_read_rounded,
                                iconColor: const Color(0xFF10B981),
                                label: 'قراءة',
                                onTap: () {
                                  onRead();
                                  overlay?.remove();
                                },
                              ),
                              Divider(height: 1, color: Colors.grey[200]),
                              _buildMenuItem(
                                context: context,
                                icon: Icons.delete_rounded,
                                iconColor: Colors.red,
                                label: 'حذف',
                                onTap: () {
                                  onDelete();
                                  overlay?.remove();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

            Overlay.of(notContext).insert(overlay);
          },
          child: const Icon(
            Icons.more_horiz_rounded,
            color: Color(0xFF10B981),
            size: 20,
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onTap,
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
            if (!notification.seen) _buildUnreadBadge(),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          notification.body,
          style: AppStyles.styleMedium12(
            context,
          ).copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          notification.createdAt.toString(),
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
