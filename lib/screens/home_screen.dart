import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/GettyImages-1315607788 2 (1).png', // غيريها حسب مكان الصورة
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello!',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text(
                        'Ahmed Saber',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your today’s tasks almost done!",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text("80%",
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text(
                        "View Tasks",
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // In Progress
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("In Progress",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.green,
                    child: Text(
                      "5",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildTaskCard("Work Task", "Add New Features",
                        color: Colors.black),
                    buildTaskCard("Personal Task", "Improve English skills",
                        color: Colors.green[100]!, textColor: Colors.black),
                    buildTaskCard(
                      "Home Task",
                      "Add new feature for Do It app and commit it",
                      color: Colors.pink[100]!,
                      textColor: Colors.black,
                      iconColor: Colors.pink,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text("Task Groups",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const SizedBox(height: 16),

              buildGroupItem(Icons.person, "Personal Task", Colors.green, "5"),
              buildGroupItem(Icons.home, "Home Task", Colors.pink, "3"),
              buildGroupItem(Icons.work, "Work Task", Colors.black, ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaskCard(String title, String subtitle,
      {required Color color,
        Color textColor = Colors.white,
        Color iconColor = Colors.white}) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: textColor)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(Icons.lock, color: iconColor, size: 18),
          )
        ],
      ),
    );
  }

  Widget buildGroupItem(
      IconData icon, String title, Color color, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          if (count.isNotEmpty)
            CircleAvatar(
              backgroundColor: Colors.green[100],
              radius: 12,
              child: Text(count,
                  style: const TextStyle(fontSize: 12, color: Colors.green)),
            )
        ],
      ),
    );
  }
}
