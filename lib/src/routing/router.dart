// imprting necessary packages and files
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volun_tek/src/features/authentication/presentation/controller/reset_password_controller.dart';
import 'package:volun_tek/src/features/authentication/presentation/widget/confirm_email.dart';
import 'package:volun_tek/src/features/authentication/presentation/widget/interest.dart';
import 'package:volun_tek/src/features/authentication/presentation/widget/reset_password.dart';
import 'package:volun_tek/src/features/authentication/presentation/widget/sign_up.dart';
import 'package:volun_tek/src/features/home/presentation/widget/bottom_navigation.dart';
import 'package:volun_tek/src/features/home/presentation/widget/home.dart';
import 'package:volun_tek/src/features/home/presentation/widget/opportunity_view.dart';
import 'package:volun_tek/src/features/profile/presentation/widget/favorite.dart';
import 'package:volun_tek/src/utils/validation_helper.dart';

import '../../logging_state.dart';
import '../features/authentication/presentation/controller/sign_in_controller.dart';
import '../features/authentication/presentation/controller/sign_up_controller.dart';
import '../features/authentication/presentation/widget/login.dart';
import '../features/authentication/presentation/widget/onboarding.dart';
import '../features/home/presentation/controller/interest_form_controller.dart';
import '../features/home/presentation/widget/interest_form.dart';
import '../features/home/presentation/widget/notification_view.dart';
import '../features/profile/presentation/controller/user_controller.dart';
import '../features/profile/presentation/widget/edit_profile.dart';
import '../features/profile/presentation/widget/history.dart';
import '../features/profile/presentation/widget/profile.dart';
import '../features/search/presentation/widget/search.dart';
import 'routes.dart';

// Class to generate routes based on route settings
class RouteGenerator {
  Route? routeGenerate(RouteSettings route) {
    switch (route.name) {
      // Route for the splash screen
      case splashRoot:
        return navigateToRoute(
          const Onboarding(),
        );
      // Route for the interest page
      case interest:
        return navigateToRoute(const InterestPage());
      // Route for the login page
      case login:
        return navigateToRoute(
          Login(
            validationHelper: ValidationHelper(),
            controller: SignInController(),
          ),
        );
      // Route for the sign-up page
      case signup:
        return navigateToRoute(
          SignUp(
            validationHelper: ValidationHelper(),
            controller: SignUpController(),
          ),
        );
      // Route for the email confirmation page
      case confirmMail:
        return navigateToRoute(const ConfirmMail());
      // Route for password reset page
      case resetPassword:
        return navigateToRoute(
          ResetPassword(
            validationHelper: ValidationHelper(),
            controller: ResetPasswordController(),
          ),
        );
      // Route for the bottom navigation bar
      case bottomNavigation:
        return navigateToRoute(const BottomNavigation());
      case home:
        return navigateToRoute(const Home());
      case loggingState:
        return navigateToRoute(const LoggingState());
      case search:
        return navigateToRoute(const Search());
      case opportunityView:
        return navigateToRoute(const OpportunityView());
      case interestForm:
        return navigateToRoute(
          InterestForm(
            validation: ValidationHelper(),
            controller: InterestFormController(),
          ),
        );
      // Route for the profile page
      case profile:
        return navigateToRoute(const Profile());
      case editProfile:
        return navigateToRoute(EditProfile(
          validation: ValidationHelper(),
          controller: UserController(),
        ));
      case favourite:
        return navigateToRoute(const Favourite());
      case history:
        return navigateToRoute(const History());
      case notification:
        return navigateToRoute(const NotificationView());
    }
    return null;
  }
}

// Function to navigate to a route based on the platform
navigateToRoute(Widget page) {
  if (Platform.isAndroid) {
    return MaterialPageRoute(builder: (context) => page);
  }

  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (context) => page);
  }
}
