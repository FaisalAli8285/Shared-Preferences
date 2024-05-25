import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWidget extends StatefulWidget {
  const SharedPreferencesWidget({super.key});

  @override
  State<SharedPreferencesWidget> createState() =>
      _SharedPreferencesWidgetState();
}

class _SharedPreferencesWidgetState extends State<SharedPreferencesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference Widgit"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: ((context, AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No data available'));
                } else {
                  final prefs = snapshot.data!;
                  return Column(
                    children: [
                      Text(prefs.getString("name") ?? 'No name'),
                      Text(prefs.getInt("age")?.toString() ?? 'No age'),
                      Text(prefs.getBool("isLogin").toString()),
                      // Text(prefs.getDouble("Lucky_number")?.toString() ??
                      //     'No lucky number'),
                      // Text(prefs.getBool("isLogin")?.toString() ??
                      //     'Not logged in'),
                    ],
                  );
                }
              }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setInt("age", 24);
          sp.setBool("isLogin", false);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
