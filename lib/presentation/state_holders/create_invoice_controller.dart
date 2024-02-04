import 'package:get/get.dart';
import 'package:infinity_buy/data/models/payment_method_list_model.dart';
import 'package:infinity_buy/data/models/response_data.dart';
import 'package:infinity_buy/data/services/network_caller.dart';
import 'package:infinity_buy/data/utility/urls.dart';

class CreateInvoiceController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  PaymentMethodListModel _paymentMethodListModel = PaymentMethodListModel();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  PaymentMethodListModel get paymentMethodListModel => _paymentMethodListModel;

  Future<bool> createInvoice() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ResponseData response =
        await NetworkCaller().getRequest(Urls.invoiceCreate);

    _inProgress = false;
    if (response.isSuccess) {
      isSuccess = true;
      _paymentMethodListModel =
          PaymentMethodListModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
