import 'package:flutter/material.dart';
import 'package:hotel/feature/booking/presentation/booking.dart';
import 'package:hotel/feature/home/presentation/home.dart';
import 'package:hotel/feature/home/presentation/widget/Bottomnavigatorhome.dart';
import 'package:hotel/feature/settings/presentation/settings.dart';
import 'package:hotel/feature/wallet/presentation/wallet.dart';

class Homescrrenview extends StatefulWidget {
  const Homescrrenview({super.key});

  @override
  State<Homescrrenview> createState() => _HomescrrenviewState();
}

class _HomescrrenviewState extends State<Homescrrenview> {
   onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  int _page = 0;

  List<Widget> pages = [
    Home(),
    Booking(),
    Wallet(),
   Settings()
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: Bottomnavigatorhome(
          page: _page,
          onTap: onPageChanged,
        ));
  }
}