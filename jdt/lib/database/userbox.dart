import 'package:hive/hive.dart';

part 'userbox.g.dart';

@HiveType(typeId: 2)
class UserBox {
  UserBox({
    /// General User Information
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  /* ------------------------ General Theme Information ----------------------- */

  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  @HiveField(2)
  bool rememberMe;
}
