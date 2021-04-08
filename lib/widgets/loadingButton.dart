import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String label;
  final Function onPressed;

  LoadingButton({@required this.label, @required this.onPressed});

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Visibility(
        visible: !isLoading,
        child:
            Text(widget.label, style: TextStyle(fontWeight: FontWeight.bold)),
        replacement: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  LinearProgressIndicator(backgroundColor: Colors.deepPurple)),
        ),
      ),
      onPressed: widget.onPressed == null
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              await widget.onPressed();
              setState(() {
                isLoading = false;
              });
            },
    );
  }
}
