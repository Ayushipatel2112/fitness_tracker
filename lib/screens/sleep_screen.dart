import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SleepScreen extends StatefulWidget {
  final bool isAdminView;
  const SleepScreen({super.key, this.isAdminView = false});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bedTimeController = TextEditingController();
  final TextEditingController _wakeTimeController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final CollectionReference _sleep = FirebaseFirestore.instance.collection('sleep');

  void _addSleep() {
    if (_dateController.text.isEmpty || _hoursController.text.isEmpty) return;

    _sleep.add({
      'sleepDate': _dateController.text,
      'bedTime': _bedTimeController.text,
      'wakeTime': _wakeTimeController.text,
      'hoursSlept': _hoursController.text,
      'sleepQuality': _qualityController.text,
      'notes': _notesController.text,
      'uid': FirebaseAuth.instance.currentUser?.uid ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value) => {});
    
    _clearFields();
  }

  void _clearFields() {
    _dateController.clear();
    _bedTimeController.clear();
    _wakeTimeController.clear();
    _hoursController.clear();
    _qualityController.clear();
    _notesController.clear();
  }

  void _editSleep(String id, Map<String, dynamic> data) {
    _dateController.text = data['sleepDate'] ?? '';
    _bedTimeController.text = data['bedTime'] ?? '';
    _wakeTimeController.text = data['wakeTime'] ?? '';
    _hoursController.text = data['hoursSlept'] ?? '';
    _qualityController.text = data['sleepQuality'] ?? '';
    _notesController.text = data['notes'] ?? '';

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Edit Sleep Record', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField(_dateController, 'Sleep Date'),
                const SizedBox(height: 10),
                _buildDialogField(_bedTimeController, 'Bed Time'),
                const SizedBox(height: 10),
                _buildDialogField(_wakeTimeController, 'Wake Time'),
                const SizedBox(height: 10),
                _buildDialogField(_hoursController, 'Hours Slept'),
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
                backgroundColor: const Color(0xFF92A3FD),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                _sleep.doc(id).update({
                  'sleepDate': _dateController.text,
                  'bedTime': _bedTimeController.text,
                  'wakeTime': _wakeTimeController.text,
                  'hoursSlept': _hoursController.text,
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
        title: Text('Sleep Tracker', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
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
                  color: const Color(0xFF92A3FD).withOpacity(isDark ? 0.05 : 0.1),
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
                flex: 5,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: const Color(0xFF92A3FD).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Log Night Sleep', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildPremiumTextField(_dateController, 'Sleep Date * (dd/mm/yyyy)'),
                        Row(
                          children: [
                            Expanded(child: _buildPremiumTextField(_bedTimeController, 'Bed Time *')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_wakeTimeController, 'Wake Time *')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildPremiumTextField(_hoursController, 'Hours Slept *')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildPremiumTextField(_qualityController, 'Quality (1-10)')),
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
                            onPressed: _addSleep,
                            child: const Text('Save Record', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Align(alignment: Alignment.centerLeft, child: Text('Sleep History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor))),
              ),
              Expanded(
                flex: 4,
                child: StreamBuilder(
                  stream: widget.isAdminView
                    ? _sleep.orderBy('createdAt', descending: true).snapshots()
                    : _sleep.where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFF92A3FD)));
                    
                    var docs = snapshot.data!.docs.toList();
                    if (!widget.isAdminView) {
                      docs.sort((a, b) {
                        Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
                        Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp.now();
                        return t2.compareTo(t1);
                      });
                    }
    
                    if (docs.isEmpty) return Center(child: Text("No sleep records yet.", style: TextStyle(color: isDark ? Colors.white70 : Colors.grey)));
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        var data = doc.data() as Map<String, dynamic>;
                        return Dismissible(
                          key: Key(doc.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) => _sleep.doc(doc.id).delete(),
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
                                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF92A3FD).withOpacity(0.2)),
                                child: const Icon(Icons.bedtime, color: Color(0xFF92A3FD)),
                              ),
                              title: Text(data['sleepDate'] ?? 'Unknown Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                              subtitle: Text("${data['hoursSlept']} hrs | Quality: ${data['sleepQuality']}/10", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              trailing: IconButton(icon: const Icon(Icons.edit_outlined, color: Color(0xFF92A3FD)), onPressed: () => _editSleep(doc.id, data)),
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
