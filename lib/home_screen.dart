import 'package:flutter/material.dart';
import 'add_note_screen.dart';

const Color purple = Color(0xFF4938F5);
const Color bgColor = Color(0xFFF7F6FF);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> notes = [
    {
      'title': 'My Daily Goals',
      'description': 'Complete my daily tasks and stay positive.',
      'category': 'Personal',
    },
    {
      'title': 'Flutter Learning',
      'description': 'Practice Flutter and Dart every day.',
      'category': 'Work',
    },
    {
      'title': 'Shopping List',
      'description': 'Milk, bread, fruits and vegetables.',
      'category': 'Shopping',
    },
    {
      'title': 'Travel Plan',
      'description': 'Plan my next trip.',
      'category': 'Travel',
    },
  ];

  Future<void> openAddNote() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddNoteScreen(),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        notes.insert(0, result);
        selectedIndex = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note added successfully!'),
        ),
      );
    } else {
      setState(() => selectedIndex = 0);
    }
  }

  void openPage(String title) {
    Navigator.pop(context);

    if (title == 'Home') {
      setState(() => selectedIndex = 0);
    } else if (title == 'Categories') {
      setState(() => selectedIndex = 1);
    } else if (title == 'Profile') {
      setState(() => selectedIndex = 3);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SimplePage(title: title),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      // App Bar
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: purple),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'MyNotes',
          style: TextStyle(
            color: purple,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: purple),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NoteSearch(notes),
              );
            },
          ),
        ],
      ),

      // Small Slide Drawer: 65% Width
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.65,
        child: SafeArea(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 22, 12, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3730E8),
                      Color(0xFF635BFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: purple,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Mitesh Vaja',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'mitesh@example.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Drawer Options
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  children: [
                    drawerItem(
                      icon: Icons.home_rounded,
                      title: 'Home',
                      selected: selectedIndex == 0,
                      onTap: () => openPage('Home'),
                    ),
                    drawerItem(
                      icon: Icons.grid_view_rounded,
                      title: 'Categories',
                      selected: selectedIndex == 1,
                      onTap: () => openPage('Categories'),
                    ),
                    drawerItem(
                      icon: Icons.inventory_2_outlined,
                      title: 'Archive',
                      onTap: () => openPage('Archive'),
                    ),
                    drawerItem(
                      icon: Icons.delete_outline,
                      title: 'Trash',
                      onTap: () => openPage('Trash'),
                    ),
                    drawerItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () => openPage('Settings'),
                    ),
                    drawerItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () => openPage('Help & Support'),
                    ),
                    const SizedBox(height: 12),
                    const Divider(
                      color: Color(0xFFE8E3FF),
                    ),
                    drawerItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      color: Colors.red,
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Do you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('Logout clicked'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Main Screens
      body: IndexedStack(
        index: selectedIndex,
        children: [
          homeBody(),
          categoriesBody(),
          const Center(child: Text('Add Note')),
          profileBody(),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 2) {
            openAddNote();
          } else {
            setState(() => selectedIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        onPressed: openAddNote,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Reusable Drawer Item
  Widget drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool selected = false,
    Color? color,
  }) {
    final itemColor =
        color ?? (selected ? purple : const Color(0xFF30394D));

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        dense: true,
        minLeadingWidth: 22,
        horizontalTitleGap: 8,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        selected: selected,
        selectedTileColor: const Color(0xFFECE8FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Icon(icon, color: itemColor, size: 21),
        title: Text(
          title,
          style: TextStyle(
            color: itemColor,
            fontSize: 13,
            fontWeight:
            selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  // Home Screen
  Widget homeBody() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your thoughts, your space ✨',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${notes.length} notes in your collection',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          const Text(
            'Recent Notes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: notes.isEmpty
                ? const Center(
              child: Text('No notes yet. Add your first note!'),
            )
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.note_alt_outlined,
                        color: purple,
                      ),
                    ),
                    title: Text(
                      note['title'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(note['description'] ?? ''),
                          const SizedBox(height: 8),
                          Text(
                            note['category'] ?? 'Personal',
                            style: const TextStyle(
                              color: purple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          notes.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Categories Screen
  Widget categoriesBody() {
    final categories = [
      {'name': 'Personal', 'icon': Icons.description, 'color': Colors.pink},
      {'name': 'Work', 'icon': Icons.work, 'color': Colors.blue},
      {'name': 'Ideas', 'icon': Icons.lightbulb, 'color': Colors.amber},
      {'name': 'Shopping', 'icon': Icons.shopping_cart, 'color': Colors.green},
      {'name': 'Travel', 'icon': Icons.flight, 'color': Colors.deepPurple},
      {'name': 'Others', 'icon': Icons.grid_view, 'color': Colors.lightBlue},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final item = categories[index];
                final name = item['name'] as String;
                final color = item['color'] as Color;
                final icon = item['icon'] as IconData;

                final count = notes
                    .where((note) => note['category'] == name)
                    .length;

                return Card(
                  color: color.withValues(alpha: 0.09),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SimplePage(title: '$name ($count notes)'),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 38, color: color),
                        const SizedBox(height: 12),
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('$count Notes'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Profile Screen
  Widget profileBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFFECE8FF),
            child: Icon(
              Icons.person,
              size: 50,
              color: purple,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Mitesh Vaja',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text('mitesh@example.com'),
          const SizedBox(height: 20),
          Text('${notes.length} Notes'),
        ],
      ),
    );
  }
}

// Search Notes
class NoteSearch extends SearchDelegate<String> {
  final List<Map<String, String>> notes;

  NoteSearch(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => query = '',
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => buildList();

  @override
  Widget buildSuggestions(BuildContext context) => buildList();

  Widget buildList() {
    final results = notes.where((note) {
      return (note['title'] ?? '')
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          (note['description'] ?? '')
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No matching notes found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.note_alt_outlined,
            color: purple,
          ),
          title: Text(results[index]['title'] ?? ''),
          subtitle: Text(results[index]['description'] ?? ''),
        );
      },
    );
  }
}

// Placeholder Screens
class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: bgColor,
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: purple,
          ),
        ),
      ),
    );
  }
}
