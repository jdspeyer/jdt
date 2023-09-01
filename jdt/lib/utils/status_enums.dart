enum LoginStatus {
  accountDoesNotExistError,
  wrongCredentialsError,
  unknownError,
  unconfirmedError,
  success,
}

enum CreateStatus {
  emailTakenError,
  invalidPasswordError,
  unknownError,
  success,
}

enum VerifyStatus { incorrect, success }
