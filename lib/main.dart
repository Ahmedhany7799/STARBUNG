import 'package:flutter/material.dart';
import 'package:juices/components/favorites_provider.dart';
import 'package:juices/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/home.dart';
import 'views/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkOnboardingSeen() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_seen') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: checkOnboardingSeen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Splash(); // Branded splash
            }

            final seen = snapshot.data ?? false;
            return seen == true ? Home() : const OnboardingScreen();
          },
        ),
      ),
    );
  }
}
