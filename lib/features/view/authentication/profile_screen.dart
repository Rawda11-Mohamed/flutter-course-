import 'package:flutter/material.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/widgets/option_item.dart';
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
                      Text("Ahmed Saber", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              OptionItem(
                icon: Icons.person_outline,
                text: 'Profile',
                onTap: () => Navigator.pushNamed(context, '/updateName'),
              ),
              OptionItem(
                icon: Icons.lock_outline,
                text: 'Change Password',
                onTap: () => Navigator.pushNamed(context, '/changePassword'),
              ),
              OptionItem(
                icon: Icons.settings_outlined,
                text: 'Settings',
                onTap: () => Navigator.pushNamed(context, '/language'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}