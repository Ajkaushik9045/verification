// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:verification/components/Navigation/route_names.dart';
import 'package:verification/pages/otp_screen.dart';
import 'package:verification/pages/phoneNumberSelection.dart';
import 'package:verification/pages/profile_selection.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.phoneNuberSelection:
        return MaterialPageRoute(builder: (_) => const PhoneNumberEntryPage());

      case RouteNames.otpVerification:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(
            phoneNumber: args['phoneNumber'] as String,
            verificationId: args['verificationId'] as String,
            pinController: args['pinController'] as TextEditingController,
          ),
        );

      case RouteNames.profileSelection:
        return MaterialPageRoute(builder: (_) => const ProfileSelection());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
