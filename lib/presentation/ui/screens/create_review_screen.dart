import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/create_review_controller.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

class CreateReviewScreen extends StatefulWidget {
  final int productId;
  const CreateReviewScreen({super.key, required this.productId});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _ratingTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Create Review"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _ratingTEController,
                  decoration: const InputDecoration(
                    hintText: "Rating out of 5",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (val) =>
                      val != null && val.isNotEmpty && int.parse(val) <= 5
                          ? null
                          : "Enter rating",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewTEController,
                  decoration: const InputDecoration(
                    hintText: "Write Review",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : "Enter your review",
                  textInputAction: TextInputAction.done,
                  maxLines: 6,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child:
                      GetBuilder<CreateReviewController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool result = await controller.createReview(
                              _reviewTEController.text.trim(),
                              widget.productId,
                              int.parse(_ratingTEController.text.trim()),
                            );

                            if (result) {
                              _reviewTEController.clear();
                              _ratingTEController.clear();
                              Get.showSnackbar(
                                const GetSnackBar(
                                  title: 'Success',
                                  message: 'Review create successfully',
                                  duration: Duration(seconds: 2),
                                  isDismissible: true,
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              Get.showSnackbar(
                                GetSnackBar(
                                  title: 'Failed',
                                  message: controller.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _reviewTEController.dispose();
    _ratingTEController.dispose();
  }
}
