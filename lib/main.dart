import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:trader_app/core/cubits/add_notes_cubit/add_notes_cubit.dart';
import 'package:trader_app/core/cubits/local_cubit/local_cubit.dart';
import 'package:trader_app/core/cubits/social_auth/social_auth_cubit.dart';
import 'package:trader_app/core/helpers/custom_snack_bar.dart';
import 'package:trader_app/core/repos/social_auth_repo_imp.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/routes/routes.dart';
import 'package:trader_app/core/services/notifications/local_notifications_service.dart';
import 'package:trader_app/core/services/notifications/push_notifications_service.dart';
import 'package:trader_app/core/services/services_locator.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/environment/data/cubits/create_request_cubit/create_request_cubit.dart';
import 'package:trader_app/features/environment/data/cubits/eco_cubit/eco_cubit.dart';
import 'package:trader_app/features/environment/data/cubits/requests_cubit/requests_cubit.dart';
import 'package:trader_app/features/environment/data/repos/environment_repo_imp.dart';
import 'package:trader_app/features/forget_password/data/cubits/forget_password_cubit.dart';
import 'package:trader_app/features/forget_password/data/repos/forget_password_repo_imp.dart';
import 'package:trader_app/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:trader_app/features/home/data/managers/profile_cubit/profile_cubit.dart';
import 'package:trader_app/features/home/data/managers/shipments_cubit/today_shipments_cubit.dart';
import 'package:trader_app/features/home/data/repos/home_repo_imp.dart';
import 'package:trader_app/features/notifications/data/cubits/delete_notification/delete_notification_cubit.dart';
import 'package:trader_app/features/notifications/data/cubits/get_notifications/get_notifications_cubit.dart';
import 'package:trader_app/features/notifications/data/cubits/read_notification/read_notification_cubit.dart';
import 'package:trader_app/features/notifications/data/repos/notifications_repo_imp.dart';
import 'package:trader_app/features/sales_process/data/repos/sales_process_repo_imp.dart';
import 'package:trader_app/features/shipment_edit/data/cubits/shipment_edit_cubit.dart';
import 'package:trader_app/features/shipment_edit/data/repos/shipment_edit_repo_imp.dart';
import 'package:trader_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:trader_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:trader_app/features/shipments_calendar/data/repos/shipments_calendar_repo_imp.dart';
import 'package:trader_app/features/sign_in/data/cubits/sign-in-cubit/sign_in_cubit.dart';
import 'package:trader_app/features/sign_in/data/repos/signin_repo_imp.dart';
import 'package:trader_app/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart';
import 'package:trader_app/features/sign_up/data/repos/signup_repo_imp.dart';
import 'package:trader_app/features/trader_shipment_details/data/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:trader_app/features/trader_shipment_details/data/repos/shipment_details_repo_imp.dart';
import 'package:trader_app/features/trader_shipment_details/data/repos/shipment_notes_repo_imp.dart';
import 'package:trader_app/firebase_options.dart';

