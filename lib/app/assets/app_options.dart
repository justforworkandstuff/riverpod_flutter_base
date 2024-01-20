/// Configuration separated by different environment
/// Add your respective [API_ENDPOINT] and more configuration here
/// Call/perform initialization action in [starter_handler.init] method.
class DevelopmentConstant {
  static const String API_ENDPOINT = 'YOUR API ENDPOINT';
}

class StagingConstant {
  static const String API_ENDPOINT = 'YOUR API ENDPOINT';
}

class ProductionConstant {
  static const String API_ENDPOINT = 'YOUR API ENDPOINT';
}

/// Define the type of environment supported in this project
enum EnvironmentType { PRODUCTION, STAGING, DEVELOPMENT }
