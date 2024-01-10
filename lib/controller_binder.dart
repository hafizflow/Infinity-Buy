import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/main_bottom_nav_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
  }
}
