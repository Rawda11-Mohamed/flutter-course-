import 'package:flutter/material.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Edit Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {},
          ),
        ],
      ),
      body:
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/GettyImages-1315607788 2 (1).png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'In Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Believe you can, and you’re halfway there.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                DropdownButton<String>(
                  value: 'Home',
                  items: <String>['Home', 'Work'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(Icons.home, color: Colors.pink),
                          SizedBox(width: 8),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                SizedBox(height: 16),
                Container(width:double .infinity,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
                  child:Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        'Grocery Shopping App',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),),
                SizedBox(height: 16),
                Container(width:double .infinity,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
                  child:Row(
                    children: [

                      SizedBox(width: 8),
                      Text(
                        'Go for grocery to buy some products. Go for grocery to buy some products. Go for grocery to buy some products. Go for grocery to buy some products.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),),
                SizedBox(height: 16),
                Container(width:double .infinity,
                height: 50,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
                child:Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.calendar_today, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      '30 June, 2022  10:00 pm',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shadowColor: Colors.green,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Mark as Done',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 18,color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}