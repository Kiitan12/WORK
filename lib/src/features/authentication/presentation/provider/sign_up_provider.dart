import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/services/sign_up_service.dart';

var hidePasswordProvider = StateProvider<bool>((ref) => true);

final passwordMismatchProvider = StateProvider((ref) => '');

final signUpProvider = StateNotifierProvider<SignUpService, bool>(
  (ref) => SignUpService(FirebaseAuth.instance),
);
