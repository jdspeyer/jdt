/* ------------------------------- LoginStatus ------------------------------ */
/// The status returned by various login functions.
/// [LoginStatus.accountDoesNotExistError] -> The account does not exist (user signed in with email not in system).
/// [LoginStatus.wrongCredentialsError] -> The accounts password does not match the one on file for the inputted email.
/// [LoginStatus.unknownError] -> The fallback error.
/// [LoginStatus.unconfirmedError] -> The user has not yet confirmed the email associated with their account.
/// [LoginStatus.success] -> Login successful.
enum LoginStatus {
  accountDoesNotExistError,
  wrongCredentialsError,
  unknownError,
  unconfirmedError,
  success,
}

/* ------------------------------ CreateStatus ------------------------------ */
/// The status returned by various create account functions.
/// [CreateStatus.emailTakenError] -> The email that the user attempted to create an account with already exists.
/// [CreateStatus.invalidPasswordError] -> The password does not meet the minimum requirements of authentication.
/// [CreateStatus.unknownError] -> The fallback error.
/// [CreateStatus.success] -> Create successful.
enum CreateStatus {
  emailTakenError,
  invalidPasswordError,
  unknownError,
  success,
}

/* ------------------------------ VerifyStatus ------------------------------ */
/// The status returned by various verification functions (verify password, email, etc).
/// [VerifyStatus.incorrect] -> Some error occured.
/// [VerifyStatus.success] -> Verification successful.
enum VerifyStatus {
  incorrect,
  success,
}

/* --------------------------- ResetPasswordStatus -------------------------- */
/// The status returned by the reset password function.
/// [ResetPasswordStatus.samePasswordError] -> The same password was set as the previous one.
/// [ResetPasswordStatus.invalidPasswordError] -> The password does not meet the minimum requirements of authentication.
/// [ResetPasswordStatus.invalidCodeError] -> Verification code provided does not match the one sent by email.
/// [ResetPasswordStatus.unknownError] -> The fallback error.
/// [ResetPasswordStatus.limitReachedError] -> The user has attempted to reset their password too many times recently.
/// [ResetPasswordStatus.success] -> Reset successful.
enum ResetPasswordStatus {
  samePasswordError,
  invalidPasswordError,
  invalidCodeError,
  unknownError,
  limitReachedError,
  success,
}

/* ----------------------------- JdtDebugStatus ----------------------------- */
/// The status of debug statements sent to the [JdtDebugger]
/// [JdtDebugStatus.error] -> failed code occured.
/// [JdtDebugStatus.warning] -> error was caught or handled, just giving developer a heads up.
/// [JdtDebugStatus.info] -> Just some helpful information.
/// [JdtDebugStatus.plain] -> Just prints whatever was passed.
enum JdtDebugStatus {
  error,
  warning,
  info,
  plain,
}
