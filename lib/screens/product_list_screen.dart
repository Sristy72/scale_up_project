import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../widgets/product_tile.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List", style: TextStyle(fontWeight: FontWeight.bold),)),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: controller.setSearch,
              decoration: InputDecoration(
                hintText: "Search products by title",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          // Category Dropdown
          Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: controller.selectedCategory.value,
              onChanged: (val) => controller.setCategory(val!),
              items: controller.categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
            ),
          )),

          // Product List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildSkeletonLoader();
              }
              return RefreshIndicator(
                onRefresh: controller.fetchProducts,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.7),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return ProductTile(product: product);
                  },
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.7),
      itemBuilder: (context, index) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container(color: Colors.grey[300],)),
            Container(height: 20, color: Colors.grey[300], margin: const EdgeInsets.all(8)),
            Container(height: 20, width: 60, color: Colors.grey[300], margin: const EdgeInsets.all(8)),
          ],
        ),
      ),
    );
  }
}
