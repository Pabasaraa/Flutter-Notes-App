import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_list_item.dart';
import 'add_edit_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: noteProvider.fetchNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Consumer<NoteProvider>(
              builder: (context, noteProvider, child) {
                final notes = noteProvider.notes;
                if (notes.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notes yet. Tap the "+" button to create one!',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: NoteListItem(note: note),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
