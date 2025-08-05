import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/utils/responsive.dart';
import 'package:hotel/feature/wallet/presentation/manager/wallet_cubit.dart';
import 'package:hotel/feature/wallet/presentation/manager/wallet_state.dart';
import 'package:hotel/main.dart';

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
            const Text(
              "Your Wallet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),

            const SizedBox(height: 30),

            /// BlocBuilder to show current balance
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) {
                if (state is WalletLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WalletSuccess) {
                  return Text(
                    "\$${state.solde == 0 ? sharedPreferences.getInt("solde") : state.solde}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  );
                } else if (state is WalletFailure) {
                  return Text(
                    "Error: ${state.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const Text(
                    "\$0",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  );
                }
              },
            ),

            const SizedBox(height: 30),

            /// Add Amount Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [50, 100, 200].map((amount) {
                return MaterialButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  onPressed: () {
                    BlocProvider.of<WalletCubit>(context).addAmount(amount);
                  },
                  color: Colors.blue,
                  child: Text(
                    "\$$amount",
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

            /// Transactions Section
            Container(
              width: double.infinity,
              height: AppResponsive.heigth(context) * 130 / 100,
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
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.monetization_on),
                        title: Text("Transaction #$index"),
                        subtitle: Text("Details of transaction $index"),
                        trailing: const Text("-\$10"),
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
