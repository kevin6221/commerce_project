import 'package:commerce_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commerce_project/screens/product_listing/product_list_controller.dart';

class ProductDetail extends StatelessWidget {
  final ProductListController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            var selectedProduct = productController.selectedProduct.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      selectedProduct.images![0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const commonSizeBox(),
                Text(
                  selectedProduct.title.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const commonSizeBox(height: 10),
                labelWithTextWidget(
                    labelKey: "Price",
                    labelValue: '\$${selectedProduct.price.toString()}'),
                const commonSizeBox(),
                labelWithTextWidget(
                    labelKey: "Description",
                    labelValue: selectedProduct.description.toString()),
              ],
            );
          },
        ),
      ),
    );
  }
}
