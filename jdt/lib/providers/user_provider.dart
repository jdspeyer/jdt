import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jdt/providers/aws_auth_provider.dart';

final authUserProvider = FutureProvider<AuthUser?>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.user.then((value) => value);
});
