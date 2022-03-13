import '../controller/public_controller.dart';

double dynamicSize(double size){
  return PublicController.pc.size.value*size;
}