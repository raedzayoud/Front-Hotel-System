import 'package:flutter/material.dart';
import 'package:hotel/main.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // Profile section
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  sharedPreferences.getString("name") ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  sharedPreferences.getString("email") ?? "",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Settings options
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Naviguer vers la sélection de langue
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Ouvrir les paramètres de notification
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Theme"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Passer au mode sombre ou clair
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help & Support"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Ouvrir la page d’aide
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: () {
              sharedPreferences.clear();
              tokenSharedPreferences.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, "login", (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
