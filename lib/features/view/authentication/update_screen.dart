import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/default_form_field.dart';

class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(AppAssets.flag),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: DefaultFormField(controller: TextEditingController(),hintText: 'Username', prefixIcon:Icon(Icons.person)),
          ),
        ],
      ),
    );
  }
}