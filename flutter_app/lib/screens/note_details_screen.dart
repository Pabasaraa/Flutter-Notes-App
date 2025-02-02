import 'package:flutter/material.dart';
import '../models/note.dart';
import 'add_edit_note_screen.dart';
import '../utils/constants.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Note Details',
              style: kHeadline2,
            ),
            iconTheme: IconThemeData(
              color: kPrimaryTextColor,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: kSecondaryTextColor,
                ),
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: kHeadline1,
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
                style: kNoteBody,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
