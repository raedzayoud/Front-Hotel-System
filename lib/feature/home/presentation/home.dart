import 'package:flutter/material.dart';
import 'package:hotel/core/utils/assets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // ✅ Scrollable page
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Banner
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Image.asset(
                      AssetsImage.hotel1,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    top: 40,
                    child: Text(
                      "Hi Raed, where do you want to go?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black54,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        hintText: "Search Hotels",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Horizontal Hotels
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "The Most Relevant Hotels",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildHotelCard(
                      imagePath: AssetsImage.hotel2,
                      title: "Beach Resort",
                      location: "Hammamet, Tunisia",
                      rating: 4.5,
                    ),
                    _buildHotelCard(
                      imagePath: AssetsImage.hotel2,
                      title: "Mountain View",
                      location: "Aïn Draham, Tunisia",
                      rating: 4.0,
                    ),
                    _buildHotelCard(
                      imagePath: AssetsImage.hotel2,
                      title: "City Hotel",
                      location: "Tunis Centre",
                      rating: 3.5,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Vertical Hotel List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Hotels with Available Rooms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Column instead of ListView
            Column(
              children: [
                _buildHotelCard(
                  imagePath: AssetsImage.hotel2,
                  title: "Beach Resort",
                  location: "Hammamet, Tunisia",
                  rating: 4.5,
                ),
                _buildHotelCard(
                  imagePath: AssetsImage.hotel2,
                  title: "Mountain View",
                  location: "Aïn Draham, Tunisia",
                  rating: 4.0,
                ),
                _buildHotelCard(
                  imagePath: AssetsImage.hotel2,
                  title: "City Hotel",
                  location: "Tunis Centre",
                  rating: 3.5,
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelCard({
    required String imagePath,
    required String title,
    required String location,
    required double rating,
  }) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      location,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    rating.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.star, size: 16, color: Colors.yellow),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
