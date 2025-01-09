import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../utils/image_picker_util.dart';
import '../widgets/custom_text_field.dart'; // Import the custom widget

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  AddEditNoteScreenState createState() => AddEditNoteScreenState();
}

class AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content!;
      _imageUrl = widget.note!.imageUrl;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();
      final imageUrl = _imageUrl ?? '';

      final note = widget.note == null
          ? Note(title: title, content: content, imageUrl: imageUrl)
          : widget.note!.copyWith(
              title: title,
              content: content,
              imageUrl: imageUrl,
            );

      final noteProvider = Provider.of<NoteProvider>(context, listen: false);
      try {
        if (widget.note == null) {
          await noteProvider.addNote(note);
        } else {
          await noteProvider.updateNote(note);
        }
        if (mounted) {
          Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final imageUrl = await ImagePickerUtil.pickAndUploadImage();
    if (imageUrl != null && mounted) {
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _titleController,
                  labelText: 'Title',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Title is required'
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _contentController,
                  labelText: 'Content',
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                if (_imageUrl != null)
                  Center(
                    child: Column(
                      children: [
                        Image.network(
                          _imageUrl!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Change Image'),
                        ),
                      ],
                    ),
                  )
                else
                  Center(
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Add Image'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
