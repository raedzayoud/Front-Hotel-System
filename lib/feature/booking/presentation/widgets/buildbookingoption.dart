
  import 'package:flutter/material.dart';
import 'package:hotel/core/utils/responsive.dart';

Widget buildBookingOption(BuildContext context,
      {required String imagePath, required String label}) {
    return Container(
      height: AppResponsive.heigth(context) * 0.4,
      width: AppResponsive.width(context) * 0.4,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              scale: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
