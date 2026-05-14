import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class WorkoutsScreen extends StatefulWidget {
  final bool isAdminView;
  const WorkoutsScreen({super.key, this.isAdminView = false});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final CollectionReference _workouts = FirebaseFirestore.instance.collection('workouts');

  void _addWorkout() {
    if (_nameController.text.isEmpty || _durationController.text.isEmpty) return;

    _workouts.add({
      'exerciseName': _nameController.text,
      'type': _typeController.text,
      'description': _descController.text,
      'duration': _durationController.text,
      'caloriesBurned': _caloriesController.text,
      'date': _dateController.text,
      'sets': _setsController.text,
      'reps': _repsController.text,
      'weight': _weightController.text,
      'notes': _notesController.text,
      'uid': FirebaseAuth.instance.currentUser?.uid ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value) => {});
    
    _clearFields();
  }

  void _clearFields() {
    _nameController.clear();
    _typeController.clear();
    _descController.clear();
    _durationController.clear();
    _caloriesController.clear();
    _dateController.clear();
    _setsController.clear();
    _repsController.clear();
    _weightController.clear();
    _notesController.clear();
  }

  void _editWorkout(String id, Map<String, dynamic> data) {
    _nameController.text = data['exerciseName'] ?? '';
    _typeController.text = data['type'] ?? '';
    _descController.text = data['description'] ?? '';
    _durationController.text = data['duration'] ?? '';
    _caloriesController.text = data['caloriesBurned'] ?? '';
    _dateController.text = data['date'] ?? '';
    _setsController.text = data['sets'] ?? '';
    _repsController.text = data['reps'] ?? '';
    _weightController.text = data['weight'] ?? '';
    _notesController.text = data['notes'] ?? '';

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Edit Workout', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField(_nameController, 'Exercise Name'),
                const SizedBox(height: 10),
                _buildDialogField(_typeController, 'Type (e.g. Strength)'),
                const SizedBox(height: 10),
                _buildDialogField(_durationController, 'Duration (mins)'),
                const SizedBox(height: 10),
                _buildDialogField(_dateController, 'Date'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearFields();
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9DCEFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                _workouts.doc(id).update({
                  'exerciseName': _nameController.text,
                  'type': _typeController.text,
                  'duration': _durationController.text,
                  'date': _dateController.text,
                }).then((value) => {});
                _clearFields();
                Navigator.of(context).pop();
              },
              child: const Text('Update', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      });
  }

  Widget _buildDialogField(TextEditingController controller, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: isDark ? Colors.white10 : Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildPremiumTextField(TextEditingController controller, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text('Workout Tracker', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Shapes
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFF9DCEFF).withOpacity(isDark ? 0.05 : 0.1),
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  color: const Color(0xFFC58BF2).withOpacity(isDark ? 0.03 : 0.05),
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: const Color(0xFF9DCEFF).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Log New Workout', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildPremiumTextField(_nameController, 'Exercise Name *'),
                        _buildPremiumTextField(_typeController, 'Type * (e.g. Strength)'),
                        _buildPremiumTextField(_descController, 'Description'),
                        Row(
                          children: [
                            Expanded(child: _buildPremiumTextField(_durationController, 'Duration *')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_caloriesController, 'Calories')),
                          ],
                        ),
                        _buildPremiumTextField(_dateController, 'Date * (dd/mm/yyyy)'),
                        Row(
                          children: [
                            Expanded(child: _buildPremiumTextField(_setsController, 'Sets')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_repsController, 'Reps')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_weightController, 'Weight')),
                          ],
                        ),
                        _buildPremiumTextField(_notesController, 'Notes'),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF92A3FD),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 0,
                            ),
                            onPressed: _addWorkout,
                            child: const Text('Save Workout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Align(alignment: Alignment.centerLeft, child: Text('Workout History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor))),
              ),
              Expanded(
                flex: 4,
                child: StreamBuilder(
                  stream: widget.isAdminView 
                    ? _workouts.orderBy('createdAt', descending: true).snapshots()
                    : _workouts.where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFF9DCEFF)));
                    
                    var docs = snapshot.data!.docs.toList();
                    if (!widget.isAdminView) {
                      docs.sort((a, b) {
                        Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
                        Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
                        return t2.compareTo(t1);
                      });
                    }
    
                    if (docs.isEmpty) return Center(child: Text("No workouts yet.", style: TextStyle(color: isDark ? Colors.white70 : Colors.grey)));
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        var data = doc.data() as Map<String, dynamic>;
                        return Dismissible(
                          key: Key(doc.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) => _workouts.doc(doc.id).delete(),
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete_outline, color: Colors.red),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10)],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              leading: Container(
                                width: 50, height: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFC58BF2).withOpacity(0.2)),
                                child: const Icon(Icons.fitness_center, color: Color(0xFFC58BF2)),
                              ),
                              title: Text(data['exerciseName'] ?? 'Unnamed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                              subtitle: Text("${data['type']} | ${data['duration']} mins", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              trailing: IconButton(icon: const Icon(Icons.edit_outlined, color: Color(0xFF9DCEFF)), onPressed: () => _editWorkout(doc.id, data)),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
