import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  const EmojiButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amberAccent.shade100,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Icon(
          Icons.emoji_emotions,
          color: Colors.deepOrange,
          size: 30,
        ),
      ),
    );
  }
}