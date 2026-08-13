import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/Autehntication/ForgotPassword/ForgotPassword.dart';
import 'package:web_app/Autehntication/Invitation/Invitation.dart';
import 'package:web_app/Autehntication/Login/LoginScreen.dart';
import 'package:web_app/Autehntication/ResetPassword/ResetPassword.dart';
import 'package:web_app/Autehntication/SignUp/SignUpScreen.dart';
import 'package:web_app/Resources/ErrorPage.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    errorBuilder: (BuildContext context, GoRouterState state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/resetPassword',
        builder: (context, state) => const ResetPassword(),
      ),
      GoRoute(
        path: '/invitation',
        builder: (context, state) => const InvitationScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),

    ],
  );
}