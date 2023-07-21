import 'package:flutter/material.dart';
import 'package:nms/screens/dashboard.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(this.selectedPage, {super.key});
  final String selectedPage;

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
            item("Home", Icons.camera_alt, context),
            item("Category", Icons.collections_rounded, context),
            item("Priority", Icons.video_library, context),
            item("Status", Icons.build, context),
            item("Note", Icons.build, context),
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
                item("Edit Profile", Icons.share, context),
                item("Change Password", Icons.send, context),
              ],
            ),
          ],
        )
    );
  }

  ListTile item(String title, IconData icon, BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: (title == selectedPage) ? Colors.grey.withOpacity(0.2) : null,
      leading: Icon(icon, color: Colors.lightBlue,),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      },
    );
  }
}