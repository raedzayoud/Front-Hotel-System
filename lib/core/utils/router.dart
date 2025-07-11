import 'package:flutter/material.dart';
import 'package:hotel/feature/authentication/presentation/view/login_view.dart';
import 'package:hotel/feature/authentication/presentation/view/register_view.dart';
import 'package:hotel/feature/home/presentation/home.dart';
import 'package:hotel/feature/home/presentation/homescrren.dart';
import 'package:hotel/feature/rooms/presentation/roomdetails.dart';
import 'package:hotel/feature/rooms/presentation/rooms.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> pageRoutes = {
    "register": (context) => const RegisterView(),
    "login": (context) => const LoginView(),
    "home": (context) => const Home(),
    "Homescrrenview": (context) => const Homescrrenview(),
    "Rooms": (context) => const Rooms(),
    "roomdetails":(context)=>const RoomDetails()
  };
}
