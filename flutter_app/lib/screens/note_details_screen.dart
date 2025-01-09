import 'package:flutter/material.dart';
import '../models/note.dart';
import 'add_edit_note_screen.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditNoteScreen(note: note),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              if (note.imageUrl != null && note.imageUrl!.isNotEmpty)
                Center(
                  child: Image.network(
                    note.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 100),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                note.content!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
