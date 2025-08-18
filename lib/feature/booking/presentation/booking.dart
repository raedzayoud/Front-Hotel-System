import 'package:flutter/material.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/core/utils/responsive.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    double containerHeight = AppResponsive.heigth(context) * 0.45;
    double containerWidth = AppResponsive.width(context) * 0.45;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Booking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: bookingCard(
                context,
                title: " Your Booking",
                image: AssetsImage.avion,
                onTap: () {
                  Navigator.pushNamed(context, "incomingbooking");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingCard(BuildContext context,
      {required String title,
      required String image,
      required VoidCallback onTap}) {
    double containerHeight = AppResponsive.heigth(context) * 0.45;
    double containerWidth = AppResponsive.width(context) * 0.45;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: Image.asset(
                image,
                width: 90,
                height: 90,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
