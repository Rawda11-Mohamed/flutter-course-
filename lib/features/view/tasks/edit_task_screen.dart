import 'package:flutter/material.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';


class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppAssets.flag),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('In Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text('Believe you can, and you’re halfway there.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            DropdownButton<String>(
              value: 'Home',
              items: ['Home', 'Work'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(Icons.home, color: Colors.pink),
                      const SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  SizedBox(width: 8),
                  Text('Grocery Shopping App', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Go for grocery to buy some products.',
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  SizedBox(width: 8),
                  Icon(Icons.calendar_today, color: Colors.green),
                  SizedBox(width: 8),
                  Text('30 June, 2022  10:00 pm', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            DefaultBtn(
              text: 'Mark as Done',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                side: const BorderSide(color: Colors.green),
              ),
              child: const Text("Update", style: TextStyle(fontSize: 18, color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}