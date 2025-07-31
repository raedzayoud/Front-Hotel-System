import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';
import 'package:hotel/core/utils/assets.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemple de liste de chambres
    final List<Map<String, dynamic>> roomList = [
      {
        'image': "${AssetsImage.hotel2}",
        'title': 'Deluxe Room',
        'description': 'King bed, sea view, breakfast included',
        'price': 120,
      },
      {
        'image': "${AssetsImage.hotel3}",
        'title': 'Standard Room',
        'description': 'Queen bed, city view, free Wi-Fi',
        'price': 90,
      },
      {
        'image': "${AssetsImage.hotel4}",
        'title': 'Suite',
        'description': 'King bed, balcony, living room',
        'price': 180,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          'Rooms',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: KPrimayColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          final room = roomList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    height: 100,
                    child: Image.asset(
                      room['image'],
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Text info
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room['title'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        room['description'],
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "roomdetails");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: KPrimayColor,
                            ),
                            child: const Text(
                              "Book Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
