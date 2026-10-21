
import 'package:flutter/material.dart';

class MyNotesDrawer extends StatelessWidget {
  const MyNotesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.82,
      child: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Text(
                      'M',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mitesh Vaja',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'mitesh@example.com',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            // Sliding Menu Options
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  drawerItem(
                    context,
                    Icons.home_rounded,
                    'Home',
                    selected: true,
                    onTap: () => Navigator.pop(context),
                  ),
                  drawerItem(
                    context,
                    Icons.grid_view_rounded,
                    'Categories',
                    onTap: () => openPage(context, 'Categories'),
                  ),
                  drawerItem(
                    context,
                    Icons.inventory_2_outlined,
                    'Archive',
                    onTap: () => openPage(context, 'Archive'),
                  ),
                  drawerItem(
                    context,
                    Icons.delete_outline,
                    'Trash',
                    onTap: () => openPage(context, 'Trash'),
                  ),
                  drawerItem(
                    context,
                    Icons.settings_outlined,
                    'Settings',
                    onTap: () => openPage(context, 'Settings'),
                  ),
                  drawerItem(
                    context,
                    Icons.help_outline,
                    'Help & Support',
                    onTap: () => openPage(context, 'Help & Support'),
                  ),

                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFFE8E3FF)),
                  const SizedBox(height: 10),

                  drawerItem(
                    context,
                    Icons.logout,
                    'Logout',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logout clicked'),
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
    );
  }

  Widget drawerItem(
      BuildContext context,
      IconData icon,
      String title, {
        bool selected = false,
        Color? color,
        required VoidCallback onTap,
      }) {
    final itemColor = color ??
        (selected ? Colors.indigo : const Color(0xFF30394D));

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        selected: selected,
        selectedTileColor: const Color(0xFFECE8FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        leading: Icon(icon, color: itemColor, size: 25),
        title: Text(
          title,
          style: TextStyle(
            color: itemColor,
            fontWeight:
            selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void openPage(BuildContext context, String title) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(
            child: Text(
              '$title Screen',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
