import 'package:first_flutter/models/category.dart';
import 'package:first_flutter/models/product.dart';
import 'package:first_flutter/services/product.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final productService = Get.find<ProductService>();
  final ScrollController scrollController = ScrollController();

  var products = <Product>[].obs;
  var categories = <CategoryModel>[].obs;

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var selectedCategory = ''.obs;
  var isCategoryLoading = false.obs;
  final isEmptyCategory = false.obs;

  int limit = 10;
  int skip = 0;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getCategories();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          hasMore &&
          !isMoreLoading.value &&
          !isLoading.value) {
        getProducts();
      }
    });
  }

  Future<void> getProducts({bool reset = false}) async {
    if (!hasMore && !reset) return;

    try {
      if (reset) {
        skip = 0;
        hasMore = true;
        products.clear();
        isEmptyCategory.value = false;
      }

      skip == 0 ? isLoading.value = true : isMoreLoading.value = true;

      final productModel = await productService.getProducts(
        limit: limit,
        skip: skip,
        category: selectedCategory.value.isEmpty
            ? null
            : selectedCategory.value,
      );

      final orm = productModel.products;

      if (orm.isEmpty && skip == 0) {
        isEmptyCategory.value = true;
        hasMore = false;
      } else {
        isEmptyCategory.value = false;

        if (orm.isNotEmpty) {
          products.addAll(orm);
          skip += limit;
          hasMore = orm.length == limit;
        } else {
          hasMore = false;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  Future<void> getCategories() async {
    try {
      isCategoryLoading.value = true;
      final result = await productService.getCategories();

      categories.assignAll(result);
    } catch (e) {
      Get.snackbar('Empty product in category', e.toString());
    } finally {
      isCategoryLoading.value = false;
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    getProducts(reset: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
