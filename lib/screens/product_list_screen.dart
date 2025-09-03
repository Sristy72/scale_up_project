import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../widgets/product_tile.dart';
import '../widgets/skeleton_loader_grid.dart';
import '../widgets/refreshable_grid.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 126, 131, 129),
        title: const Text("Product List", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

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

          // Product grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const SkeletonLoaderGrid();
              }
              return RefreshableGrid(
                onRefresh: controller.fetchProducts,
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return ProductTile(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
