import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/services/sign_in_service.dart';

final signInProvider = StateNotifierProvider<SignInService, bool>(
  (ref) => SignInService(FirebaseAuth.instance),
);
