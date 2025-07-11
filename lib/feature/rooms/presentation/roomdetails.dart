import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';
import 'package:hotel/core/utils/assets.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  DateTime? _selectedDateIn;
  DateTime? _selectedDateOut;

  final TextEditingController _dateControllerIn = TextEditingController();
  final TextEditingController _dateControllerOut = TextEditingController();

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
      body: ListView(
        children: [
          // Room Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              AssetsImage.hotel2,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          // Hotel Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              "Beach Resort - Deluxe Room",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              "Enjoy your stay in our luxurious deluxe room with a sea view. The room includes a king-sized bed, air conditioning, a flat-screen TV, free Wi-Fi, and a minibar.",
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
                    controller: _dateControllerIn,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date de naissance",
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
                    controller: _dateControllerOut,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date de naissance",
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
            height: 30,
          ),
          // Price and Book Now
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "\$120 / night",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KPrimayColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Go to booking screen
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
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
