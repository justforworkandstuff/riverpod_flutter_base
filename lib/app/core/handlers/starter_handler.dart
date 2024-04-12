import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/firebase_handler.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/notification_handler.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/shared_preference_handler.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';

/// Function to perform all initial configuration based on running environment
/// Any method, feature that requires to init()/start() before app running, may do it here
Future<void> init(EnvironmentType type) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setting up Shared Preference instance
  await SharedPreferenceHandler.getSharedPreference();

  /// Initialize Firebase related configurations
  await FirebaseHandler.instance.initialize(type);
  await NotificationHandler.getInstance();
}
