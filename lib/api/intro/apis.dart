import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../model/intro_model.dart';

class MyIntroApis {
  Future<ParseError?> userRegistration(UserRegistrationModel model) async {
    ParseUser user = ParseUser(model.username, model.password, null)
      ..set('fullName', model.fullName)
      ..set('gender', model.gender);
    ParseResponse response = await user.signUp(allowWithoutEmail: true);
    return response.error;
  }

  Future<ParseError?> userLogin(String username, String password) async {
    final ParseUser user = ParseUser(username, password, null);
    ParseResponse response = await user.login();
    return response.error;
  }
}
