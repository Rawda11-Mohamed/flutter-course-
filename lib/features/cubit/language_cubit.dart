import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LanguageCubit() : super(LanguageInitial());

  static LanguageCubit get(context) => BlocProvider.of<LanguageCubit>(context);

  Future<void> loadLanguageFromUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final langCode = doc.data()?['language'] ?? 'en';
      emit(LanguageLoaded(languageCode: langCode));
    } on Exception catch (e) {
      emit(LanguageError(e.toString()));
    }
  }

  Future<void> changeLanguage(String newCode) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'language': newCode,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      emit(LanguageLoaded(languageCode: newCode));
    } on Exception catch (e) {
      emit(LanguageError(e.toString()));
    }
  }
}