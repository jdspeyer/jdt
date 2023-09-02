import 'package:jdt/database/data_manager.dart';

class JdtUser {
  JdtUser({
    this.firstName = "",
    this.lastName = "",
    required this.email,
    this.shareEmail = false,
    this.phoneNumber = 0,
    this.sharePhoneNumber = false,
    this.allowNotifications = false,
    this.hasEditedFirstName = false,
    this.hasEditedLastName = false,
    this.hasEditedEmail = false,
    this.hasEditedPhoneNumber = false,
    this.hasEditedToggleSettings = false,
    this.hasFinishedProfileSetup = false,
    required this.password,
    required this.rememberMe,
  });

  String firstName;
  String lastName;
  String email;
  bool shareEmail;
  int phoneNumber;
  bool sharePhoneNumber;
  bool allowNotifications;

  bool hasEditedFirstName;
  bool hasEditedLastName;
  bool hasEditedEmail;
  bool hasEditedPhoneNumber;
  bool hasEditedToggleSettings;
  bool hasFinishedProfileSetup;
  bool rememberMe;
  String password;

  double getProfileEditCompletion() {
    double completionAmount = 0.0;

    /// Edited First Name Completion Amount
    if (hasEditedFirstName) {
      completionAmount += 0.15;
    }

    /// Edited Last Name Completion Amount
    if (hasEditedLastName) {
      completionAmount += 0.15;
    }

    /// Edited Email Completion Amount
    if (hasEditedEmail) {
      completionAmount += 0.25;
    }

    /// Edited Email Completion Amount
    if (hasEditedPhoneNumber) {
      completionAmount += 0.25;
    }

    /// Edited Toggle Settings Amount
    if (hasEditedToggleSettings) {
      completionAmount += 0.20;
    }

    return completionAmount;
  }

  setFirstName(String val) {
    DataManager manager = DataManager();
    hasEditedFirstName = true;
    firstName = val;
    manager.saveUserToStorage(this);
  }

  setLastName(String val) {
    DataManager manager = DataManager();
    hasEditedLastName = true;
    lastName = val;
    manager.saveUserToStorage(this);
  }

  setEmail(String val) {
    DataManager manager = DataManager();
    hasEditedEmail = true;
    email = val;
    manager.saveUserToStorage(this);
  }

  setPhoneNumber(String val) {
    DataManager manager = DataManager();
    hasEditedPhoneNumber = true;
    phoneNumber = int.parse(val);
    manager.saveUserToStorage(this);
  }

  setProfileCompletion() {
    DataManager manager = DataManager();
    hasFinishedProfileSetup = true;
    manager.saveUserToStorage(this);
  }
}
