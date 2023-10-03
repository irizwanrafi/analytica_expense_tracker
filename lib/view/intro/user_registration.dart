part of intro_view;

void _userRegistration(BuildContext context) async {
  showDialog(
    context: context,
    builder: (bContext) => const _MyUserRegistration(),
  );
}

class _MyUserRegistration extends StatefulWidget {
  const _MyUserRegistration();

  @override
  State<_MyUserRegistration> createState() => _MyUserRegistrationState();
}

class _MyUserRegistrationState extends State<_MyUserRegistration> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _username,
      _fullName,
      _gender,
      _password,
      _confirmPassword;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _username = TextEditingController();
    _fullName = TextEditingController();
    _gender = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyGeneralDialog(
      width: 300,
      title: 'Registration',
      bodyWidget: Form(
        key: _formKey,
        child: Column(
          children: context.isLandscape
              ? [
                  _usernameWidget(),
                  Row(
                    children: [
                      Expanded(child: _fullNameWidget()),
                      Expanded(child: _genderWidget()),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _passwordWidget()),
                      Expanded(child: _confirmPasswordWidget()),
                    ],
                  ),
                ]
              : [
                  _usernameWidget(),
                  _fullNameWidget(),
                  _genderWidget(),
                  _passwordWidget(),
                  _confirmPasswordWidget(),
                ],
        ),
      ),
      onRedTap: () => Navigator.pop(context),
      greenText: 'Sign Up',
      onGreenTap: () async {
        if (_formKey.currentState!.validate()) {
          if (_password.text == _confirmPassword.text) {
            Navigator.pop(context);
            showMyLoadingDialog(context);
            ParseError? response = await _introController.userRegistration(
                UserRegistrationModel(
                    username: _username.text.trim(),
                    fullName: _fullName.text.trim(),
                    gender: _gender.text.trim(),
                    password: _password.text.trim()));
            if (context.mounted) {
              if (response == null) {
                Navigator.pop(context);
                Get.to(() => const MyHomeScreen());
              } else {
                showMyParseErrorDialog(context, response);
              }
            }
          } else {
            showMyMessageSnackbar('Error 125', 'Password did\'nt matched');
          }
          // showMyLoadingDialog(context);
          // ParseError? error = await userLogin(_username, _password);
          // if (context.mounted) {
          //   Navigator.pop(context);
          //   error == null
          //       ? Get.to(() => const MyDashboardScreen())
          //       : showMyParseErrorDialog(context, error);
          // }
        }
      },
    );
  }

  Widget _usernameWidget() {
    return MyGeneralTFF(
      label: 'Username',
      regularExpression: usernameRegex,
      controller: _username,
    );
  }

  Widget _fullNameWidget() {
    return MyGeneralTFF(
      label: 'Full Name',
      regularExpression: fullNameRegex,
      controller: _fullName,
    );
  }

  Widget _passwordWidget() {
    return MyGeneralTFF(
      label: 'Password',
      controller: _password,
    );
  }

  Widget _confirmPasswordWidget() {
    return MyGeneralTFF(
      label: 'Confirm Password',
      controller: _confirmPassword,
    );
  }

  Widget _genderWidget() {
    return MyDropdownTFF(
      search: false,
      label: 'Gender',
      items: genders,
      onChanged: (String value) => _gender.text = value,
    );
  }
}
