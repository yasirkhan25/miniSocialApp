import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sk/ui/screens/auth_screens/signin_screen/signin_screen.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/locator.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/models/base_view_model.dart';
import '../../../../core/services/auth_Services.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../../../core/services/database_services.dart';
import '../../../custom_widgets/custom_snacke_bar.dart';
import '../../home_screen/home_screen.dart';

class SignInProvider extends BaseViewModal {
  final _authService = locator<AuthServices>();
  AppUser appUser = AppUser();
  final databaseServices = DatabaseServices();
  CustomAuthResult customAuthResult = CustomAuthResult();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  ///
  /// Login user ============================================>>>
  ///
  loginToApp(AppUser appUser, BuildContext context) async {

      print("App user email: ${appUser.userEmail}");
      print("App user Password: ${appUser.password}");
      setState(ViewState.busy);

      customAuthResult = await _authService.loginUser(appUser);

      setState(ViewState.idle);

      if (customAuthResult.user != null) {
        print("App user Id: ${_authService.appUser.appUserId}");

        if (_authService.appUser.isFirstLogin == true) {
          Get.off(() => HomeScreen());
        } else if (_authService.appUser.isFirstLogin == false) {
          Get.off(() => SignInScreen());
        }
      } else {
        showSnackBar(
          context,
          "${customAuthResult.errorMessage!}",
          duration: 5000,
        );
      }
    }
  }