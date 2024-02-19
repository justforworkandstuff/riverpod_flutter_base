/// Configuration separated by different environment
/// Add your respective [apiEndpoint] and more configuration here
/// Call/perform initialization action in [starter_handler.init] method.
class DevelopmentConstant {
  static const String apiEndpoint = 'Your apiEndpoint';
  static const String refreshTokenUrl = 'Your refreshTokenUrl';
}

class StagingConstant {
  static const String apiEndpoint = 'Your apiEndpoint';
  static const String refreshTokenUrl = 'Your refreshTokenUrl';
}

class ProductionConstant {
  static const String apiEndpoint = 'Your apiEndpoint';
  static const String refreshTokenUrl = 'Your refreshTokenUrl';
}
