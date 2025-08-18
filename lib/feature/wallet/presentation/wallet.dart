import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/feature/home/presentation/manager/home_cubit.dart';
import 'package:hotel/feature/wallet/presentation/manager/wallet_cubit.dart';
import 'package:hotel/feature/wallet/presentation/manager/wallet_state.dart';
import 'package:hotel/main.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await BlocProvider.of<HomeCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Your Wallet",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 30),

                /// Wallet Balance Card
                BlocBuilder<WalletCubit, WalletState>(
                  builder: (context, state) {
                    if (state is WalletLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is WalletSuccess) {
                      return _walletCard(state.solde ??
                          sharedPreferences.getInt("solde")! ??
                          0);
                    } else if (state is WalletFailure) {
                      return Text(
                        "Error: ${state.errorMessage}",
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      return _walletCard(0);
                    }
                  },
                ),

                const SizedBox(height: 40),

                /// Add Amount Buttons
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick Add",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [50, 100, 200].map((amount) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                                color: Colors.blueAccent, width: 1.5),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                        onPressed: () {
                          BlocProvider.of<WalletCubit>(context)
                              .addAmount(amount);
                        },
                        icon: const Icon(Icons.add_circle, size: 22),
                        label: Text(
                          "\$$amount",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Wallet Card with Gradient
  Widget _walletCard(int balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.account_balance_wallet,
              size: 40, color: Colors.white),
          const SizedBox(height: 10),
          const Text(
            "Balance",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Text(
            "\$$balance",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
