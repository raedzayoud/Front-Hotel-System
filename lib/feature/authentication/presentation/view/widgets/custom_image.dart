import 'package:flutter/material.dart';
import 'package:hotel/core/utils/responsive.dart';

class CustomImage extends StatelessWidget {
  final String url;
  const CustomImage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppResponsive.heigth(context)*0.7,
      child: SizedBox(
          height: AppResponsive.heigth(context)*0.25, child: Center(child: Image.asset(url))),
    );
  }
}