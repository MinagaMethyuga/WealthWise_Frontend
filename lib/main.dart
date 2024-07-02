import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/Pages/card_detail_page.dart';
import 'package:wealthwise/Pages/profile_page.dart';
import 'package:wealthwise/Theme/theme_provider.dart';
import 'Pages/register_page.dart';
import 'Pages/home.dart';
import 'Pages/login_page.dart';
import 'Pages/transaction_page.dart';
import 'Theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/home',
          routes: {
            '/register': (context) => const RegisterPage(),
            '/details': (context) => const CardDetails(),
            '/login': (context) => const LoginPage(),
            '/home': (context) => const Home(),
            '/transactions': (context) => const TransactionPage(),
            '/profile' : (context) => const ProfilePage(),
          },

        );
      },
    );
  }
}
