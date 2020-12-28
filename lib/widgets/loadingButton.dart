import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tcc/mobx/screenController.dart';

class LoadingButton extends StatelessWidget {
  final String text;

  LoadingButton(this.text);

  @override
  Widget build(BuildContext context) {
    final screenController = Provider.of<ScreenController>(context);
    return Observer(builder: (_) {
      if (screenController.isLoading) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  LinearProgressIndicator(backgroundColor: Colors.deepPurple)),
        );
      } else {
        return Text(text, style: TextStyle(fontWeight: FontWeight.bold));
      }
    });
  }
}
