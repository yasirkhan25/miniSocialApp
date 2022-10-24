class AuthExceptionsMessages {
  static generateExceptionMessage(e) {
    print('Error: ${e.code}');
    String errorMessage;
    switch (e.code) {
      case "network-request-failed":
        errorMessage = "Please check your internet connection";
        break;
      case "email-already-in-use":
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "wrong-password":
        errorMessage = "You entered wrong password.";
        break;
      case "invalid-email":
        errorMessage = "Please enter valid email.";
        break;
      case "empty-field":
        errorMessage = "Please Provide All The Required Details";
        break;
      default:
        errorMessage = "An undefined Error happened.";
        break;
    }
    return errorMessage;
  }
}
