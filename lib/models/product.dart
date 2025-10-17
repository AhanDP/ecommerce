import 'variant.dart';

class Product {
  String id = '';
  String title = '';
  String? subtitle;
  String description = '';
  String handle = '';
  String thumbnail = '';
  String status = '';
  String visibility = '';
  String? publishedAt;
  String? createdAt;
  double averageRating = 0.0;
  int reviewsCount = 0;
  int ordersCount = 0;
  Brand? brand;
  List<CategoryItem> productCategories = [];
  List<TagItem> tags = [];
  List<Variant> variants = [];
  double? priceStart;
  double? priceEnd;
  bool isFavourite = false;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    subtitle = json['subtitle'];
    description = json['description'] ?? '';
    handle = json['handle'] ?? '';
    thumbnail = json['thumbnail'] ?? '';
    status = json['status'] ?? '';
    visibility = json['visibility'] ?? '';
    publishedAt = json['publishedAt'];
    createdAt = json['createdAt'];

    averageRating = (json['averageRating'] is num)
        ? (json['averageRating'] as num).toDouble()
        : 0.0;

    reviewsCount = json['reviewsCount'] ?? 0;
    ordersCount = json['ordersCount'] ?? 0;

    brand = (json['brand'] != null) ? Brand.fromJson(json['brand']) : null;

    productCategories = (json['productCategories'] != null)
        ? (json['productCategories'] as List)
        .map((e) => CategoryItem.fromJson(e))
        .toList()
        : [];

    tags = (json['tags'] != null)
        ? (json['tags'] as List).map((e) => TagItem.fromJson(e)).toList()
        : [];

    variants = (json['variants'] != null)
        ? (json['variants'] as List).map((e) => Variant.fromJson(e)).toList()
        : [];

    priceStart = (json['priceStart'] is num)
        ? (json['priceStart'] as num).toDouble()
        : null;

    priceEnd = (json['priceEnd'] is num)
        ? (json['priceEnd'] as num).toDouble()
        : null;
  }
}

class Brand {
  String id = '';
  String handle = '';
  String title = '';

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    handle = json['handle'] ?? '';
    title = json['title'] ?? '';
  }
}

class CategoryItem {
  Category category = Category();

  CategoryItem();

  CategoryItem.fromJson(Map<String, dynamic> json) {
    category = Category.fromJson(json['category']);
  }
}

class Category {
  String id = '';
  String name = '';
  String handle = '';

  Category();

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    handle = json['handle'] ?? '';
  }
}

class TagItem {
  Tag tag = Tag();

  TagItem();

  TagItem.fromJson(Map<String, dynamic> json) {
    tag = Tag.fromJson(json['tag']);
  }
}

class Tag {
  String id = '';
  String title = '';
  String slug = '';

  Tag();

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    slug = json['slug'] ?? '';
  }
}