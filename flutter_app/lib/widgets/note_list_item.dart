import 'package:flutter/material.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../screens/note_details_screen.dart';
import 'package:provider/provider.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[200],
      child: ListTile(
        leading: note.imageUrl != null && note.imageUrl!.isNotEmpty
            ? Image.network(
                note.imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 50),
              )
            : const Icon(Icons.note, size: 50),
        title: Text(note.title),
        subtitle: Text(
          note.content!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (String result) {
            if (result == 'delete') {
              Provider.of<NoteProvider>(context, listen: false)
                  .deleteNote(note.id!);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailsScreen(note: note),
            ),
          );
        },
      ),
    );
  }
}
