import 'package:first_flutter/controller/auth_controller.dart';
import 'package:first_flutter/controller/product_controller.dart';
import 'package:first_flutter/views/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final authController = Get.find<AuthController>();
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double aspectRatio;
    if (width >= 1400) {
      crossAxisCount = 5;
      aspectRatio = 0.79;
    } else if (width >= 1100) {
      crossAxisCount = 4;
      aspectRatio = 0.75;
    } else if (width >= 800) {
      crossAxisCount = 3;
      aspectRatio = 0.73;
    } else {
      crossAxisCount = 2;
      aspectRatio = 0.72;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade400,
        title: Row(
          children: [
            Image.asset('assets/img/logo.png', width: 40),
            const SizedBox(width: 12),
            Text(
              'EPM SYSTEM',
              style: GoogleFonts.rosario(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  authController.logout();
                },
                icon: Icon(Icons.logout, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'LIST PRODUCT',
            style: GoogleFonts.rosario(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.green.shade900,
            ),
          ),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text(
                  'Filter Category',
                  style: GoogleFonts.rosario(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Obx(() {
                      return DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: const Text('All Categories'),
                        value: productController.selectedCategory.value.isEmpty
                            ? null
                            : productController.selectedCategory.value,
                        items: [
                          const DropdownMenuItem(value: '', child: Text('All')),
                          ...productController.categories.map(
                            (c) => DropdownMenuItem(
                              value: c.slug,
                              child: Text(c.name),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            productController.changeCategory(value);
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (productController.isEmptyCategory.value) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 72,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No product found',
                        style: GoogleFonts.rosario(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                controller: productController.scrollController,
                padding: const EdgeInsets.all(20),
                cacheExtent: 500,
                itemCount:
                    productController.products.length +
                    (productController.isMoreLoading.value ? 1 : 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                ),
                itemBuilder: (context, index) {
                  if (index == productController.products.length) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  final product = productController.products[index];

                  return ProductCard(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
