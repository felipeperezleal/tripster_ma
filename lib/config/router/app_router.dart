import 'package:go_router/go_router.dart';
import 'package:tripster_ma/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/login',
    name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/profile',
    name: ProfileScreen.name,
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: '/search',
    name: SearchScreen.name,
    builder: (context, state) => const SearchScreen(),
  ),
]);
