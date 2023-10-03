part of intro_view;

enum _MyInputType { username, password }

class _MyIntroTFF extends StatelessWidget {
  const _MyIntroTFF(
      {Key? key,
      required this.myInputType,
      this.isObscure = false,
      this.inputAction,
      this.prefixIcon,
      this.onChange,
      this.onSubmit,
      this.obscureChanged})
      : super(key: key);

  final _MyInputType myInputType;
  final bool isObscure;
  final TextInputAction? inputAction;
  final IconData? prefixIcon;
  final Function? onChange;
  final VoidCallback? onSubmit, obscureChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        obscureText: isObscure,
        keyboardType: getInputType(),
        textInputAction: inputAction,
        cursorColor: MyColors.myBlueShade1,
        inputFormatters: myInputType == _MyInputType.username
            ? [FilteringTextInputFormatter.allow(RegExp(usernameRegex))]
            : null,
        decoration: InputDecoration(
          hintText: getHints(),
          contentPadding: const EdgeInsets.all(8.0),
          prefixIcon: (prefixIcon != null)
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Icon(prefixIcon))
              : null,
          suffixIcon: (obscureChanged != null)
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    icon: Icon(isObscure
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash),
                    onPressed: () => obscureChanged!(),
                  ),
                )
              : null,
          filled: true,
          fillColor: MyColors.c3.withOpacity(0.3),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(color: MyColors.myBlueShade1),
          ),
        ),
        validator: (value) => myValidator(value),
        onChanged: (value) => onChange != null ? onChange!(value) : null,
        onFieldSubmitted: (value) => onSubmit != null ? onSubmit!() : null,
      ),
    );
  }

  TextInputType? getInputType() {
    if (myInputType == _MyInputType.username) {
      return TextInputType.name;
    } else if (myInputType == _MyInputType.password) {
      return TextInputType.visiblePassword;
    }
    return null;
  }

  String? getHints() {
    if (myInputType == _MyInputType.username) {
      return 'Enter Username';
    } else if (myInputType == _MyInputType.password) {
      return 'Enter Password';
    }
    return null;
  }

  String? myValidator(String? value) {
    if (value != null && value.trim().isEmpty) {
      if (myInputType == _MyInputType.username) {
        return 'Username Required';
      } else if (myInputType == _MyInputType.password) {
        return 'Password Required';
      }
    }
    return null;
  }
}
