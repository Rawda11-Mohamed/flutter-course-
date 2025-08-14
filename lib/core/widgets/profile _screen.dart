// lib/features/profile/authentication/profile_screen.dart
import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppAssets.flag),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello!', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text(
                        "Ahmed Saber",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Option(
                icon: Icons.person_outline,
                text: 'Profile',
                onTap: () {
                  Navigator.pushNamed(context, '/updateName');
                },
              ),
              Option(
                icon: Icons.lock_outline,
                text: 'Change Password',
                onTap: () {
                  Navigator.pushNamed(context, '/changePassword');
                },
              ),
              Option(
                icon: Icons.settings_outlined,
                text: 'Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/language');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const Option({super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 20),
            Expanded(
              child: Text(text, style: const TextStyle(fontSize: 16)),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}