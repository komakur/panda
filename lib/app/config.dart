abstract class AppConfig {
  static const appHttpClientUrl =
      String.fromEnvironment('APP_HTTP_CLIENT_API_URL');
  static const appWsClientUrl = String.fromEnvironment('APP_WS_CLIENT_API_URL');
}
