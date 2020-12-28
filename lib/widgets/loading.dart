import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(64),
                  child: Image.asset("img/ic_foreground.png"),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 128),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator()),
            ),
          ],
        ));
  }
}
