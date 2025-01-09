import 'package:flutter/material.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../screens/note_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: kSecondayBackgroundColor,
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
        title: Text(
          note.title,
          style: kHeadline2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(note.createdAt!),
              style: kBodyText2,
            ),
            Padding(padding: const EdgeInsets.only(top: 6.0)),
            Text(note.content!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kBodyText1),
          ],
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
