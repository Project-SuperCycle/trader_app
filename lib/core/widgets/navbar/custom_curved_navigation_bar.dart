import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/services/auth_manager_services.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_assets.dart';
import 'package:trader_app/core/utils/app_colors.dart';
import 'package:trader_app/features/sign_in/data/models/logined_user_model.dart';

class CustomCurvedNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final GlobalKey<CurvedNavigationBarState>? navigationKey;

  const CustomCurvedNavigationBar({
    super.key,
    this.currentIndex = 2,
    this.onTap,
    this.navigationKey,
  });

  @override
  State<CustomCurvedNavigationBar> createState() =>
      _CustomCurvedNavigationBarState();
}

class _CustomCurvedNavigationBarState extends State<CustomCurvedNavigationBar> {
  late int _currentIndex;
  bool isUserLoggedIn = false;
  final AuthManager _authManager = AuthManager();

  @override
  void initState() {
    super.initState();
    _currentIndex = _getIndexFromCurrentRoute();
    _loadUserData();
    _authManager.authStateChangeNotifier.addListener(_onAuthStateChanged);
  }

  int _getIndexFromCurrentRoute() {
    final currentRoute = _getCurrentRoute();

    if (currentRoute.contains(EndPoints.calculatorView)) {
      return 0;
    } else if (currentRoute.contains(EndPoints.salesProcessView)) {
      return 1;
    } else if (currentRoute.contains(EndPoints.homeView) ||
        currentRoute == '/') {
      return 2;
    } else if (currentRoute.contains(EndPoints.shipmentsCalendarView)) {
      return 3;
    } else if (currentRoute.contains(EndPoints.contactUsView)) {
      return 4;
    } else if (currentRoute.contains(EndPoints.FinancialTransactionView)) {
      return 5;
    }

    return widget.currentIndex;
  }

  @override
  void didUpdateWidget(CustomCurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newIndex = _getIndexFromCurrentRoute();
    if (_currentIndex != newIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final newIndex = _getIndexFromCurrentRoute();
        if (_currentIndex != newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _authManager.authStateChangeNotifier.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (mounted) _loadUserData();
  }

  Future<void> _loadUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    if (mounted) {
      setState(() {
        isUserLoggedIn = (user != null);
      });
    }
  }

  String _getCurrentRoute() {
    try {
      final router = GoRouter.of(context);
      final location =
          router.routerDelegate.currentConfiguration.last.matchedLocation;
      return location;
    } catch (e) {
      return '/';
    }
  }

  String? _getTargetRoute(int index) {
    switch (index) {
      case 0:
        return EndPoints.calculatorView;
      case 1:
        return isUserLoggedIn
            ? EndPoints.salesProcessView
            : EndPoints.signInView;
      case 2:
        return EndPoints.homeView;
      case 3:
        return isUserLoggedIn
            ? EndPoints.shipmentsCalendarView
            : EndPoints.signInView;
      case 4:
        return EndPoints.contactUsView;
      case 5:
        return isUserLoggedIn
            ? EndPoints.FinancialTransactionView
            : EndPoints.signInView;
      default:
        return null;
    }
  }

  void _handleTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (widget.onTap != null) {
      widget.onTap!(index);
    }

    final currentRoute = _getCurrentRoute();
    final targetRoute = _getTargetRoute(index);

    if (targetRoute != null && currentRoute == targetRoute) return;

    _navigateToScreen(index);
  }

  void _navigateToScreen(int index) {
    if (!mounted) return;

    final router = GoRouter.of(context);

    try {
      switch (index) {
        case 0:
          router.push(EndPoints.calculatorView);
          break;
        case 1:
          if (isUserLoggedIn) {
            router.push(EndPoints.salesProcessView);
          } else {
            _showLoginRequired('عملية البيع');
            router.push(EndPoints.signInView);
          }
          break;
        case 2:
          router.pushReplacement(EndPoints.homeView);
          break;
        case 3:
          if (isUserLoggedIn) {
            router.push(EndPoints.shipmentsCalendarView);
          } else {
            _showLoginRequired('جدول الشحنات');
            router.push(EndPoints.signInView);
          }
          break;
        case 4:
          router.push(EndPoints.contactUsView);
          break;
        case 5:
          if (isUserLoggedIn) {
            router.push(EndPoints.FinancialTransactionView);
          } else {
            _showLoginRequired('الماليات');
            router.push(EndPoints.signInView);
          }
          break;
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showWarning(
          context,
          'حدث خطأ أثناء التنقل: ${e.toString()}',
        );
      }
    }
  }

  void _showLoginRequired(String featureName) {
    if (!mounted) return;
    CustomSnackBar.showWarning(
      context,
      'يرجى تسجيل الدخول للوصول إلى $featureName',
    );
  }

  // ✅ لون الأيقونة — أخضر لو active، رمادي لو لا
  Color _iconColor(int itemIndex) {
    return _currentIndex == itemIndex
        ? AppColors.primaryColor
        : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final newIndex = _getIndexFromCurrentRoute();
        if (_currentIndex != newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        }
      }
    });

    return CurvedNavigationBar(
      index: _currentIndex,
      key: widget.navigationKey,
      color: Colors.white,
      backgroundColor: AppColors.primaryColor,
      height: 60,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      items: <Widget>[
        // 0 - حاسبة
        Tooltip(
          message: 'حاسبة',
          child: SvgPicture.asset(
            AppAssets.calculatorIcon,
            height: 24,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              _iconColor(0),
              BlendMode.srcIn,
            ),
          ),
        ),

        // 1 - عملية بيع
        Tooltip(
          message: 'عملية بيع',
          child: SvgPicture.asset(
            AppAssets.boxIcon,
            height: 30,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              _iconColor(1),
              BlendMode.srcIn,
            ),
          ),
        ),

        // 2 - الرئيسية (ثابت في النص دايمًا)
        Tooltip(
          message: 'الرئيسية',
          child: Image.asset(
            AppAssets.homeIcon,
            height: 30,
            fit: BoxFit.cover,
            color: _iconColor(2),
          ),
        ),

        // 3 - الجدول
        Tooltip(
          message: 'الجدول',
          child: SvgPicture.asset(
            AppAssets.calendarIcon,
            height: 24,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              _iconColor(3),
              BlendMode.srcIn,
            ),
          ),
        ),

        // 4 - اتصل بنا
        Tooltip(
          message: 'اتصل بنا',
          child: SvgPicture.asset(
            AppAssets.chatIcon,
            height: 24,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              _iconColor(4),
              BlendMode.srcIn,
            ),
          ),
        ),

        // 5 - الماليات
        Tooltip(
          message: 'الماليات',
          child: Icon(
            Icons.account_balance_wallet_outlined,
            size: 24,
            color: _iconColor(5),
          ),
        ),
      ],
      onTap: _handleTap,
    );
  }
}