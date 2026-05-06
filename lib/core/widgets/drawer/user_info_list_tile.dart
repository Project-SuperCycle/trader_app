import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trader_app/core/helpers/custom_loading_indicator.dart';
import 'package:trader_app/core/routes/end_points.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/core/utils/app_assets.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:trader_app/features/home/data/managers/profile_cubit/profile_cubit.dart';
import 'package:trader_app/features/sign_in/data/models/logined_user_model.dart';

class UserInfoListTile extends StatefulWidget {
  const UserInfoListTile({super.key});

  @override
  State<UserInfoListTile> createState() => _UserInfoListTileState();
}

class _UserInfoListTileState extends State<UserInfoListTile> {
  String userName = '';
  String businessType = '';
  bool isLoading = true;
  String logoUrl = '';

  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginUserModel? user = await StorageServices.getUserData();
    setState(() {
      if (user != null) {
        isUserLoggedIn = true;
        if (user.role == "representative") {
          userName = user.displayName ?? '';
          businessType = "مندوب";
        } else {
          userName = user.doshMangerName ?? '';
          businessType = user.rawBusinessType ?? '';
        }
        logoUrl = user.logoUrl ?? '';
      }
      isLoading = false;
    });
  }

  void _handleProfileTap() async {
    if (isUserLoggedIn) {
      GoRouter.of(context).push(EndPoints.traderPreProfileView);
      BlocProvider.of<ProfileCubit>(context).fetchUserProfile(context: context);
    } else {
      context.push(EndPoints.signInView);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Card(
        color: const Color(0xFFFAFAFA),
        elevation: 0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomLoadingIndicator(),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: const Color(0xFFFAFAFA),
        elevation: 0,
        child: Center(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: _handleProfileTap,
                  child: (logoUrl.isEmpty)
                      ? ClipOval(
                          child: Image.asset(
                            AppAssets.defaultAvatar,
                            fit: BoxFit.fill,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(logoUrl, fit: BoxFit.fill),
                        ),
                ),
              ),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(userName, style: AppStyles.styleSemiBold16(context)),
            ),
            subtitle: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                businessType,
                style: AppStyles.styleRegular12(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
