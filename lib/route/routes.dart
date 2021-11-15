import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/modules/authentication/pages/welcome_page.dart';
import 'package:fs07/modules/dashboard/pages/dashboard_page.dart';
import 'package:fs07/modules/posts/blocs/list_posts_bloc.dart';

class Routes {
  static Route authorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(
          settings,
          BlocProvider(
            create: (_) => ListPostsBloc()..add('getPosts'),
            child: const DashboardPage(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route unAuthorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(
          settings,
          const WelcomePage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
