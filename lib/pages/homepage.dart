import 'package:first_flutter/controller/product_controller.dart';
import 'package:first_flutter/services/product.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
            SizedBox(width: 20),
            Text(
              'EPM SYSTEM',
              style: GoogleFonts.rosario(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade300,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'List Product'.toUpperCase(),
              style: GoogleFonts.rosario(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: Colors.green.shade900,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: GridView.builder(
                    itemCount: controller.products.length,
                    padding: const EdgeInsets.all(100),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                controller.products[index].thumbnail,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.products[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.rosario(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    controller.products[index].description,
                                    maxLines: 5,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.rosario(fontSize: 12),
                                  ),

                                  const SizedBox(height: 12),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '\$${controller.products[index].price}'
                                            .toString(),
                                        style: GoogleFonts.rosario(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
