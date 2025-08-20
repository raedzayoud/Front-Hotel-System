import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/utils/function/snackbar.dart';
import 'package:hotel/feature/booking/presentation/cubit/booking_cubit.dart';

class Incomingbooking extends StatefulWidget {
  const Incomingbooking({super.key});

  @override
  State<Incomingbooking> createState() => _IncomingbookingState();
}

class _IncomingbookingState extends State<Incomingbooking> {
  @override
  void initState() {
    super.initState();
    // Safely call cubit after widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<bookingCubit>(context).getAllRoomsByUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Incoming and Past Bookings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      // BlocListener + BlocBuilder
      body: BlocListener<bookingCubit, bookingState>(
        listener: (context, state) {
          if (state is bookingFailure) {
            snackbarerror(context, state.errorMessage);
          }
        },
        child: BlocBuilder<bookingCubit, bookingState>(
          builder: (context, state) {
            if (state is bookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is bookingSuccess) {
              if (state.list.isEmpty) {
                return const Center(
                  child: Text("No incoming bookings."),
                );
              }
              return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final booking = state.list[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.hotel, color: Colors.blue),
                      title: Text(
                        booking['hotel_name'] ?? 'Unknown Hotel',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Room: ${booking['room_name'] ?? ''}",
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            }
            // Default fallback (initial, unknown, etc.)
            return const Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}
