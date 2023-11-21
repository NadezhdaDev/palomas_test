import 'dart:io';
import '../presentation/attributes/config/app_config.dart';
import '../presentation/attributes/enum/story_type.dart';
import 'base/entry_points.dart';

void main() async {
  final storeType =
  Platform.isAndroid ? StoreType.googlePlay : StoreType.appStore;

  final appConfig = AppConfig(
    storeType,
  );


  return EntryPoints.main(
    appConfig,
  );
}
