// controllers/product_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;
  var searchQuery = "".obs;
  var selectedCategory = "All".obs;

  final categories = ["All", "men's clothing", "jewelery", "electronics", "women's clothing", "fjallraven backpack"];

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        products.value = data.map((e) => Product.fromJson(e)).toList();
        filteredProducts.assignAll(products);
      }
    } finally {
      isLoading(false);
    }
  }

  void filterProducts() {
    List<Product> results = products;
    if (selectedCategory.value != "All") {
      results = results.where((p) => p.category == selectedCategory.value).toList();
    }
    if (searchQuery.isNotEmpty) {
      results = results.where((p) => p.title.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
    filteredProducts.assignAll(results);
  }

  void setSearch(String searchText) {
    searchQuery.value = searchText;
    filterProducts();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }
}
