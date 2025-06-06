import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/appwrite_controller.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';

class InitBindings {
  void initDependencies() {
    Get.put(AppwriteController(), permanent: true);
    Get.lazyPut(() => DataController(), fenix: true);
  }
}
