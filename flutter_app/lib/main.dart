import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/note_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: const App(),
    );
  }
}
