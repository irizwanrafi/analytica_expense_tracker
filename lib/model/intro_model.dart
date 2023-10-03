class IntroPageModel {
  final String logoString;
  final String titleString;
  final String descriptionString;
  final bool? isLoginPage;

  IntroPageModel({
    required this.logoString,
    required this.titleString,
    required this.descriptionString,
    this.isLoginPage,
  });
}

class UserRegistrationModel {
  UserRegistrationModel(
      {required this.username,
      required this.fullName,
      required this.gender,
      required this.password});
  final String username, fullName, gender, password;
}
