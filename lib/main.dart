import 'package:akangatu_project/controllers/theme_controller.dart';
import 'package:akangatu_project/screens/card_screen.dart';
import 'package:akangatu_project/screens/home_screen.dart';
import 'package:akangatu_project/services/auth_service.dart';
import 'package:akangatu_project/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: AkangaApp(),
    ),
  );
}

class AkangaApp extends StatelessWidget {
  const AkangaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, child) {
        return MaterialApp(
          title: 'AKANGÁ',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: ThemeController.instance.isdartTheme ? Brightness.dark : Brightness.light,
            primaryColor: Colors.purple.shade900,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthCheck(),
        );
      },
    );
  }
}