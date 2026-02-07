import 'package:first_flutter/models/product.dart';
import 'package:get/get.dart';

class ProductService extends GetConnect {
  Future<ProductModel> getProducts({int limit = 30, int skip = 0}) async {
    try {
      final response = await get(
        'https://dummyjson.com/products',
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
}
