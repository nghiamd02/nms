import 'package:flutter/material.dart';
import 'package:nms/screens/dashboard_screen.dart';
import 'package:nms/screens/notes.dart';
import 'package:nms/screens/priority_screen.dart';
import 'package:nms/screens/status_screen.dart';
import 'category_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.lightBlue
              ),
              child: Column (
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  Text("Note Manager System"),
                ]
              ),
            ),
            ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.camera_alt, color: Colors.lightBlue,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            },
            ),
            ListTile(
              title: const Text("Category"),
              leading: const Icon(Icons.collections_rounded, color: Colors.lightBlue,),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CategoryScreen()));
              },
            ),
            ListTile(
              title: const Text("Priority"),
              leading: const Icon(Icons.video_library, color: Colors.lightBlue,),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PriorityScreen()));
              },
            ),
            ListTile(
              title: const Text("Status"),
              leading: const Icon(Icons.build, color: Colors.lightBlue,),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StatusScreen()));
              },
            ),
            ListTile(
              title: const Text("Note"),
              leading: const Icon(Icons.build, color: Colors.lightBlue,),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NoteScreen()));
              },
            ),

            const Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 16),
                  child: Text("Account"),
                ),
                ListTile(
                  title: const Text("Edit Profile"),
                  leading: const Icon(Icons.share, color: Colors.lightBlue,),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Dashboard()));
                  },
                ),
                ListTile(
                  title: const Text("Change Password"),
                  leading: const Icon(Icons.send, color: Colors.lightBlue,),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Dashboard()));
                  },
                ),
              ],
            ),
          ],
        )
    );
  }
}