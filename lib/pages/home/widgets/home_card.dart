import 'package:ecommerce/components/loader.dart';
import 'package:ecommerce/navigation/navigation.dart';
import 'package:ecommerce/navigation/route_path.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import '../../../components/button.dart';

class HomeCard extends StatefulWidget {
  final Product product;
  const HomeCard({super.key, required this.product});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    final imageUrl = "https://picsum.photos/seed/${widget.product.id}/400/400";

    final originalPrice = widget.product.variants.first.originalPrice;
    final currentPrice = widget.product.variants.first.currentPrice;
    int discountPercentage = 0;

    if (originalPrice > 0 && originalPrice > currentPrice) {
      discountPercentage = (((originalPrice - currentPrice) / originalPrice) * 100).round();
    }

    return GestureDetector(
      onTap: () => Navigation.instance.navigate(RoutePath.productRoute, args: widget.product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.product.thumbnail.isEmpty
                            ? imageUrl
                            : widget.product.thumbnail,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) return child;
                          return const Loader();
                        },
                        errorBuilder: (_, __, ___) => Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            ...List.generate(
                              5,
                                  (index) => Icon(
                                index < widget.product.averageRating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${widget.product.averageRating.toStringAsFixed(1)})',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Rs. 1083",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Rs. 1140",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        OutlineButton(btnText: "Add to Bag", onPressed: () {}, borderColor: Constants.primary, textColor: Constants.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (discountPercentage > 0)
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "SAVE ${discountPercentage.toInt()}% OFF",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Constants.primaryTextColor,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                child: Icon(
                  widget.product.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: widget.product.isFavourite
                      ? Colors.red
                      : Colors.grey.shade700,
                  size: 22,
                ),
                onTap: () {
                  setState(() {
                    widget.product.isFavourite =
                    !widget.product.isFavourite;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}