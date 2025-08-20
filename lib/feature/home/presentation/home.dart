import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/feature/home/presentation/manager/home_cubit.dart';
import 'package:hotel/feature/home/presentation/manager/home_state.dart';
import 'package:hotel/feature/rooms/presentation/view/rooms.dart';
import 'package:hotel/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _hotelImages = [
    AssetsImage.hotel1,
    AssetsImage.hotel2,
    AssetsImage.hotel3,
    AssetsImage.hotel4,
    AssetsImage.hotel5,
    AssetsImage.hotel6,
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeCubit = BlocProvider.of<HomeCubit>(context);
      homeCubit.getAllHotels();
      print("========================");
      print(sharedPreferences.getInt("solde"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeFailure || state is SearchFailure) {
            final errorMessage = state is HomeFailure
                ? state.errorMessage
                : (state as SearchFailure).errorMessage;
            return Center(child: Text(errorMessage));
          } else if (state is HomeSuccess || state is SearchSuccess) {
            final hotels = state is HomeSuccess
                ? state.hotels
                : (state as SearchSuccess).hotels;

            return SingleChildScrollView(
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
                            AssetsImage.hotel5,
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
                            onChanged: (value) {
                              if (value.isEmpty) {
                                BlocProvider.of<HomeCubit>(context)
                                    .getAllHotels();
                              }
                            },
                            controller: _searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                              hintText: "Search Hotels",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<HomeCubit>(context)
                                        .searchHotels(_searchController.text);
                                  },
                                  icon: Icon(Icons.search)),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  BlocProvider.of<HomeCubit>(context)
                                      .getAllHotels();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Section Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "The Most Relevant Hotels",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Horizontal Hotel Cards
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotels.length,
                      itemBuilder: (context, index) {
                        final hotel = hotels[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Rooms(idHotel: hotel['id']),
                              ),
                            );
                          },
                          child: _buildHotelCard(
                            imagePath:
                                _hotelImages[index % _hotelImages.length],
                            title: hotel['name'] ?? 'Unknown',
                            location: hotel['location'] ?? 'Tunisia',
                            rating:
                                double.tryParse(hotel['rating'].toString()) ??
                                    0.0,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Section Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Hotels with Available Rooms",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Vertical Cards List
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      return _buildHotelCard(
                        imagePath: _hotelImages[index % _hotelImages.length],
                        title: hotel['name'] ?? 'Unknown',
                        location: hotel['location'] ?? 'Tunisia',
                        rating:
                            double.tryParse(hotel['rating'].toString()) ?? 0.0,
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
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
