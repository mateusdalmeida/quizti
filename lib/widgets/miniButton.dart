import 'package:flutter/material.dart';

class MiniButton extends MaterialButton {
  MiniButton(String title, {@required Function onPressed, double minWidth})
      : super(
          child: Text(title),
          elevation: 0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          padding: const EdgeInsets.all(16),
          minWidth: minWidth,
          onPressed: onPressed,
        );
}
