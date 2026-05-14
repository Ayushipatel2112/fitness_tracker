import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminManageContactsScreen extends StatefulWidget {
  const AdminManageContactsScreen({super.key});

  @override
  State<AdminManageContactsScreen> createState() => _AdminManageContactsScreenState();
}

class _AdminManageContactsScreenState extends State<AdminManageContactsScreen> {
  final CollectionReference _contacts = FirebaseFirestore.instance.collection('contact_messages');

  void _markAsRead(String docId) async {
    await _contacts.doc(docId).update({'status': 'Read'});
  }

  void _deleteMessage(String docId) async {
    await _contacts.doc(docId).delete();
  }

  void _viewMessage(Map<String, dynamic> data, String docId) {
    if (data['status'] == 'Unread') {
      _markAsRead(docId);
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(data['subject'] ?? 'No Subject', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${data['name']} (${data['email']})', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 15),
            Text(data['message'] ?? ''),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F8),
      appBar: AppBar(
        title: const Text('Contact Messages', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF92A3FD),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Messages', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF92A3FD))),
                SizedBox(height: 5),
                Text('View and manage messages from the contact form', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _contacts.orderBy('createdAt', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                if (snapshot.data!.docs.isEmpty) return const Center(child: Text('No messages yet.'));

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var data = doc.data() as Map<String, dynamic>;
                    bool isUnread = data['status'] == 'Unread';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xFF92A3FD),
                                  child: Text((data['name'] ?? 'U')[0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data['name'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text(data['email'] ?? '', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: isUnread ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    isUnread ? 'Unread' : 'Read',
                                    style: TextStyle(color: isUnread ? Colors.red : Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('SUBJECT', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                                      Text(data['subject'] ?? 'No Subject', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('MESSAGE', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                                      Text(data['message'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF92A3FD)),
                                  onPressed: () => _viewMessage(data, doc.id),
                                  child: const Text('View', style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(width: 10),
                                if (isUnread)
                                  OutlinedButton(
                                    onPressed: () => _markAsRead(doc.id),
                                    child: const Text('Mark Read'),
                                  ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () => _deleteMessage(doc.id),
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            )
                          ],
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
    );
  }
}
