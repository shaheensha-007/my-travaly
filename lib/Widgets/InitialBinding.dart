
import 'package:get/get.dart';
import '../getx_controller/Lanunage_Contoller/Lanuange_Controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController(), permanent: true);
  }
}