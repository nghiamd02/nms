import 'package:flutter/material.dart';


typedef Callback = void Function(int);

class SideMenu extends StatelessWidget {
  const SideMenu(this.callback, {super.key});
  final Callback callback;

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
                      backgroundColor: Colors.white,
                    ),
                    Text("Note Manager System", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),),
                    Text("admin@gmail.com", style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),),
                  ]
              ),
            ),
            ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.camera_alt, color: Colors.lightBlue,),
              onTap: () {
                callback(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Category"),
              leading: const Icon(Icons.collections_rounded, color: Colors.lightBlue,),
              onTap: () {

                callback(1);
                Navigator.pop(context);

              },
            ),
            ListTile(
              title: const Text("Priority"),
              leading: const Icon(Icons.video_library, color: Colors.lightBlue,),
              onTap: () {

                callback(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Status"),
              leading: const Icon(Icons.build, color: Colors.lightBlue,),
              onTap: () {
                callback(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Note"),
              leading: const Icon(Icons.build, color: Colors.lightBlue,),
              onTap: () {
                callback(4);
                Navigator.pop(context);
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
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text("Change Password"),
                  leading: const Icon(Icons.send, color: Colors.lightBlue,),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        )
    );
  }
}