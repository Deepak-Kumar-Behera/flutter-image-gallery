import '../enums/enum.dart';

class CApp {
  static String appVersion = "1.0.0";
  static String buildNumber = "1";
  static String appName = "Image Gallery";
  static String platform = "android";

  static EEnv env = EEnv.development; // Change this to EEnv.production for production environment

  static String baseUrl = env == EEnv.development ? baseUrlDev : baseUrlProd;

  // Supplied at build/run time: flutter run --dart-define-from-file=env.json
  static const String apiKey = String.fromEnvironment('PIXABAY_API_KEY');

  // Development
  static const String baseUrlDev = "https://pixabay.com/api/";

  // Production
  static const String baseUrlProd = "https://pixabay.com/api/";
}
