/// Configuration separated by different environment
/// Add your respective [apiEndpoint] and more configuration here
/// Call/perform initialization action in [starter_handler.init] method.
class DevelopmentConstant {
  static const String apiEndpoint = 'YOUR API ENDPOINT';
}

class StagingConstant {
  static const String apiEndpoint = 'YOUR API ENDPOINT';
}

class ProductionConstant {
  static const String apiEndpoint = 'YOUR API ENDPOINT';
}

/// Define the type of environment supported in this project
enum EnvironmentType { production, staging, development }
