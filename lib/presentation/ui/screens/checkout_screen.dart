import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_buy/presentation/state_holders/create_invoice_controller.dart';
import 'package:infinity_buy/presentation/ui/screens/payment_webview_screen.dart';
import 'package:infinity_buy/presentation/ui/widgets/center_circular_progress_indicator.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().createInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: GetBuilder<CreateInvoiceController>(
          builder: (createInvoiceController) {
        if (createInvoiceController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        final invoiceWrapper =
            createInvoiceController.paymentMethodListModel.data!.first;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Payable: ${invoiceWrapper.payable}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "VAT: ${invoiceWrapper.vat}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Total: ${invoiceWrapper.total}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(
                          () => PaymentWebViewScreen(
                            url: invoiceWrapper
                                .paymentMethodList![index].redirectGatewayURL!,
                          ),
                        );
                      },
                      leading: Image.network(
                          invoiceWrapper.paymentMethodList![index].logo ?? ''),
                      title: Text(
                          invoiceWrapper.paymentMethodList![index].name ?? ''),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: invoiceWrapper.paymentMethodList?.length ?? 0,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
