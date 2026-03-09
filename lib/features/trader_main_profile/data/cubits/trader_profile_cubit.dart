import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trader_app/core/models/user_profile_model.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/features/trader_main_profile/presentation/widgets/trader_payment_info_section.dart';

part 'trader_profile_state.dart';

class TraderProfileCubit extends Cubit<TraderProfileState> {
  TraderProfileCubit() : super(TraderProfileInitial());

  UserProfileModel? _profile;

  // ── تحميل البروفايل من الـ storage ──────────────────────────────────────────

  Future<void> loadProfile() async {
    emit(TraderProfileLoading());
    try {
      final profile = await StorageServices.getUserProfile();
      if (profile == null) {
        emit(TraderProfileError('لم يتم العثور على بيانات المستخدم'));
        return;
      }

      // لو مفيش paymentInfo في الـ profile — نحاول نجيبه من الـ key المنفصل
      if (profile.paymentInfo == null) {
        final savedPayment = await StorageServices.getUserPaymentInfo();
        if (savedPayment != null) {
          _profile = profile.copyWith(paymentInfo: savedPayment);
        } else {
          _profile = profile;
        }
      } else {
        _profile = profile;
      }

      emit(TraderProfileLoaded(profile: _profile!));
    } catch (e) {
      emit(TraderProfileError(e.toString()));
    }
  }

  // ── حفظ طريقة الدفع ─────────────────────────────────────────────────────────

  Future<void> savePaymentInfo(PaymentInfoModel paymentInfo) async {
    if (_profile == null) return;

    emit(TraderProfileSavingPayment());
    try {
      // 1. حفظ في الـ storage
      await StorageServices.saveUserPaymentInfo(paymentInfo);

      // 2. تحديث الـ profile في الـ memory والـ storage
      _profile = _profile!.copyWith(paymentInfo: paymentInfo);
      await StorageServices.saveUserProfile(_profile!);

      emit(TraderProfileLoaded(profile: _profile!));
    } catch (e) {
      emit(TraderProfileError(e.toString()));
    }
  }

  // ── تحديث البروفايل من الـ API ───────────────────────────────────────────────

  Future<void> updateProfile(UserProfileModel newProfile) async {
    try {
      // نحافظ على الـ paymentInfo الموجود لو الـ API مش بيرجعه
      final paymentInfo = _profile?.paymentInfo ?? newProfile.paymentInfo;
      _profile = newProfile.copyWith(paymentInfo: paymentInfo);
      await StorageServices.saveUserProfile(_profile!);
      emit(TraderProfileLoaded(profile: _profile!));
    } catch (e) {
      emit(TraderProfileError(e.toString()));
    }
  }
}