import 'package:first_flutter/controller/product_controller.dart';
import 'package:first_flutter/pages/components/detail_product.dart';
import 'package:flutter/material.dart';
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
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.products.length,
                        padding: const EdgeInsets.only(bottom: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              hoverColor: Colors.green.shade300,
                              splashColor: Colors.green.shade600,
                              onTap: () {
                                Get.to(
                                  () => ProductDetail(
                                    product: controller.products[index],
                                  ),
                                );
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(16),
                                              ),
                                          child: Container(
                                            height: 300,
                                            color: Colors.grey.shade50,
                                            child: Image.network(
                                              controller
                                                  .products[index]
                                                  .thumbnail,
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
                                                controller
                                                    .products[index]
                                                    .title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.rosario(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                controller
                                                    .products[index]
                                                    .description,
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
                                      bottom: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade400,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          '\$${controller.products[index].price}',
                                          style: GoogleFonts.rosario(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
