import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvmproject/core/utils/app_paddings.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final langCode = doc.data()?['language'] ?? 'en';
      setState(() {
        _selectedLanguage = langCode;
      });
    }
  }

  Future<void> _saveLanguage(String code) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'language': code,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      setState(() {
        _selectedLanguage = code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: AppPaddings.defaultHomePadding,
        child: Column(
          children: [
            ListTile(
              title: const Text("Language"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _saveLanguage('ar'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _selectedLanguage == 'ar' ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'AR',
                        style: TextStyle(
                          color: _selectedLanguage == 'ar' ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _saveLanguage('en'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _selectedLanguage == 'en' ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'EN',
                        style: TextStyle(
                          color: _selectedLanguage == 'en' ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}