import 'package:ecommerce/components/button.dart';
import 'package:ecommerce/components/custom_app_bar.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../components/error_text.dart';
import '../../../components/loader.dart';
import '../../../utils/constants.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "BeautyBarn", canLeadBack: true),
      backgroundColor: Constants.bgColor,
      body: BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
          child: ProductDetailWidget(product: product)
      ),
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
  late ProductDetailBloc controller;

  @override
  void initState() {
    controller = BlocProvider.of<ProductDetailBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(builder: (context, state) {
      if(state is ProductDetailLoading){
        return const Loader();
      }else if(state is ProductDetailFailed){
        return ErrorText(error: state.error, onRetry: () {});
      }else {
        final price = widget.product.variants.isNotEmpty
            ? widget.product.variants.first.currentPrice
            : widget.product.priceStart ?? 0;
        final imageUrl = "https://picsum.photos/seed/${widget.product.id}/400/400";

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.product.brand != null)
                Text(
                  "by ${widget.product.brand!.title}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "₹${price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (widget.product.variants.isNotEmpty &&
                      widget.product.variants.first.originalPrice !=
                          widget.product.variants.first.currentPrice)
                    Text(
                      "₹${widget.product.variants.first.originalPrice}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber.shade700, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${widget.product.averageRating.toStringAsFixed(1)} • ${widget.product.reviewsCount} Reviews",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.product.tags
                    .map((t) => Chip(
                  label: Text(t.tag.title),
                  backgroundColor: Colors.pink.shade50,
                ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Html(
                data: widget.product.description,
                style: {
                  "body": Style(
                    fontSize: FontSize(15),
                    color: Colors.black87,
                    lineHeight: LineHeight(1.5),
                  ),
                },
              ),

              const SizedBox(height: 20),
              Button(btnText: "Add to Cart", onPressed: () {})
            ],
          ),
        );
      }
    }
    );
  }
}