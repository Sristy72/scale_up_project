import 'package:flutter/material.dart';

class SkeletonLoaderGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;

  const SkeletonLoaderGrid({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container(color: Colors.grey[300])),
            Container(height: 20, color: Colors.grey[300], margin: const EdgeInsets.all(8)),
            Container(height: 20, width: 60, color: Colors.grey[300], margin: const EdgeInsets.all(8)),
          ],
        ),
      ),
    );
  }
}
