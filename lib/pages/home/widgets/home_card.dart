import 'package:ecommerce/navigation/navigation.dart';
import 'package:ecommerce/navigation/route_path.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import '../../../components/button.dart';
import '../../../components/loader.dart';

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
      discountPercentage =
          (((originalPrice - currentPrice) / originalPrice) * 100).round();
    }

    return GestureDetector(
      onTap: () => Navigation.instance.navigate(RoutePath.productRoute, args: widget.product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Loader();
                    },
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_not_supported_outlined,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  double rating = widget.product.averageRating;
                                  if (rating >= index + 1) {
                                    return const Icon(Icons.star, size: 14, color: Colors.amberAccent);
                                  } else if (rating > index && rating < index + 1) {
                                    return const Icon(Icons.star_half, size: 14, color: Colors.amberAccent);
                                  } else {
                                    return const Icon(Icons.star_border, size: 14, color: Colors.amberAccent);
                                  }
                                }),
                                const SizedBox(width: 4),
                                Text(
                                  widget.product.averageRating.toStringAsFixed(1),
                                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Rs. ${currentPrice.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Rs. ${originalPrice.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: OutlineButton(
                                btnText: "Add to Bag",
                                onPressed: () {},
                                borderColor: Constants.primary,
                                textColor: Constants.primary,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (discountPercentage > 0)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "SAVE ${discountPercentage.toInt()}% OFF",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                child: Icon(
                  widget.product.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: widget.product.isFavourite
                      ? Colors.red
                      : Colors.grey.shade600,
                  size: 20,
                ),
                onTap: () {
                  setState(() {
                    widget.product.isFavourite = !widget.product.isFavourite;
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