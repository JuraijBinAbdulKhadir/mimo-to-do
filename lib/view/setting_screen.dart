import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(fontWeight: FontWeight.w700),),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(child: Image.asset('assets/images/logo.png'),),
              title: Text('Malak Idrissi',style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text('Rebat,Morocco'),
              trailing: Icon(Icons.mode_edit_rounded),
            ),
            Text('Hi my name is Malak Idrissi , I\'m community manager from Morocco '),
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: Icon(Icons.notifications_none_rounded),
              title: Text('Notification',style: TextStyle(fontWeight: FontWeight.bold),),
            ),ListTile(
              leading: Icon(Icons.settings),
              title: Text('General',style: TextStyle(fontWeight: FontWeight.bold),),
            ),ListTile(
              leading: Icon(Icons.person),
              title: Text('Account',style: TextStyle(fontWeight: FontWeight.bold),),
            ),ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
