import 'package:customer/api_provider/customer_provider.dart';
import 'package:customer/models/customer_model.dart';

class CustomerRepository {
  CustomerProvider customerProvider;
  CustomerRepository({required this.customerProvider});
  Future<CustomerModel> fetchCustomer() async {
    return customerProvider.fetchCustomer();
  }
}
