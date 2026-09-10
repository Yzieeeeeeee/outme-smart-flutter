class AuthResponseModel {
  final String accessToken;
  final String refreshToken;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AuthResponseModel(
      accessToken: data['accessToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
    );
  }
}