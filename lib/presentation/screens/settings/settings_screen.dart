import 'package:budgetcap/config/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            ListTile(
              onTap: () => context.go("/settings/accounts"),
              title: Text('Manage Accounts'),
              leading: Icon(Icons.wallet_membership),
            ),
            ListTile(
              onTap: () {},
              title: Text('Edit profile'),
              leading: Icon(Icons.person_2_outlined),
            )
          ]),
        )));
  }
}
