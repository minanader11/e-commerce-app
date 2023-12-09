import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailNotifier extends StateNotifier<String> {
  EmailNotifier() : super('');
  void onLogin(String email) {
    state = email;
  }
}

final emailProvider = StateNotifierProvider<EmailNotifier, String>(
  (ref) => EmailNotifier(),
);
