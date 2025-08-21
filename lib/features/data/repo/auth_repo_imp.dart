import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';

class AuthRepoImp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  Future<UserModel> login({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user == null) {
        throw Exception("User not found after login.");
      }

      DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();

      if (userData.exists) {
        return UserModel.fromJson({
          ...userData.data() as Map<String, dynamic>,
          'uid': user.uid,
        });
      } else {
        return UserModel(
          name: user.displayName ?? 'Unknown',
          email: user.email ?? '',
          image: user.photoURL,
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    print(" Starting Firebase registration for: $email");

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user == null) {
        print(" User is null after creation");
        throw Exception("User not created.");
      }

      print(" User created with UID: ${user.uid}");

      final userModel = UserModel(
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toJson());
      print(" User saved to Firestore");

      return userModel;
    } on FirebaseAuthException catch (e) {
      print(" FirebaseAuthException: ${e.code} - ${e.message}");
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      print(" Unexpected error: $e");
      throw Exception('Registration failed: $e');
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }

  UserModel? getCurrentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      return UserModel(
        name: user.displayName ?? 'Unknown',
        email: user.email ?? '',
        image: user.photoURL,
      );
    }
    return null;
  }

  Future<void> updateUserName(String newName) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("No user is signed in.");

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'name': newName,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Failed to update name: $e");
    }
  }
  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user is signed in.");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(taskId)
        .update({
      'status': newStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(TaskModel task) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user is signed in.");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(task.id)
        .update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user is signed in.");

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
  Future<void> changePassword(String oldPassword, String newPassword) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("No user is signed in.");

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw Exception('The old password is incorrect.');
      } else if (e.code == 'requires-recent-login') {
        throw Exception('Please log in again to change your password.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<void> updateUserLanguage(String languageCode) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("No user is signed in.");

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'language': languageCode,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Failed to update language: $e");
    }
  }
}