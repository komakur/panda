import 'package:injectable/injectable.dart';
import 'package:panda/models/user_profile/user_profile.dart';
import 'package:panda/services/http/http_client.dart';

/// AuthRepository for handling auth related api calls.
@Injectable(scope: 'auth')
class AuthRepository {
  final HttpClient httpClient;

  AuthRepository(this.httpClient);

  String get _endpointUrl => '/auth';

  Future<UserProfile> signInWithUsername(
    String username,
  ) async {
    final response = await httpClient.post(
      '$_endpointUrl/login',
      data: {'username': username},
    );

    final data = response.data;

    return UserProfile.fromJson(data);
  }
}
