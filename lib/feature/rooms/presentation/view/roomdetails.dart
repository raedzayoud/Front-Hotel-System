import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/core/utils/function/snackbar.dart';
import 'package:hotel/core/utils/function/successsnackbar.dart';
import 'package:hotel/feature/rooms/presentation/manager/room_cubit.dart';
import 'package:hotel/feature/rooms/presentation/manager/room_state.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  dynamic roomDetails;
  DateTime? _selectedDateIn;
  DateTime? _selectedDateOut;
  String? roomImage;

  final TextEditingController _dateControllerIn = TextEditingController();
  final TextEditingController _dateControllerOut = TextEditingController();
  final TextEditingController _nbreofpersonne = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectDateIn(BuildContext context) async {
    final DateTime initial = _selectedDateIn ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDateIn = pickedDate;
        _dateControllerIn.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

        // Si la date Out est avant la nouvelle date In, on la réinitialise
        if (_selectedDateOut != null &&
            _selectedDateOut!.isBefore(pickedDate)) {
          _selectedDateOut = null;
          _dateControllerOut.text = "";
        }
      });
    }
  }

  Future<void> _selectDateOut(BuildContext context) async {
    // Date minimale pour la sortie = date entrée ou aujourd'hui si entrée non définie
    final DateTime minDate = _selectedDateIn ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          _selectedDateOut != null && _selectedDateOut!.isAfter(minDate)
              ? _selectedDateOut!
              : minDate,
      firstDate: minDate,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDateOut = pickedDate;
        _dateControllerOut.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  int _calculateNumberOfNights() {
    if (_selectedDateIn != null && _selectedDateOut != null) {
      return _selectedDateOut!.difference(_selectedDateIn!).inDays;
    }
    return 0;
  }

  int _calculateTotalPrice() {
    final nights = _calculateNumberOfNights();

    final pricePerNight = roomDetails != null ? (roomDetails['price'] ?? 0) : 0;

    // Safely parse number of people (default to 1 if empty or invalid)
    final numberOfPeople = int.tryParse(_nbreofpersonne.text) ?? 1;

    // Multiply and round to nearest integer
    return (nights * numberOfPeople * pricePerNight.toDouble()).round();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && roomDetails == null) {
      roomDetails = args['roomDetails'];
      roomImage = args['image'];
    }
  }

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
          "Room Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: KPrimayColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Room Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                roomImage ?? AssetsImage.room4,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // Hotel Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                roomDetails['name'] ?? "Deluxe Room",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Enjoy a comfortable and elegant stay in our well-equipped rooms, designed to offer you relaxation and convenience with modern amenities and exceptional service.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 20),

            // Amenities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Included Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  Chip(label: Text("Free Breakfast")),
                  Chip(label: Text("Wi-Fi")),
                  Chip(label: Text("Room Service")),
                  Chip(label: Text("Swimming Pool Access")),
                  Chip(label: Text("Sea View")),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.person, color: KPrimayColor, size: 35),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Enter the number of people";
                        }
                      },
                      controller: _nbreofpersonne,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Number of People',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Check in-Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      size: 35,
                      color: KPrimayColor,
                    ),
                    onPressed: () {
                      _selectDateIn(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Select a check-in date";
                        }
                      },
                      controller: _dateControllerIn,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "check in date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onTap: () {
                        _selectDateIn(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Check Out-Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      size: 35,
                      color: KPrimayColor,
                    ),
                    onPressed: () {
                      _selectDateOut(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Select a check-out date";
                        }
                      },
                      controller: _dateControllerOut,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Check Out-Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onTap: () {
                        _selectDateOut(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            // Price and Book Now
            BlocListener<RoomCubit, RoomState>(
              listener: (context, state) {
                if (state is RoomSuccess) {
                  snackbarsuccess(context, "Booking created succesfully");
                } else if (state is RoomFailure) {
                  snackbarerror(context, state.errorMessage);
                }
              },
              child: BlocBuilder<RoomCubit, RoomState>(
                builder: (context, state) {
                  if (state is RoomLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${roomDetails['price']} / night",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (_calculateNumberOfNights() > 0)
                              Text(
                                "Total: \$${_calculateTotalPrice()} (${_calculateNumberOfNights()} nights)",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: KPrimayColor,
                                ),
                              ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<RoomCubit>(context).BookingRoom(
                                  roomDetails['id'].toString(),
                                  _calculateTotalPrice());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KPrimayColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
