import 'package:first_flutter/models/product.dart';
import 'package:first_flutter/services/product.service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final productService = Get.find<ProductService>();
  var products = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      isLoading.value = true;

      final productModel = await productService.getProducts(limit: 10, skip: 0);

      if (productModel.products.isNotEmpty) {
        products.assignAll(productModel.products);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
