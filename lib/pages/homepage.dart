import 'package:first_flutter/controller/product_controller.dart';
import 'package:first_flutter/pages/components/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade400,
        title: Row(
          children: [
            Image.asset('assets/img/logo.png', width: 40, height: 40),
            const SizedBox(width: 12),
            Text(
              'EPM SYSTEM',
              style: GoogleFonts.rosario(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'LIST PRODUCT',
              style: GoogleFonts.rosario(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: Colors.green.shade900,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                const SizedBox(width: 22),
                Text(
                  'Select Category',
                  style: GoogleFonts.rosario(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const SizedBox(width: 20),
                SizedBox(
                  width: 260,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: controller.selectedCategory.value.isEmpty
                          ? null
                          : controller.selectedCategory.value,
                      hint: const Text('Filter Category'),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: [
                        const DropdownMenuItem<String>(
                          value: '',
                          child: Text('All'),
                        ),
                        ...controller.categories.map((c) {
                          return DropdownMenuItem<String>(
                            value: c.slug,
                            child: Text(c.name),
                          );
                        }),
                      ],

                      onChanged: (value) {
                        if (value != null) controller.changeCategory(value);
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.isEmptyCategory.value) {
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
                            'No product in this category',
                            style: GoogleFonts.rosario(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    controller: controller.scrollController,
                    itemCount:
                        controller.products.length +
                        (controller.isMoreLoading.value ? 1 : 0),
                    padding: const EdgeInsets.only(bottom: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      if (index == controller.products.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }

                      final product = controller.products[index];

                      return Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          hoverColor: Colors.green.shade300,
                          splashColor: Colors.green.shade600,
                          onTap: () {
                            Get.to(() => ProductDetail(product: product));
                          },
                          child: Card(
                            elevation: 2,
                            shadowColor: Colors.grey.shade600,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Container(
                                        height: 300,
                                        color: Colors.grey.shade50,
                                        child: Image.network(
                                          product.thumbnail,
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.rosario(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            product.description,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.rosario(
                                              fontSize: 12,
                                              height: 1.4,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          const SizedBox(height: 32),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 12,
                                  left: 12,
                                  bottom: 12,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: product.rating,
                                            itemBuilder: (_, __) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '${product.rating} / 5',
                                            style: GoogleFonts.montserrat(),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade400,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          '\$${product.price}',
                                          style: GoogleFonts.rosario(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }
}
