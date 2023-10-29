import 'package:venues_app/core/di/core_di.dart';
import 'package:venues_app/features/near_venues/di/near_venues_di.dart';

class ApplicationDI {
  static Future<void> init() async {
    await CoreDI.config();
    NearVenuesDI.config();
  }
}
