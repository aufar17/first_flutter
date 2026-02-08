import 'package:first_flutter/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Colors.green.shade300,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.title,
                maxLines: 1,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                color: Colors.grey.shade100,
                child: Image.network(product.thumbnail, fit: BoxFit.contain),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    '\$${product.price}',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    product.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),

                  const SizedBox(height: 20),
                  sectionTitle('Basic Info'),
                  infoRow('ID', product.id.toString()),
                  infoRow('Category', product.category.name),
                  infoRow('Brand', product.brand ?? '-'),
                  infoRow('SKU', product.sku),

                  const SizedBox(height: 16),
                  sectionTitle('Pricing & Stock'),
                  infoRow('Price', '\$${product.price}'),
                  infoRow('Discount', '${product.discountPercentage}%'),
                  infoRow('Rating', product.rating.toString()),
                  infoRow('Stock', product.stock.toString()),
                  infoRow(
                    'Minimum Order',
                    product.minimumOrderQuantity.toString(),
                  ),

                  const SizedBox(height: 16),
                  sectionTitle('Specification'),
                  infoRow('Weight', '${product.weight} g'),
                  infoRow(
                    'Dimensions',
                    '${product.dimensions.width} x '
                        '${product.dimensions.height} x '
                        '${product.dimensions.depth}',
                  ),
                  infoRow('Warranty', product.warrantyInformation),
                  infoRow('Shipping', product.shippingInformation),

                  const SizedBox(height: 16),
                  sectionTitle('Availability & Policy'),
                  infoRow('Availability', product.availabilityStatus.name),
                  infoRow('Return Policy', product.returnPolicy.name),

                  const SizedBox(height: 16),
                  sectionTitle('Tags'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: product.tags
                        .map(
                          (tag) => Chip(
                            label: SelectableText(tag),
                            backgroundColor: Colors.blue.shade300,
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 16),
                  sectionTitle('Reviews'),
                  Column(
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating,
                            itemBuilder: (_, __) =>
                                const Icon(Icons.star, color: Colors.amber),
                          ),
                          const SizedBox(width: 10),
                          SelectableText(
                            '${product.rating.toString()} / 5',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Column(
                        children: product.reviews.map((review) {
                          return Card(
                            elevation: 0,
                            color: Colors.grey.shade100,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              title: SelectableText(
                                review.reviewerName,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: SelectableText(review.comment),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RatingBarIndicator(
                                    rating: review.rating.toDouble(),
                                    itemBuilder: (_, __) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${review.rating.toString()} / 5',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SelectableText(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: SelectableText(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
