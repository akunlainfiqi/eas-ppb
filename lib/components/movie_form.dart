import 'package:flutter/material.dart';

class MovieForm extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? description;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onImageUrlChanged;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onSavedPressed;

  const MovieForm({
    super.key,
    this.title,
    this.imageUrl,
    this.description,
    required this.onTitleChanged,
    required this.onImageUrlChanged,
    required this.onDescriptionChanged,
    required this.onSavedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            initialValue: title,
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: onTitleChanged,
          ),
          TextFormField(
            initialValue: imageUrl,
            decoration: const InputDecoration(labelText: 'Image URL'),
            onChanged: onImageUrlChanged,
          ),
          TextFormField(
            initialValue: description,
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: onDescriptionChanged,
          ),
        ],
      ),
    );
  }
}
