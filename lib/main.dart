import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_with_adapter_class/model/notes_model.dart';
import 'package:hive_with_adapter_class/view/home_screen/home_screen.dart';
import 'package:hive_with_adapter_class/view/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NotesModelAdapter());
  Box<NotesModel> box = await Hive.openBox<NotesModel>('notes');

  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
