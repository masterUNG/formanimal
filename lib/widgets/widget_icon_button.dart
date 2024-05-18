// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.type,
  }) : super(key: key);

  final IconData icon;
  final Function() onPressed;
  final GFButtonType? type;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      type: type ?? GFButtonType.transparent,
      color: Theme.of(context).primaryColor,
    );
  }
}
