import 'package:flutter/material.dart';
import 'package:trader_app/core/models/notifications_model.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/home/presentation/widgets/notifications/notification_item.dart';
import 'package:trader_app/features/home/presentation/widgets/notifications/notifications_empty_state.dart';

class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key});

  @override
  State<NotificationsViewBody> createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // TODO: استبدليها بداتا من الـ API
  final List<NotificationModel> _allNotifications = [
    NotificationModel(
      id: '1',
      title: 'شحنة جديدة',
      message: 'تم إضافة شحنة جديدة #12345',
      time: 'منذ ساعة',
      isRead: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationModel> get _unreadNotifications =>
      _allNotifications.where((n) => !n.isRead).toList();

  List<NotificationModel> get _readNotifications =>
      _allNotifications.where((n) => n.isRead).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(children: [_buildTabs(), _buildContent()]),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: const SizedBox.shrink(),
      centerTitle: false,
      leadingWidth: 10.0,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      title: Text(
        'الإشعارات',
        style: AppStyles.styleBold18(context).copyWith(color: Colors.white),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey[200]),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color(0xFF10B981),
            borderRadius: BorderRadius.circular(10),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[600],
          labelStyle: AppStyles.styleSemiBold14(context),
          unselectedLabelStyle: AppStyles.styleSemiBold14(context),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'غير مقروءة'),
            Tab(text: 'مقروءة'),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(_allNotifications, 'الكل'),
          _buildNotificationsList(_unreadNotifications, 'غير مقروءة'),
          _buildNotificationsList(_readNotifications, 'مقروءة'),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(
    List<NotificationModel> notifications,
    String type,
  ) {
    if (notifications.isEmpty) {
      return NotificationsEmptyState(type: type);
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
        );
      },
    );
  }

  void _handleNotificationTap(NotificationModel notification) {
    // TODO: اعملي الأكشن اللي عايزاه لما يضغط على إشعار
  }
}
