import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class Bell extends StatefulWidget {
  const Bell({super.key});

  @override
  State<Bell> createState() => _BellState();
}

class _BellState extends State<Bell> {
  late Future<QuerySnapshot> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('time', descending: true)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(251, 250, 250, 250),
      body: FutureBuilder<QuerySnapshot>(
        future: _notifications,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String title = data['title'] ?? 'From WorkOut';
              String desc = data['desc'] ?? 'Open';

              DateTime createdAt = data['time'].toDate() ?? 'Some days ago';
              String createdAtString =
                  DateFormat('yyyy-MM-dd hh:mm:ss a').format(createdAt);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: ExpansionTile(
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: Text(title),
                    subtitle: Text(
                        maxLines: 1, overflow: TextOverflow.ellipsis, desc),
                    children: [
                      Text(desc),
                      const Divider(),
                      Center(
                        child: Text(createdAtString),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
