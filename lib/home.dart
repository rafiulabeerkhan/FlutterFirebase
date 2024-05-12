import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/Service/firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyWidgetState();
}

final FireStoreService fs = FireStoreService();
final TextEditingController txc = TextEditingController();

class _MyWidgetState extends State<MyHomePage> {
  void openNoteBox(String? docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: txc,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docId == null) {
                fs.addNote(txc.text);
              } else {
                fs.updateNode(docId, txc.text);
              }
              txc.clear();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 126, 198, 216),
        title: const Text(
          "FireBase!!",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => openNoteBox(null), child: const Icon(Icons.add)),
      body: StreamBuilder<QuerySnapshot>(
        stream: fs.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = noteList[index];
                String docId = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => openNoteBox(docId),
                        icon: const Icon(Icons.update),
                      ),
                      IconButton(
                        onPressed: () {
                          fs.deleteNode(docId);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
