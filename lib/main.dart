// main
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; // File hasil generate

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _showForm(BuildContext context, [DocumentSnapshot? documentSnapshot]) {
    // Jika sedang Edit, isi controller dengan data lama
    if (documentSnapshot != null) {
      _titleController.text = documentSnapshot['title'];
      _contentController.text = documentSnapshot['content'];
    } else {
      // Jika Tambah Baru, pastikan controller kosong
      _titleController.text = '';
      _contentController.text = '';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
  child: SingleChildScrollView(
    child: Padding(

        padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Isi Catatan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String title = _titleController.text;
                final String content = _contentController.text;

                if (content.isNotEmpty) {
                  if (documentSnapshot == null) {
                    // KODE TAMBAH BARU
                    await _notes.add({
                      "title": title,
                      "content": content,
                      "timestamp": FieldValue.serverTimestamp(),
                    });
                  } else {
                    // KODE UPDATE (SESUAI TANTANGAN)
                    await _notes.doc(documentSnapshot.id).update({
                      "title": title,
                      "content": content,
                      "timestamp": FieldValue.serverTimestamp(), // Optional: update timestamp
                    });
                  }

                  // Bersihkan Input & Tutup Modal
                  _titleController.clear();
                  _contentController.clear();
                  Navigator.of(context).pop();
                }
              },
              // Label tombol menyesuaikan mode Tambah atau Edit
              child: Text(documentSnapshot == null ? "Simpan Catatan" : "Perbarui Catatan"),
            )
          ],
        ),
      ),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Notes Fire")),

      // STREAMBUILDER : Bagian terpenting untuk Real - time
      body: StreamBuilder(
        stream: _notes.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Kondisi 1: Masih Loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Kondisi 2: Data Kosong
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada catatan."));
          }

          // Kondisi 3: Ada Data -> Tampilkan ListView
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  // TAMBAHKAN ONTAP DI SINI UNTUK FITUR EDIT
                  onTap: () => _showForm(context, document),
                  title: Text(document['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(document['content']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Fungsi Hapus
                      _notes.doc(document.id).delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Panggil _showForm tanpa parameter (mode Tambah Baru)
        onPressed: () => _showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}