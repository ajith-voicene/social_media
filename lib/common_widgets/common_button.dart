import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color, textColor;
  final TextStyle textStyle;

  CommonButton({
    this.label,
    Key key,
    this.onPressed,
    this.color = Colors.cyan,
    this.textColor = Colors.white,
    this.textStyle,
  }) : super(key: key);

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
        onPrimary: textColor,
        textStyle: textStyle,
        primary: color,
        elevation: 0,
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle,
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          label,
        ),
      ),
    );
  }
}

class CommonButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color, textColor;
  final TextStyle textStyle;

  const CommonButtonCustom({
    this.child,
    Key key,
    this.onPressed,
    this.color = Colors.cyan,
    this.textColor = Colors.white,
    this.textStyle,
  }) : super(key: key);

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
        onPrimary: textColor,
        textStyle: textStyle,
        primary: color,
        elevation: 0,
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle,
      onPressed: onPressed,
      child: FittedBox(child: child),
    );
  }
}
