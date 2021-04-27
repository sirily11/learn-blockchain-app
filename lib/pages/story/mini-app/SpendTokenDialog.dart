import 'package:flutter/material.dart';

class SpendTokenDialog extends StatefulWidget {
  final double amout;
  final bool mint;
  final double? balence;

  SpendTokenDialog({required this.amout, required this.mint, this.balence});

  @override
  _SpendTokenDialogState createState() => _SpendTokenDialogState();
}

class _SpendTokenDialogState extends State<SpendTokenDialog> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done_rounded,
              size: 100,
              color: Colors.green,
            ),
            Text(
              "You ${widget.mint ? "mint" : "spent"} ${widget.amout.toStringAsFixed(1)} tokens",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.balence != null)
              Text(
                "Your balence: ${widget.balence!.toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
