import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:panda/models/typedefs.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default('') String id,
    @Default('') String username,
    @Default('') String token,
  }) = _UserProfile;

  factory UserProfile.fromJson(JsonMap json) => _$UserProfileFromJson(json);
}
