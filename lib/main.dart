import 'package:flutter/material.dart';
import 'package:task1/common/database_helper.dart';
import 'package:task1/providers/repositories.dart';
import 'package:task1/screens/repositories_list.dart';
import 'package:provider/provider.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return Repositories();
      },
      child: MaterialApp(
        title: 'Repositories Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RepositoriesScreen(),
      ),
    );
  }
}
