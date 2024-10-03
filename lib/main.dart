import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/Pages/card_detail_page.dart';
import 'package:wealthwise/Pages/profile_page.dart';
import 'package:wealthwise/Theme/theme_provider.dart';
import 'Pages/RegisterPage.dart';
import 'Pages/home.dart';
import 'Pages/LoginPage.dart';
import 'Pages/transaction_page.dart';
import 'Theme/network_provider.dart';
import 'Theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NetworkProvider()), // Add NetworkProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, NetworkProvider>(
      builder: (context, themeProvider, networkProvider, child) {
        return MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/transactions',
          routes: {
            '/register': (context) => const RegisterPage(),
            '/details': (context) => const CardDetails(),
            '/login': (context) => const LoginPage(),
            '/home': (context) => const Home(),
            '/transactions': (context) => const TransactionPage(),
            '/profile': (context) => const ProfilePage(),
          },
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                // Show connectivity status on top of all pages
                if (!networkProvider.isConnected)
                  Positioned(
                    top: 50, // slightly lower to float it a bit like a SnackBar
                    left: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10), // Rounded corners like a SnackBar
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26, // Subtle shadow for floating effect
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset(0, 5), // To give a lifting effect
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: const Center(
                        child: Text(
                          'Please Check your Connection',
                          style: TextStyle(color: Colors.white, fontSize: 12,decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  )
              ],
            );
          },
        );
      },
    );
  }
}
