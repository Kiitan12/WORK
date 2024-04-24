// Import statement for Riverpod package
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Import statement for UserService class
import '../../application/services/user_service.dart';

// Provider for managing the user service instance
final userServiceProvider = StateProvider<UserService>(
  (ref) => UserService(),
);

// Provider for asynchronously fetching user profile data
final getUserProvider = FutureProvider((ref) {
  final user = ref.watch(userServiceProvider);

  return user.getUserProfile();
});

// Provider for asynchronously updating user profile data
final updateUserProfileProvider = StateNotifierProvider<UserService, bool>(
  (ref) => UserService(),
);

// Provider for asynchronously fetching user's favorite tasks
final getFavoritesProvider = FutureProvider((ref) {
  final user = ref.watch(userServiceProvider);

  return user.getFavorites();
});
