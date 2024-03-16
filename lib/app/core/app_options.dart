/// Configuration separated by different environment
/// Add your respective [apiEndpoint] and more configuration here
/// Call/perform initialization action in [starter_handler.init] method.
class DevelopmentConstant {
  static const String apiEndpoint = 'Your apiEndpoint';
}

// TODO: Remove this after done with testing
class StagingConstant {
  static const String apiEndpoint = 'https://evsuperapp-staging.agmostudio.com';
}

class ProductionConstant {
  static const String apiEndpoint = 'Your apiEndpoint';
}
