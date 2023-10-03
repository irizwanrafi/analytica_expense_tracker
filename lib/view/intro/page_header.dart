part of intro_view;

class _MyPageHeader extends StatelessWidget {
  const _MyPageHeader({Key? key, required this.logoString}) : super(key: key);
  final String logoString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: context.isLandscape
                  ? const AssetImage('assets/images/landscape.png')
                  : const AssetImage('assets/images/portrait.png'),
              fit: BoxFit.fill),
        ),
        child: Center(
            child: context.isLandscape
                ? Container(
                    margin: EdgeInsets.only(right: (context.width * 0.05)),
                    width: rfIsMinHeight(context)
                        ? rfMinHeight * 0.3
                        : context.height * 0.3,
                    height: rfIsMinHeight(context)
                        ? rfMinHeight * 0.3
                        : context.height * 0.3,
                    decoration: logoBoxDecoration,
                    child: logoString == ''
                        ? const SizedBox.shrink()
                        : Image(image: AssetImage(logoString)))
                : Container(
                    margin: EdgeInsets.only(bottom: (context.height * 0.05)),
                    width: rfIsMinWidth(context)
                        ? rfMinWidth * 0.3
                        : context.width * 0.3,
                    height: rfIsMinWidth(context)
                        ? rfMinWidth * 0.3
                        : context.width * 0.3,
                    decoration: logoBoxDecoration,
                    child: logoString == ''
                        ? const SizedBox.shrink()
                        : Image(image: AssetImage(logoString)))),
      ),
    );
  }
}
