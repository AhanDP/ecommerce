import 'package:ecommerce/models/brand.dart';
import 'package:ecommerce/models/review.dart';
import 'package:ecommerce/navigation/navigation.dart';
import 'package:ecommerce/navigation/route_path.dart';
import 'package:ecommerce/pages/home/productDetail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import '../../../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beauty Barn", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
          create: (context) => ProductDetailBloc(),
          child: ProductDetailWidget(product: product)),
    );
  }
}

class ProductDetailWidget extends StatefulWidget {
  final Product product;
  const ProductDetailWidget({super.key, required this.product});

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  final String imageBaseUrl = "https://beautybarn.in/";
  late String _selectedImageUrl;
  late List<String> _allImageUrls;
  late ProductDetailBloc controller;

  @override
  void initState() {
    controller = BlocProvider.of<ProductDetailBloc>(context);
    controller.fetchProductReview(widget.product.id);
    controller.fetchBrand(widget.product.handle);
    controller.fetchSimilarProduct(widget.product.id);
    init();
    super.initState();
  }

  void init() {
    _allImageUrls = ["https://picsum.photos/seed/${widget.product.id}/400/400"];
    for (int i = 1; i <= 4; i++) {
      _allImageUrls.add("https://picsum.photos/seed/${widget.product.id}-$i/400/400");
    }
    _selectedImageUrl = _allImageUrls.isNotEmpty ? _allImageUrls.first : '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageGallery(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductHeader(),
                    const SizedBox(height: 16),
                    _buildPriceAndDiscount(),
                    const SizedBox(height: 16),
                    _buildHighlights(),
                    Divider(height: 16, color: Colors.grey.shade300),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: controller.decreaseQuantity,
                                icon: const Icon(Icons.remove, color: Colors.brown),
                                splashRadius: 20,
                              ),
                              Text(
                                controller.quantity.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: controller.increaseQuantity,
                                icon: const Icon(Icons.add, color: Colors.brown),
                                splashRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${controller.quantity}x ${widget.product.title} added to bag.'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'ADD TO BAG',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Html(
                      data: widget.product.description,
                      style: {
                        "body": Style(
                          fontSize: FontSize(15),
                          color: Colors.black87,
                          lineHeight: const LineHeight(1.5),
                        ),
                        "ul": Style(padding: HtmlPaddings(left: HtmlPadding(20))),
                        "li": Style(margin: Margins(bottom: Margin(8)))
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildSimilarProductsSection(controller.similarProducts),
                    const SizedBox(height: 16),
                    _buildReviewsSection(controller.reviews),
                    const SizedBox(height: 16),
                    _buildAboutTheBrand(controller.brand),
                    const SizedBox(height: 16),
                    _buildStoreInfo(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageGallery() {
    return Column(
      children: [
        SizedBox(
          height: 350,
          width: double.infinity,
          child: Image.network(
            _selectedImageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, progress) {
              return progress == null
                  ? child
                  : const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _allImageUrls.length,
            itemBuilder: (context, index) {
              final imageUrl = _allImageUrls[index];
              final isSelected = _selectedImageUrl == imageUrl;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageUrl = imageUrl;
                  });
                },
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFD34263) : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              "${widget.product.averageRating.toStringAsFixed(1)}/5.0",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "(${widget.product.reviewsCount} ratings & 10 reviews)",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceAndDiscount() {
    if (widget.product.variants.isEmpty) return const SizedBox.shrink();
    final variant = widget.product.variants.first;
    final hasDiscount = variant.currentPrice < variant.originalPrice;
    final discountPercentage = hasDiscount
        ? (((variant.originalPrice - variant.currentPrice) / variant.originalPrice) * 100).round()
        : 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(variant.currentPrice * controller.quantity),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 12),
        if (hasDiscount) ...[
          Text(
            NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(variant.originalPrice),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "$discountPercentage% OFF",
              style: TextStyle(
                color: Colors.green.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildHighlights() {
    final highlights = <String>[];
    for (var tagItem in widget.product.tags) {
      String title = tagItem.tag.title;
      highlights.add(title);
    }

    if (highlights.isEmpty) return const SizedBox.shrink();

    return Column(
      children: highlights.map((text) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildSimilarProductsSection(List<Product> similarProducts) {
    if (similarProducts.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            "Similar Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarProducts.length,
            itemBuilder: (context, index) {
              final product = similarProducts[index];
              return _buildSimilarProductCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarProductCard(Product product) {
    final variant = product.variants.isNotEmpty ? product.variants.first : null;
    final imageUrl = "https://picsum.photos/seed/${widget.product.id}/400/400";
    final currentPrice = variant?.currentPrice ?? product.priceStart ?? 0;
    final originalPrice = variant?.originalPrice ?? 0;

    return GestureDetector(
      onTap: () {
        Navigation.instance.navigate(RoutePath.productRoute, args: product);
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber.shade600, size: 16),
                Text(
                  '${product.averageRating.toStringAsFixed(1)} (${product.reviewsCount})',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(currentPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 8),
                if (originalPrice > currentPrice)
                  Text(
                    NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(originalPrice),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5E6E9),
                  foregroundColor: const Color(0xFFD34263),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add to Cart'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection(List<Review> reviews) {
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text("No reviews yet."),
        ),
      );
    }

    Map<int, int> calculateRatingDistribution() {
      final Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
      for (var review in reviews) {
        if (distribution.containsKey(review.rating)) {
          distribution[review.rating] = distribution[review.rating]! + 1;
        }
      }
      return distribution;
    }

    final ratingDistribution = calculateRatingDistribution();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ratings",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text("From ${widget.product.reviewsCount} customers"),
        const SizedBox(height: 16),

        _buildRatingBar("5", ratingDistribution[5] ?? 0, widget.product.reviewsCount),
        _buildRatingBar("4", ratingDistribution[4] ?? 0, widget.product.reviewsCount),
        _buildRatingBar("3", ratingDistribution[3] ?? 0, widget.product.reviewsCount),
        _buildRatingBar("2", ratingDistribution[2] ?? 0, widget.product.reviewsCount),
        _buildRatingBar("1", ratingDistribution[1] ?? 0, widget.product.reviewsCount),

        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),

        // Use ListView.builder for a performant way to display the list of reviews.
        ListView.separated(
          shrinkWrap: true, // Necessary inside a SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(), // Disables scrolling for this list
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            final review = controller.reviews[index];
            // Pass the entire review object for cleaner code.
            return _buildReviewItem(review: review);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 24),
        ),
      ],
    );
  }

  Widget _buildRatingBar(String star, int count, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(star, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.grey, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: total > 0 ? count / total : 0,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 25,
            child: Text(
              count.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({required Review review}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 18,
                  );
                }),
              ),
              Text(review.approvedAt, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
          const SizedBox(height: 8),
          Text(review.comment, style: const TextStyle(fontSize: 15, height: 1.4)),
          const SizedBox(height: 10),
          Text(review.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 16),
              const SizedBox(width: 6),
              const Text("Recommended", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAboutTheBrand(Brand? brand) {
    if(brand != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About the Brand",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            brand.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            brand.description,
            style: TextStyle(
                fontSize: 15, color: Colors.grey.shade800, height: 1.5),
          )
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildStoreInfo() {
    return Column(
      children: [
        _buildInfoTile(
          icon: Icons.verified_user_outlined,
          title: "100% Authentic",
          subtitle: "All our products are directly sourced from brands.",
        ),
        _buildInfoTile(
          icon: Icons.local_shipping_outlined,
          title: "Free Shipping",
          subtitle: "On all orders above ₹1499",
        ),
        _buildInfoTile(
          icon: Icons.replay_circle_filled_outlined,
          title: "Easy returns",
          subtitle: "Hassle-free pick-ups and refunds",
        ),
      ],
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.grey.shade700),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}