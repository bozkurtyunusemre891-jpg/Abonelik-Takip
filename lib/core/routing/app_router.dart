import 'package:abonelik_takip/features/subscriptions/presentation/pages/add_subscription_page.dart';
import 'package:abonelik_takip/features/subscriptions/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddSubscriptionPage(),
    ),
  ],
);
