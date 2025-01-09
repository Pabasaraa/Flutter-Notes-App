import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../utils/image_picker_util.dart';
import '../widgets/custom_text_field.dart';
import '../utils/constants.dart';

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
  File? imageFile;

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
      String imageUrl = _imageUrl ?? '';

      if (imageFile != null) {
        imageUrl = await ImagePickerUtil.uploadImageToBackend(imageFile!);
      }

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
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  final imageF =
                      await ImagePickerUtil.pickImage(ImageSource.gallery);
                  if (imageF != null && mounted) {
                    setState(() {
                      imageFile = imageF;
                    });
                  }
                  if (!context.mounted) return;

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  final imageF =
                      await ImagePickerUtil.pickImage(ImageSource.camera);
                  if (imageF != null && mounted) {
                    setState(() {
                      imageFile = imageF;
                    });
                  }
                  if (!context.mounted) return;

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          widget.note == null ? 'Add Note' : 'Edit Note',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kPrimaryTextColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: kPrimaryTextColor,
        ),
        actions: [
          IconButton(
            color: kPrimaryTextColor,
            icon: const Icon(Icons.save),
            onPressed: saveNote,
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
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
                if (imageFile != null)
                  Center(
                    child: Column(
                      children: [
                        Image.file(
                          imageFile!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              imageFile = null;
                            });
                          },
                          child: const Text('Remove Image'),
                        ),
                      ],
                    ),
                  )
                else if (_imageUrl != null)
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
