import 'package:flutter/material.dart';

class SimonButton extends StatefulWidget {
  final Color bgColor;
  final Function onPress;
  final bool canPlay;
  final bool pressed;

  SimonButton({Key key, this.bgColor, this.onPress, this.canPlay, this.pressed})
      : super(key: key);

  @override
  _SimonButtonState createState() => _SimonButtonState();
}

class _SimonButtonState extends State<SimonButton> {
  Color color;

  @override
  void initState() {
    color = widget.bgColor;
    super.initState();
  }

  onPress() async {
    if (!widget.canPlay) return;
    setState(() {
      color = Colors.black87;
    });

    widget.onPress();
    await sleep();

    setState(() {
      color = widget.bgColor;
    });
  }

  Future sleep() {
    return new Future.delayed(const Duration(milliseconds: 300), () => "1");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.blue,
      focusColor: Colors.red,
      splashColor: Colors.purple,
      highlightColor: Colors.white,
      child: Container(
        child: Container(
          width: 100,
          height: 100,
          color: widget.pressed ? Colors.white : color,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      onTap: onPress,
    );
  }
}
