import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/app_transitions.dart';
import 'package:trader_app/core/models/shipment/single_shipment_model.dart';
import 'package:trader_app/core/models/user_profile_model.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/features/calculator/presentation/view/calculator_view.dart';
import 'package:trader_app/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:trader_app/features/environment/presentation/views/environmental_default_view.dart';
import 'package:trader_app/features/environment/presentation/views/environmental_impact_view.dart';
import 'package:trader_app/features/environment/presentation/widgets/loading/environment_loading_indicator.dart';
import 'package:trader_app/features/forget_password/presentation/views/forget_password_view.dart';
import 'package:trader_app/features/forget_password/presentation/views/reset_password_view.dart';
import 'package:trader_app/features/forget_password/presentation/views/verify_reset_otp_view.dart';
import 'package:trader_app/features/home/presentation/views/home_view.dart';
import 'package:trader_app/features/notifications/presentation/views/notifications_view.dart';
import 'package:trader_app/features/onboarding/presentation/views/first_onboarding_view.dart';
import 'package:trader_app/features/onboarding/presentation/views/fourth_onboarding_view.dart';
import 'package:trader_app/features/onboarding/presentation/views/second_onboarding_view.dart';
import 'package:trader_app/features/onboarding/presentation/views/third_onboarding_view.dart';
import 'package:trader_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:trader_app/features/shipment_edit/presentation/views/shipment_edit_view.dart';
import 'package:trader_app/features/shipments_calendar/presentation/view/shipments_calendar_view.dart';
import 'package:trader_app/features/sign_in/presentation/views/sign_in_view.dart';
import 'package:trader_app/features/sign_up/presentation/views/sign_up_details_view.dart';
import 'package:trader_app/features/sign_up/presentation/views/sign_up_verify_view.dart';
import 'package:trader_app/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:trader_app/features/splash/views/splash_view.dart';
import 'package:trader_app/features/trader_main_profile/presentation/view/trader_profile_view.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/loading/trader_profile_loading_indicator.dart';
import 'package:trader_app/features/trader_shipment_details/presentation/views/trader_shipment_details_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: EndPoints.splashView,
    routes: [
      // ============================================================
      // Splash & Onboarding - Quick Fade
      // ============================================================
      GoRoute(
        path: EndPoints.splashView,
        name: 'splash',
        pageBuilder: (context, state) =>
            AppTransitions.quickFade(state.pageKey, const SplashView()),
      ),

      GoRoute(
        path: EndPoints.firstOnboardingView,
        name: 'FirstOnboarding',
        pageBuilder: (context, state) => AppTransitions.smoothFade(
          state.pageKey,
          const FirstOnboardingView(),
        ),
      ),

      GoRoute(
        path: EndPoints.secondOnboardingView,
        name: 'SecondOnboarding',
        pageBuilder: (context, state) => AppTransitions.smoothFade(
          state.pageKey,
          const SecondOnboardingView(),
        ),
      ),

      GoRoute(
        path: EndPoints.thirdOnboardingView,
        name: 'ThirdOnboarding',
        pageBuilder: (context, state) => AppTransitions.smoothFade(
          state.pageKey,
          const ThirdOnboardingView(),
        ),
      ),

      GoRoute(
        path: EndPoints.fourthOnboardingView,
        name: 'FourthOnboarding',
        pageBuilder: (context, state) => AppTransitions.smoothFade(
          state.pageKey,
          const FourthOnboardingView(),
        ),
      ),

      // ============================================================
      // Main Navigation - Smooth Fade
      // ============================================================
      GoRoute(
        path: EndPoints.homeView,
        name: 'Home',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForMain(state.pageKey, const HomeView()),
      ),

      GoRoute(
        path: EndPoints.calculatorView,
        name: 'Calculator',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForMain(state.pageKey, CalculatorView()),
      ),

      GoRoute(
        path: EndPoints.contactUsView,
        name: 'Contact Us',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForMain(state.pageKey, ContactUsView()),
      ),

      GoRoute(
        path: EndPoints.shipmentsCalendarView,
        name: 'Shipments Calendar',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForMain(state.pageKey, ShipmentsCalendarView()),
      ),

      // ============================================================
      // Authentication - Smooth Auth Transition
      // ============================================================
      GoRoute(
        path: EndPoints.signInView,
        name: 'SignIn',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForAuth(state.pageKey, const SignInView()),
      ),

      GoRoute(
        path: EndPoints.signUpView,
        name: 'SignUp',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForAuth(state.pageKey, const SignUpView()),
      ),

      GoRoute(
        path: EndPoints.signUpVerifyView,
        name: 'SignUpVerify',
        pageBuilder: (context, state) {
          final credential = state.extra as String;
          return AppTransitions.smoothFadeWithScale(
            state.pageKey,
            SignUpVerifyView(credential: credential),
          );
        },
      ),

      GoRoute(
        path: EndPoints.signUpDetailsView,
        name: 'SignUpDetails',
        pageBuilder: (context, state) => AppTransitions.smoothFadeWithScale(
          state.pageKey,
          const SignUpDetailsView(),
        ),
      ),

      GoRoute(
        path: EndPoints.forgetPasswordView,
        name: 'Forget Password',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForAuth(state.pageKey, ForgetPasswordView()),
      ),

      GoRoute(
        path: EndPoints.verifyResetOtpView,
        name: 'Verify Reset OTP',
        pageBuilder: (context, state) => AppTransitions.smoothFadeWithScale(
          state.pageKey,
          VerifyResetOtpView(email: state.extra as String),
        ),
      ),

      GoRoute(
        path: EndPoints.resetPasswordView,
        name: 'Reset Password',
        pageBuilder: (context, state) => AppTransitions.smoothFadeWithScale(
          state.pageKey,
          ResetPasswordView(token: state.extra as String),
        ),
      ),

      // ============================================================
      // Sales Process - Smooth Transition
      // ============================================================
      GoRoute(
        path: EndPoints.salesProcessView,
        name: 'SalesProcess',
        pageBuilder: (context, state) => AppTransitions.fadeForDetails(
          state.pageKey,
          const SalesProcessView(),
        ),
      ),

      // ============================================================
      // Shipment Details - Fade with Scale
      // ============================================================
      GoRoute(
        path: EndPoints.traderShipmentDetailsView,
        name: 'TraderShipmentDetails',
        pageBuilder: (context, state) => AppTransitions.fadeForDetails(
          state.pageKey,
          TraderShipmentDetailsView(
            shipment: state.extra as SingleShipmentModel,
          ),
        ),
      ),

      // ============================================================
      // Edit Screens - Modal Style
      // ============================================================
      GoRoute(
        path: EndPoints.shipmentEditView,
        name: 'ShipmentEdit',
        pageBuilder: (context, state) => AppTransitions.fadeForModal(
          state.pageKey,
          ShipmentEditView(shipment: state.extra as SingleShipmentModel),
        ),
      ),

      // ============================================================
      // Pre Profile Views - Smooth Fade
      // ============================================================
      GoRoute(
        path: EndPoints.traderPreProfileView,
        name: 'Trader Pre Profile',
        pageBuilder: (context, state) => AppTransitions.smoothFade(
          state.pageKey,
          TraderProfileLoadingIndicator(),
        ),
      ),

      // ============================================================
      // Profile Views - Smooth Fade
      // ============================================================
      GoRoute(
        path: EndPoints.traderProfileView,
        name: 'Trader Profile',
        pageBuilder: (context, state) => AppTransitions.smoothFade(
          state.pageKey,
          TraderProfileView(userProfile: state.extra as UserProfileModel),
        ),
      ),

      // ============================================================
      // Environmental Pre - Main Style
      // ============================================================
      GoRoute(
        path: EndPoints.environmentalPreView,
        name: 'Environmental Pre',
        pageBuilder: (context, state) => AppTransitions.fadeForMain(
          state.pageKey,
          EnvironmentLoadingIndicator(),
        ),
      ),

      // ============================================================
      // Environmental Impact - Main Style
      // ============================================================
      GoRoute(
        path: EndPoints.environmentalImpactView,
        name: 'Environmental Impact',
        pageBuilder: (context, state) => AppTransitions.fadeForMain(
          state.pageKey,
          EnvironmentalImpactView(),
        ),
      ),

      // ============================================================
      // Environmental Default - Main Style
      // ============================================================
      GoRoute(
        path: EndPoints.environmentalDefaultView,
        name: 'Environmental Default',
        pageBuilder: (context, state) => AppTransitions.fadeForMain(
          state.pageKey,
          EnvironmentalDefaultView(),
        ),
      ),

      // ============================================================
      // Notifications View - Main Style
      // ============================================================
      GoRoute(
        path: EndPoints.notificationsView,
        name: 'Notifications View',
        pageBuilder: (context, state) =>
            AppTransitions.fadeForMain(state.pageKey, NotificationsView()),
      ),
    ],

    // Custom error page with smooth fade
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.toString()}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(EndPoints.homeView),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
