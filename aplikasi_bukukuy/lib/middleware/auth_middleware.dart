import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../service/auth_service.dart';

// Halaman yang butuh login: kalau belum login, arahkan ke /login
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AuthService.isLoggedIn) return null;
    return const RouteSettings(name: AppRoutes.login);
  }
}
