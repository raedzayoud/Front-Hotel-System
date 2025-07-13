import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/core/utils/responsive.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Center(
              child: Container(
                height: AppResponsive.heigth(context) * .4,
                width: AppResponsive.width(context) * .8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    AssetsImage.wallet,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your Wallet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 30),
            const Text(
              "\$0",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [50, 100, 200].map((amount) {
                return MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  onPressed: () {},
                  color: Colors.blue,
                  child: Text(
                    "$amount",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              height: 50,
              minWidth: AppResponsive.width(context) * .9,
              color: Colors.black,
              onPressed: () {},
              child: const Text(
                "Add Money",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: AppResponsive.heigth(context) * .8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Your Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: List.generate(
                        20,
                        (index) => ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text("Transaction #$index"),
                          subtitle: Text("Details of transaction $index"),
                          trailing: const Text("-\$10"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
