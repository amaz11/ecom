import 'package:ecom/services/product.dart';
import 'package:get/get.dart';

class Dashboards extends GetxController {
  final productList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  getProductList() async {
    final res = await Product().getProduct();
    productList.value = res['data'];
  }
}
