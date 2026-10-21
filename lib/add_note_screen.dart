
import 'package:flutter/material.dart';

const Color purple = Color(0xFF4938F5);

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  String selectedCategory = 'Personal';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveNote() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter title and description'),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'title': title,
      'description': description,
      'category': selectedCategory,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),

      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: const Color(0xFFF7F6FF),
        foregroundColor: purple,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create a new note ✨',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: purple,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Write down your thoughts and ideas.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 28),

            const Text(
              'Note Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter note title',
                prefixIcon: const Icon(Icons.title),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.category),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Personal',
                  child: Text('Personal'),
                ),
                DropdownMenuItem(
                  value: 'Work',
                  child: Text('Work'),
                ),
                DropdownMenuItem(
                  value: 'Ideas',
                  child: Text('Ideas'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
            ),

            const SizedBox(height: 22),

            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Write your note here...',
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveNote,
                icon: const Icon(Icons.save_outlined),
                label: const Text(
                  'Save Note',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
