import 'package:flutter/material.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/core/utils/responsive.dart';
import 'package:hotel/feature/booking/presentation/widgets/buildbookingoption.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    double containerHeight = AppResponsive.heigth(context) * 0.4;
    double containerWidth = AppResponsive.width(context) * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Booking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 29,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildBookingOption(
                  context,
                  imagePath: AssetsImage.avion,
                  label: 'Incoming Booking',
                ),
                buildBookingOption(
                  context,
                  imagePath: AssetsImage.past,
                  label: 'Past Booking',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
