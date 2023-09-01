import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/utils/status_enums.dart';

final authAWSRepositoryProvider =
    Provider<AWSAuthRepository>((ref) => AWSAuthRepository());

class AWSAuthRepository {
  /// Gets the user
  Future<AuthUser?> get user async {
    try {
      final awsUser = await Amplify.Auth.getCurrentUser();
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
      await signIn(email, password);

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
      await Amplify.Auth.signOut();
    } catch (e) {
      safePrint('Signed out');
    }

    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: email, password: password);
      if (res.isSignedIn) {
        return LoginStatus.success;
      } else {
        print(res.nextStep);
        return LoginStatus.unknownError;
      }
    } catch (e) {
      print(e);
      if (e is UserNotFoundException) {
        return LoginStatus.accountDoesNotExistError;
      }

      if (e is UserNotConfirmedException) {
        return LoginStatus.unconfirmedError;
      } else {
        print(e);
        return LoginStatus.unknownError;
      }
    }
  }

  Future<VerifyStatus> confirmSignUp(
      String email, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationCode);
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
}
