import 'package:flutter/material.dart';
import 'package:venues_app/application_di.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationDI.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venue App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const NearVenuesListPage(),
      },
      initialRoute: '/',
    );
  }
}
