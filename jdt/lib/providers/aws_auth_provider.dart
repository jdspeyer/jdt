import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/utils/status_enums.dart';

final authAWSRepositoryProvider =
    Provider<AWSAuthRepository>((ref) => AWSAuthRepository());

class AWSAuthRepository {
  /// Used to recover email and password for email verification and automatic sign in.
  /// These variables are protected and will not be used outside of the authentication screens.
  /// They are also wiped on login.
  static String _cachedUsername = "";
  static String _cachedPassword = "";

  /// Gets the user
  Future<AuthUser?> get user async {
    try {
      final awsUser = await Amplify.Auth.getCurrentUser();
      print(awsUser.username);
      return awsUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Creates a new user with the provided [email] and [password]
  Future<CreateStatus> signUp(String email, String password) async {
    try {
      final SignUpOptions options = SignUpOptions(userAttributes: {
        AuthUserAttributeKey.email: email,
      });

      await Amplify.Auth.signUp(
          username: email, password: password, options: options);

      _cachedUsername = email;
      _cachedPassword = password;

      return CreateStatus.success;
    } catch (e) {
      if (e is InvalidPasswordException) {
        return CreateStatus.invalidPasswordError;
      } else {
        print(e);
        return CreateStatus.unknownError;
      }
    }
  }

  Future<LoginStatus> signIn(String email, String password) async {
    try {
      await logout();
    } catch (e) {}
    try {
      SignInResult result =
          await Amplify.Auth.signIn(username: email, password: password);

      print(result);
      if (result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
        _cachedUsername = email;
        _cachedPassword = password;
        return LoginStatus.unconfirmedError;
      }

      if (!result.isSignedIn) {
        return LoginStatus.unknownError;
      }

      return LoginStatus.success;
    } catch (e) {
      print(e);
      if (e is UserNotFoundException) {
        return LoginStatus.accountDoesNotExistError;
      }
      if (e is UserNotConfirmedException) {
        _cachedUsername = email;
        _cachedPassword = password;
        return LoginStatus.unconfirmedError;
      }
      if (e is NotAuthorizedServiceException) {
        return LoginStatus.wrongCredentialsError;
      }
      print(e);
      return LoginStatus.unknownError;
    }
  }

  Future<VerifyStatus> confirmSignUp(String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
          username: _cachedUsername, confirmationCode: confirmationCode);
      await signIn(_cachedUsername, _cachedPassword);
      return VerifyStatus.success;
    } catch (e) {
      return VerifyStatus.incorrect;
    }
  }

  Future<VerifyStatus> resendConfirmSignUpEmail() async {
    try {
      await Amplify.Auth.resendSignUpCode(username: _cachedUsername);
      return VerifyStatus.success;
    } catch (e) {
      return VerifyStatus.incorrect;
    }
  }

  Future<void> logout() async {
    try {
      await Amplify.Auth.signOut();
    } on Exception {
      rethrow;
    }
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
    }
  }

  Future<VerifyStatus> resetPassword(String username) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      _cachedUsername = username;
      return VerifyStatus.success;
    } on Exception catch (e) {
      return VerifyStatus.incorrect;
    }
  }

  Future<ResetPasswordStatus> confirmResetPassword({
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: _cachedUsername,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
      return ResetPasswordStatus.success;
    } on Exception catch (e) {
      if (e is CodeMismatchException) {
        return ResetPasswordStatus.invalidCodeError;
      }
      if (e is InvalidPasswordException) {
        return ResetPasswordStatus.invalidPasswordError;
      }
      if (e is LimitExceededException) {
        return ResetPasswordStatus.limitReachedError;
      }
      print(e);
      return ResetPasswordStatus.unknownError;
    }
  }
}