import 'features/sales_process/data/cubit/create_shipment_cubit/create_shipment_cubit.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initNonCriticalServices();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignInCubit(signInRepo: getIt.get<SignInRepoImp>()),
        ),
        BlocProvider(
          create: (context) =>
              SignUpCubit(signUpRepo: getIt.get<SignUpRepoImp>()),
        ),
        BlocProvider(
          create: (context) =>
              SocialAuthCubit(socialAuthRepo: getIt.get<SocialAuthRepoImp>()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(homeRepo: getIt.get<HomeRepoImp>()),
        ),
        BlocProvider(
          create: (context) => CreateShipmentCubit(
            shipmentReviewRepo: getIt.get<SalesProcessRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => ShipmentCubit(
            shipmentDetailsRepo: getIt.get<ShipmentDetailsRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddNotesCubit(
            shipmentNotesRepo: getIt.get<ShipmentNotesRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => ShipmentsCalendarCubit(
            shipmentsCalendarRepo: getIt.get<ShipmentsCalendarRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => ShipmentEditCubit(
            shipmentEditRepo: getIt.get<ShipmentEditRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) {
            final cubit = TodayShipmentsCubit(
              homeRepo: getIt.get<HomeRepoImp>(),
            );
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) =>
              EcoCubit(environmentRepoImp: getIt.get<EnvironmentRepoImp>()),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(
            forgetPasswordRepoImp: getIt.get<ForgetPasswordRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => RequestsCubit(
            environmentRepoImp: getIt.get<EnvironmentRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateRequestCubit(
            environmentRepoImp: getIt.get<EnvironmentRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              GetNotificationsCubit(repo: getIt.get<NotificationsRepoImp>()),
        ),
        BlocProvider(
          create: (context) =>
              ReadNotificationCubit(repo: getIt.get<NotificationsRepoImp>()),
        ),
        BlocProvider(
          create: (context) =>
              DeleteNotificationCubit(repo: getIt.get<NotificationsRepoImp>()),
        ),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _initNonCriticalServices() async {
  try {
    await PushNotificationsService.init();
    await LocalNotificationsService.init();
  } catch (e, s) {
    debugPrint('❌ Services init failed: $e');
    debugPrintStack(stackTrace: s);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _listenToNotificationTaps();
  }

  /// 🔔 Listen to notification taps and handle routing
  void _listenToNotificationTaps() {
    notificationStreamController.stream.listen((response) {
      // Parse the payload using the service method
      final Map<String, dynamic>? data = LocalNotificationsService.parsePayload(
        response.payload,
      );

      if (data == null) {
        Logger().w("❌ No valid data found in notification payload");
        return;
      }

      // Handle routing based on entity type
      _handleRooting(data: data);
    });
  }

  /// 🎯 Handle routing based on notification data
  void _handleRooting({required Map<String, dynamic> data}) {
    String entityType = data['entity'] ?? '';
    String entityId = data['entityId'] ?? '';
    String type = data['type'] ?? '';

    // Get the router from AppRouter
    final router = AppRouter.router;

    switch (entityType) {
      case "shipment":
        {
          // Get context from the navigator key
          final BuildContext? ctx =
              router.routerDelegate.navigatorKey.currentContext;

          if (ctx == null) {
            Logger().e("❌ Context is null, cannot navigate");
            return;
          }

          // Get the cubit and fetch shipment data
          final cubit = BlocProvider.of<ShipmentsCalendarCubit>(ctx);

          // Listen to the cubit state changes
          final subscription = cubit.stream.listen((state) {
            if (state is GetShipmentSuccess && state.shipment.id == entityId) {
              // Navigate to shipment details
              GoRouter.of(ctx).push(
                EndPoints.traderShipmentDetailsView,
                extra: state.shipment,
              );
            } else if (state is GetShipmentFailure) {
              CustomSnackBar.showError(context, state.errorMessage);
            }
          });

          // Fetch the shipment
          cubit.getShipmentById(shipmentId: entityId, type: type);

          // Cancel subscription after 10 seconds to prevent memory leaks
          Future.delayed(const Duration(seconds: 10), () {
            subscription.cancel();
          });
        }
        break;

      // Add more cases for other entity types
      case "order":
        {
          Logger().i("📦 Handling order routing...");
          // Handle order routing here
        }
        break;

      default:
        Logger().w("⚠️ Unknown entity type: $entityType");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalCubit()..getSavedLang(),
      child: BlocBuilder<LocalCubit, LocalState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Super Cycle',
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
            routerConfig: AppRouter.router,
            locale: (state is ChangeLocalState)
                ? const Locale('ar')
                : const Locale('ar'),
            builder: (context, child) {
              // دمج DevicePreview مع الـ Custom Banner
              child = DevicePreview.appBuilder(context, child);
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Banner(
                  message: 'تجريبية',
                  location: BannerLocation.topStart,
                  color: Color(0xff803C2B),
                  textStyle: AppStyles.styleBold12(context).copyWith(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                  child: child,
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Close the stream controller when disposing
    notificationStreamController.close();
    super.dispose();
  }
}
