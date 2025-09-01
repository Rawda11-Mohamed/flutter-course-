import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../models/user_model.dart';
import '../models/task_model.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class AuthRepoImp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  // =================== LOGIN ===================
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return left(Failure("User not found after login."));
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        return right(UserModel.fromJson(doc.data() as Map<String, dynamic>));
      } else {
        return right(UserModel(
          name: user.displayName ?? 'Unknown',
          email: user.email ?? '',
          image: user.photoURL,
        ));
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? "Auth error"));
    } catch (e) {
      return left(Failure('Login failed: $e'));
    }
  }

  // =================== REGISTER ===================
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return left(Failure("User not created."));

      final userModel = UserModel(
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure('The account already exists for that email.'));
      } else {
        return left(Failure(e.message ?? "Auth error"));
      }
    } catch (e) {
      return left(Failure('Registration failed: $e'));
    }
  }

  // =================== SIGN OUT ===================
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _auth.signOut();
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to sign out: $e"));
    }
  }

  // =================== CURRENT USER ===================
  Either<Failure, UserModel?> getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return right(UserModel(
          name: user.displayName ?? 'Unknown',
          email: user.email ?? '',
          image: user.photoURL,
        ));
      }
      return right(null);
    } catch (e) {
      return left(Failure("Failed to get current user: $e"));
    }
  }

  // =================== UPDATE USER NAME ===================
  Future<Either<Failure, Unit>> updateUserName(String newName) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'name': newName,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to update name: $e"));
    }
  }

  // =================== UPDATE TASK STATUS ===================
  Future<Either<Failure, Unit>> updateTaskStatus(
      String taskId, String newStatus) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(taskId)
          .update({
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to update task status: $e"));
    }
  }

  // =================== UPDATE TASK ===================
  Future<Either<Failure, Unit>> updateTask(TaskModel task) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(task.id)
          .update(task.toJson());
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to update task: $e"));
    }
  }

  // =================== DELETE TASK ===================
  Future<Either<Failure, Unit>> deleteTask(String taskId) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to delete task: $e"));
    }
  }

  // =================== CHANGE PASSWORD ===================
  Future<Either<Failure, Unit>> changePassword(
      String oldPassword, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return left(Failure('The old password is incorrect.'));
      } else if (e.code == 'requires-recent-login') {
        return left(Failure('Please log in again to change your password.'));
      } else {
        return left(Failure(e.message ?? "Password change error"));
      }
    } catch (e) {
      return left(Failure('Failed to change password: $e'));
    }
  }

  // =================== UPDATE LANGUAGE ===================
  Future<Either<Failure, Unit>> updateUserLanguage(String languageCode) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'language': languageCode,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to update language: $e"));
    }
  }

  // =================== ADD TASK ===================
  Future<Either<Failure, Unit>> addTask(TaskModel task) async {
    final user = _auth.currentUser;
    if (user == null) return left(Failure("No user is signed in."));

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(task.id)
          .set(task.toJson());
      return right(unit);
    } catch (e) {
      return left(Failure("Failed to add task: $e"));
    }
  }
}
