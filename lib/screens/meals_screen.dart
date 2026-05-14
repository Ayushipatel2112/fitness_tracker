import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MealsScreen extends StatefulWidget {
  final bool isAdminView;
  const MealsScreen({super.key, this.isAdminView = false});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final CollectionReference _meals = FirebaseFirestore.instance.collection('meals');

  void _addMeal() {
    if (_nameController.text.isEmpty || _caloriesController.text.isEmpty) return;

    _meals.add({
      'mealName': _nameController.text,
      'mealType': _typeController.text,
      'calories': _caloriesController.text,
      'protein': _proteinController.text,
      'carbs': _carbsController.text,
      'fat': _fatController.text,
      'dateTime': _dateController.text,
      'notes': _notesController.text,
      'uid': FirebaseAuth.instance.currentUser?.uid ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value) => {});
    
    _clearFields();
  }

  void _clearFields() {
    _nameController.clear();
    _typeController.clear();
    _caloriesController.clear();
    _proteinController.clear();
    _carbsController.clear();
    _fatController.clear();
    _dateController.clear();
    _notesController.clear();
  }

  void _editMeal(String id, Map<String, dynamic> data) {
    _nameController.text = data['mealName'] ?? '';
    _typeController.text = data['mealType'] ?? '';
    _caloriesController.text = data['calories'] ?? '';
    _proteinController.text = data['protein'] ?? '';
    _carbsController.text = data['carbs'] ?? '';
    _fatController.text = data['fat'] ?? '';
    _dateController.text = data['dateTime'] ?? '';
    _notesController.text = data['notes'] ?? '';

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Edit Meal', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField(_nameController, 'Meal Name'),
                const SizedBox(height: 10),
                _buildDialogField(_typeController, 'Meal Type'),
                const SizedBox(height: 10),
                _buildDialogField(_caloriesController, 'Calories'),
                const SizedBox(height: 10),
                _buildDialogField(_dateController, 'Date & Time'),
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
                backgroundColor: const Color(0xFFC58BF2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                _meals.doc(id).update({
                  'mealName': _nameController.text,
                  'mealType': _typeController.text,
                  'calories': _caloriesController.text,
                  'dateTime': _dateController.text,
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
        title: Text('Meal Tracker', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
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
                  color: const Color(0xFFEEA4CE).withOpacity(isDark ? 0.05 : 0.1),
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
                      gradient: const LinearGradient(colors: [Color(0xFFEEA4CE), Color(0xFFC58BF2)]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: const Color(0xFFEEA4CE).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Log New Meal', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildPremiumTextField(_nameController, 'Meal Name *'),
                        _buildPremiumTextField(_typeController, 'Meal Type (e.g. Lunch)'),
                        Row(
                          children: [
                            Expanded(child: _buildPremiumTextField(_caloriesController, 'Calories *')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_proteinController, 'Protein (g)')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildPremiumTextField(_carbsController, 'Carbs (g)')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_fatController, 'Fat (g)')),
                          ],
                        ),
                        _buildPremiumTextField(_dateController, 'Date & Time *'),
                        _buildPremiumTextField(_notesController, 'Notes'),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFFC58BF2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 0,
                            ),
                            onPressed: _addMeal,
                            child: const Text('Save Meal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Align(alignment: Alignment.centerLeft, child: Text('Meal History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor))),
              ),
              Expanded(
                flex: 4,
                child: StreamBuilder(
                  stream: widget.isAdminView
                    ? _meals.orderBy('createdAt', descending: true).snapshots()
                    : _meals.where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC58BF2)));
                    
                    var docs = snapshot.data!.docs.toList();
                    if (!widget.isAdminView) {
                      docs.sort((a, b) {
                        Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
                        Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
                        return t2.compareTo(t1);
                      });
                    }
    
                    if (docs.isEmpty) return Center(child: Text("No meals logged yet.", style: TextStyle(color: isDark ? Colors.white70 : Colors.grey)));
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        var data = doc.data() as Map<String, dynamic>;
                        return Dismissible(
                          key: Key(doc.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) => _meals.doc(doc.id).delete(),
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
                                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFEEA4CE).withOpacity(0.2)),
                                child: const Icon(Icons.restaurant, color: Color(0xFFEEA4CE)),
                              ),
                              title: Text(data['mealName'] ?? 'Unnamed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                              subtitle: Text("${data['mealType']} | ${data['calories']} kCal", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              trailing: IconButton(icon: const Icon(Icons.edit_outlined, color: Color(0xFFC58BF2)), onPressed: () => _editMeal(doc.id, data)),
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
