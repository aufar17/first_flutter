import 'package:first_flutter/models/category.dart';
import 'package:first_flutter/models/product.dart';
import 'package:get/get.dart';

class ProductService extends GetConnect {
  Future<ProductModel> getProducts({
    int limit = 10,
    int skip = 0,
    String? category,
  }) async {
    try {
      final url = category == null || category.isEmpty
          ? 'https://dummyjson.com/products'
          : 'https://dummyjson.com/products/category/$category';
      final response = await get(
        url,
        query: {'limit': '$limit', 'skip': '$skip'},
      );
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      }
      return ProductModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await get('https://dummyjson.com/products/categories');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      }

      final List data = response.body;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
