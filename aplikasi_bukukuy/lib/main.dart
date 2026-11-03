import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'service/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.restoreSession();
  runApp(const BukukuyApp());
}

class BukukuyApp extends StatelessWidget {
  const BukukuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bukukuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF8F3),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E1A4D)),
        useMaterial3: true,
      ),
      initialRoute: AuthService.isLoggedIn ? AppRoutes.home : AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
