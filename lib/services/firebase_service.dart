import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/workout.dart';
import '../models/meal.dart';
import '../models/sleep_record.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String get currentUserId => auth.currentUser?.uid ?? '';

  static Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Login failed';
    }
  }

  static Future<String?> register(
      String fullName, String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user?.updateDisplayName(fullName);
      await firestore.collection('users').doc(result.user?.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Registration failed';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<String?> updateUserProfile(Map<String, Object> data) async {
    if (currentUserId.isEmpty) {
      return 'User is not signed in';
    }
    try {
      await firestore.collection('users').doc(currentUserId).update(data);
      if (data.containsKey('fullName')) {
        final displayName = data['fullName'] as String;
        await auth.currentUser?.updateDisplayName(displayName);
      }
      return null;
    } catch (error) {
      return 'Unable to save profile';
    }
  }

  static Stream<DocumentSnapshot> userProfileStream() {
    return firestore.collection('users').doc(currentUserId).snapshots();
  }

  static Future<String?> addWorkout(Workout workout) async {
    try {
      await firestore.collection('workouts').add(workout.toMap());
      return null;
    } catch (error) {
      return 'Failed to save workout';
    }
  }

  static Future<String?> updateWorkout(Workout workout) async {
    try {
      await firestore
          .collection('workouts')
          .doc(workout.id)
          .update(workout.toMap());
      return null;
    } catch (error) {
      return 'Failed to update workout';
    }
  }

  static Future<String?> deleteWorkout(String id) async {
    try {
      await firestore.collection('workouts').doc(id).delete();
      return null;
    } catch (error) {
      return 'Failed to delete workout';
    }
  }

  static Stream<List<Workout>> workoutsStream() {
    return firestore
        .collection('workouts')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Workout.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Stream<int> workoutCountStream() {
    return firestore
        .collection('workouts')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Future<String?> addMeal(Meal meal) async {
    try {
      await firestore.collection('meals').add(meal.toMap());
      return null;
    } catch (error) {
      return 'Failed to save meal';
    }
  }

  static Future<String?> updateMeal(Meal meal) async {
    try {
      await firestore.collection('meals').doc(meal.id).update(meal.toMap());
      return null;
    } catch (error) {
      return 'Failed to update meal';
    }
  }

  static Future<String?> deleteMeal(String id) async {
    try {
      await firestore.collection('meals').doc(id).delete();
      return null;
    } catch (error) {
      return 'Failed to delete meal';
    }
  }

  static Stream<List<Meal>> mealsStream() {
    return firestore
        .collection('meals')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Meal.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Stream<int> mealCountStream() {
    return firestore
        .collection('meals')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Future<String?> addSleep(SleepRecord record) async {
    try {
      await firestore.collection('sleep_records').add(record.toMap());
      return null;
    } catch (error) {
      return 'Failed to save sleep record';
    }
  }

  static Future<String?> updateSleep(SleepRecord record) async {
    try {
      await firestore
          .collection('sleep_records')
          .doc(record.id)
          .update(record.toMap());
      return null;
    } catch (error) {
      return 'Failed to update sleep record';
    }
  }

  static Future<String?> deleteSleep(String id) async {
    try {
      await firestore.collection('sleep_records').doc(id).delete();
      return null;
    } catch (error) {
      return 'Failed to delete sleep record';
    }
  }

  static Stream<List<SleepRecord>> sleepStream() {
    return firestore
        .collection('sleep_records')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('sleepDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SleepRecord.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Stream<int> sleepCountStream() {
    return firestore
        .collection('sleep_records')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // System Settings Methods
  static Future<void> updateSystemSetting(String key, dynamic value) async {
    await firestore.collection('settings').doc('system_config').set({
      key: value,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Stream<DocumentSnapshot> systemSettingsStream() {
    return firestore.collection('settings').doc('system_config').snapshots();
  }

  static Future<bool> isAdmin() async {
    if (currentUserId.isEmpty) return false;
    
    // Check for hardcoded admin email first (consistent with login logic)
    final currentUserEmail = auth.currentUser?.email?.toLowerCase();
    if (currentUserEmail == 'admin@gmail.com') return true;

    try {
      final doc = await firestore.collection('users').doc(currentUserId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['role'] == 'Admin';
      }
    } catch (e) {
      debugPrint('Error checking admin status: $e');
    }
    return false;
  }
}
