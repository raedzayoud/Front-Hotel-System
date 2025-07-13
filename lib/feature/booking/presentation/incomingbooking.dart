import 'package:flutter/material.dart';

class Incomingbooking extends StatelessWidget {
  const Incomingbooking({super.key});

  // Mock booking data
  final List<Map<String, String>> bookings = const [
    {
      "hotelName": "Hotel Paris",
      "roomName": "Deluxe Room",
      "date": "2025-07-15"
    },
    {
      "hotelName": "Sunset Resort",
      "roomName": "Sea View Suite",
      "date": "2025-07-20"
    },
    {
      "hotelName": "Mountain Lodge",
      "roomName": "Standard Room",
      "date": "2025-08-01"
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          "Incoming Bookings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListTile(
              leading: const Icon(Icons.hotel, color: Colors.blue),
              title: Text(
                booking['hotelName'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Room: ${booking['roomName']}\nDate: ${booking['date']}"),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
