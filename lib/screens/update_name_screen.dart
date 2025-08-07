import 'package:flutter/material.dart';

class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage('assets/images/GettyImages-1315607788 2 (1).png'),
          ),
          SizedBox(height: 20),
          Padding(padding:EdgeInsets.all(20),child:TextField(
            decoration: InputDecoration(
              hintText: 'Username',

              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

            ),
          ),)
        ],
      ),
    );
  }
}
