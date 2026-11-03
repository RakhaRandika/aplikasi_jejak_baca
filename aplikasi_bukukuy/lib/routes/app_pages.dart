import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../middleware/guest_middleware.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      middlewares: [GuestMiddleware()],
    ),
  ];
}
