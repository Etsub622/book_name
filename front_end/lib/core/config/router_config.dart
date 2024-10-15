import 'package:flutter/widgets.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/book/presentation/pages/add_books.dart';
import 'package:front_end/features/book/presentation/pages/book_detail.dart';
import 'package:front_end/features/book/presentation/pages/book_home.dart';
import 'package:front_end/features/book/presentation/pages/book_listing.dart';
import 'package:front_end/features/book/presentation/pages/settings.dart';
import 'package:front_end/features/book/presentation/pages/update.dart';
import 'package:front_end/features/book/presentation/widget/nav_bar.dart';
import 'package:front_end/features/onboarding/presentation/pages/home.dart';
import 'package:front_end/features/onboarding/presentation/pages/login.dart';
import 'package:front_end/features/onboarding/presentation/pages/onboard1.dart';
import 'package:front_end/features/onboarding/presentation/pages/onboard2.dart';
import 'package:front_end/features/onboarding/presentation/pages/onboard3.dart';
import 'package:front_end/features/onboarding/presentation/pages/onboard4.dart';
import 'package:front_end/features/onboarding/presentation/pages/signup.dart';
import 'package:front_end/features/onboarding/presentation/pages/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenKey');
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return FutureBuilder<String?>(
            future: _getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularIndicator());
              }
              final token = snapshot.data;
              if (token != null && token.isNotEmpty) {
                return BottomNavBAr();
              } else {
                return Onboard1();
              }
            },
          );
        },
      ),
      GoRoute(
        path: AppPath.onboard1,
        builder: (context, state) => Onboard1(),
      ),
      GoRoute(
        path: AppPath.onboard2,
        builder: (context, state) => Onboard2(),
      ),
      GoRoute(
        path: AppPath.onboard3,
        builder: (context, state) => Onboard3(),
      ),
      GoRoute(
        path: AppPath.onboard4,
        builder: (context, state) => Onboard4(),
      ),
      GoRoute(
        path: AppPath.welcome,
        builder: (context, state) => WelcomePage(),
      ),
      GoRoute(
        path: AppPath.signup,
        builder: (context, state) => SignUP(),
      ),
      GoRoute(
        path: AppPath.login,
        builder: (context, state) => LogIn(),
      ),
      GoRoute(
        path: AppPath.home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: AppPath.addBooks,
        builder: (context, state) => AddBooksPages(),
      ),
      GoRoute(
        path: AppPath.getBooks,
        builder: (context, state) => BookListing(),
      ),
      GoRoute(
        path: AppPath.settings,
        builder: (context, state) => BookHome(),
      ),
      GoRoute(
        path: AppPath.getBooksByCategory,
        builder: (context, state) {
          final category = state.extra as String;
          return BookListing(category: category);
        },
      ),
      GoRoute(
        path: AppPath.bookHome,
        builder: (context, state) => BookHome(),
      ),
      GoRoute(
        path: AppPath.navbar,
        builder: (context, state) => BottomNavBAr(),
      ),
    ],
  );
}
