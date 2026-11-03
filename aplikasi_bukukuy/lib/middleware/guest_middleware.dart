import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../service/auth_service.dart';

// Halaman untuk tamu (login/daftar): kalau sudah login, arahkan ke /home
class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.isLoggedIn) return null;
    return const RouteSettings(name: AppRoutes.home);
  }
}
