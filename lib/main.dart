import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Import google_fonts
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_dream_screen.dart';
import 'screens/edit_dream_screen.dart';
import 'screens/article_screen.dart';
import 'models/dream.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Lunar Dream',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.darkTheme,  // Use your dark theme here instead of the basic ThemeData
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/welcome': (context) => const WelcomeScreen(),
      '/home': (context) => const HomeScreen(),
      '/add-dream': (context) => const AddDreamScreen(),
      '/view-card-dream': (context) => const HomeScreen(),
      '/view-article': (context) => const ArticleScreen(),
    },
    onGenerateRoute: (settings) {
      if (settings.name == '/edit-dream') {
        final Dream dream = settings.arguments as Dream;
        return MaterialPageRoute(
          builder: (context) => EditDreamScreen(dream: dream),
        );
      }
      return null;
    },
  );
}
}
