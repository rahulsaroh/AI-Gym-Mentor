import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
GoogleSignIn googleSignIn(GoogleSignInRef ref) {
  return GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

// Helper to get authenticated client from current user
extension GoogleSignInAuthExt on GoogleSignIn {
  Future<http.Client?> getAuthenticatedClient() async {
    final headers = await currentUser?.authHeaders;
    if (headers == null) return null;
    return GoogleAuthClient(headers);
  }
}

final authProvider = NotifierProvider<Auth, void>(Auth.new);

class Auth extends Notifier<void> {
  @override
  void build() {}

  Future<bool> signIn() async {
    try {
      final user = await ref.read(googleSignInProvider).signIn();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await ref.read(googleSignInProvider).signOut();
  }
}
