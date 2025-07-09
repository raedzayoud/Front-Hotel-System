import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      subtitle: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
