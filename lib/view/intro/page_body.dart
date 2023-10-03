part of intro_view;

class _MyPageBody extends StatelessWidget {
  const _MyPageBody(
      {Key? key,
      required this.titleStr,
      required this.descriptionStr,
      this.isLoginPage})
      : super(key: key);
  final String titleStr, descriptionStr;
  final bool? isLoginPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(titleStr,
                        style: const TextStyle(
                            color: MyColors.c6,
                            fontSize: 48.0,
                            fontFamily: 'Monoton'))),
                FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(descriptionStr,
                        style: const TextStyle(
                            wordSpacing: 3,
                            letterSpacing: 1,
                            color: MyColors.myBlueShade1,
                            fontSize: 24.0,
                            fontFamily: 'Dancing Script'))),
                if (isLoginPage != null && isLoginPage == true) ...[
                  Form(
                    key: _introController.getFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: <Widget>[
                          _MyIntroTFF(
                            myInputType: _MyInputType.username,
                            inputAction: TextInputAction.next,
                            prefixIcon: Icons.person,
                            onChange: (v) => _introController.setUsername =
                                v.toString().trim(),
                          ),
                          Obx(() => _MyIntroTFF(
                              myInputType: _MyInputType.password,
                              inputAction: TextInputAction.done,
                              prefixIcon: Icons.lock,
                              isObscure: _introController.getIsObscure,
                              onChange: (v) => _introController.setPassword =
                                  v.toString().trim(),
                              obscureChanged: () =>
                                  _introController.setIsObscure(),
                              onSubmit: () => _introController.forwardAct(
                                    _introController
                                        .getScaffoldKey.currentContext,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  const Text('OR'),
                  const SizedBox(height: 8.0),
                  MySimpleButton(
                    boldTitle: true,
                    buttonColor: Colors.green,
                    title: 'Create New Account',
                    onTap: () => _userRegistration(context),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
