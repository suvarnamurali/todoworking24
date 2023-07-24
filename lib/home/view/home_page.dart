import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_app/login/login.dart';
import 'package:my_app/myproduct/view/item_page.dart';
import 'package:my_app/profile/product.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference _todoRef;
  late FirebaseStorage _storage;

  @override
  void initState() {
    super.initState();
    _todoRef = _firestore.collection("todo task");
    _storage = FirebaseStorage.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Todo",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProducts()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Product()),
              );
            },
            icon: const Icon(Icons.shop),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginPage()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 42,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'title',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 42,
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'description',
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final time = DateTime.now();
              await _todoRef.add({
                "title": _titleController.text,
                "description": _descriptionController.text,
                "time": time,
                "userid": _auth.currentUser!.uid,
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task added")),
              );

              _titleController.clear();
              _descriptionController.clear();
            },
            child: const Text("Add"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _todoRef
                  .where(
                    'userid',
                    isEqualTo: _auth.currentUser!.uid,
                  )
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final int index = 0;
                    final document = documents[index];

                    return ListTile(
                      title: Text(document['title'] as String),
                      subtitle: Text(document['description'] as String),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final document1 = documents[index];

                              // Set the existing values to the text controllers
                              _titleController.text = document1['title'] as String;
                              _descriptionController.text = document1['description'] as String;

                              return AlertDialog(
                                title: const Text("Edit Task"),
                                content: Column(
                                  children: [
                                    TextField(
                                      controller: _titleController,
                                      decoration: const InputDecoration(
                                        hintText: "Title",
                                      ),
                                    ),
                                    TextField(
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(
                                        hintText: "Description",
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                              .collection("todo task")
                                              .doc(document.id)
                                              .update({
                                                "title": _titleController.text,
                                                "description": _descriptionController.text,
                                              });
                                            _titleController.clear();
                                            _descriptionController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      onLongPress: () async {
                        // Delete the document
                        final docRef = _todoRef.doc(document.id);
                        await docRef.delete();
                      },
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
