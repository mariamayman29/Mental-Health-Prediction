class ApiConstants {
  static const String baseUrl =
      'https://mental-health-predict-7irh.onrender.com';
  static const String predictEndpoint = '/predict';

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
