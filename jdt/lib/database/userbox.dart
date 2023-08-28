import 'package:hive/hive.dart';

part 'userbox.g.dart';

@HiveType(typeId: 2)
class UserBox {
  UserBox({
    /// General User Information
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.shareEmail,
    required this.phoneNumber,
    required this.sharePhoneNumber,
    required this.allowNotifications,
    required this.hasEditedFirstName,
    required this.hasEditedLastName,
    required this.hasEditedEmail,
    required this.hasEditedPhoneNumber,
    required this.hasEditedToggleSettings,
    required this.hasFinishedProfileSetup,
  });

  /* ------------------------ General Theme Information ----------------------- */
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String email;

  @HiveField(3)
  bool shareEmail;

  @HiveField(4)
  int phoneNumber;

  @HiveField(5)
  bool sharePhoneNumber;

  @HiveField(6)
  bool allowNotifications;

  @HiveField(7)
  bool hasEditedFirstName;
  @HiveField(8)
  bool hasEditedLastName;
  @HiveField(9)
  bool hasEditedEmail;
  @HiveField(10)
  bool hasEditedPhoneNumber;
  @HiveField(11)
  bool hasEditedToggleSettings;
  @HiveField(12)
  bool hasFinishedProfileSetup;
}
