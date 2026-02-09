import 'package:first_flutter/models/product.dart';
import 'package:first_flutter/views/pages/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double aspectRatio;
    int titleProduct;
    int descProduct;
    int priceProduct;

    if (width >= 1400) {
      aspectRatio = 1.5;
      titleProduct = 16;
      descProduct = 13;
      priceProduct = 14;
    } else if (width >= 1100) {
      aspectRatio = 1.6;
      titleProduct = 14;
      descProduct = 12;
      priceProduct = 14;
    } else if (width >= 800) {
      aspectRatio = 1.7;
      titleProduct = 12;
      descProduct = 10;
      priceProduct = 14;
    } else {
      aspectRatio = 1.8;
      titleProduct = 10;
      descProduct = 8;
      priceProduct = 12;
    }
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        hoverColor: Colors.green.shade100,
        onTap: () => Get.to(() => ProductDetail(product: product)),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.contain,
                    cacheWidth: 300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: titleProduct.toDouble(),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: descProduct.toDouble(),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Chip(
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.yellow.shade400,
                    label: Text(
                      '\$${product.price}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: priceProduct.toDouble(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
