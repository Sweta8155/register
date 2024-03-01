import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? savedEmail;

  @override
  initState() {
    super.initState();
    retrieveEmail();
  }

  Future<void> retrieveEmail() async {
    final SharedPreferences savedData = await SharedPreferences.getInstance();
    savedEmail = savedData.getString('email');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(child: Text("${savedEmail ?? ''}")),
    );
  }
}