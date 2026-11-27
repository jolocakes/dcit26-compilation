
import 'package:material_ui/material_ui.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 5 - Navigation',

      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}
