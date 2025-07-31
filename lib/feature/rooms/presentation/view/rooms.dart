import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/feature/rooms/presentation/manager/room_cubit.dart';
import 'package:hotel/feature/rooms/presentation/manager/room_state.dart';

class Rooms extends StatefulWidget {
  final int idHotel;
  const Rooms({super.key, required this.idHotel});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoomCubit>(context).getAllRooms(widget.idHotel.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
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
      body: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is RoomSuccess) {
            final roomList = state.rooms;

            if (roomList.isEmpty) {
              return const Center(child: Text("No rooms available."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: roomList.length,
              itemBuilder: (context, index) {
                final room = roomList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: room['image'] != null
                            ? Image.network(
                                room['image'],
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 160,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Icon(Icons.image_not_supported)),
                              ),
                      ),
                      // Text info
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room['name'] ?? 'Room Title',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              room['description'] ?? 'No description.',
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
            );
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
