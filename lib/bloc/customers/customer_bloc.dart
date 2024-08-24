import 'package:customer/bloc/customers/customer_event.dart';
import 'package:customer/bloc/customers/customer_state.dart';
import 'package:customer/repositories/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
final CustomerRepository customerRepository;
CustomerBloc({required this.customerRepository}) : super(CustomerStateInital()) {
    on<CustomerEvent>((event, emit) async {
      if (event is GetCustomerEvent) {
           emit(CustomerStateLoading());
        try {
          final response = await customerRepository.fetchCustomer();
          if (response.user.isNotEmpty) {
            emit(CustomerStateSucess(response.user));
          } else {
            emit(CustomerStateErrorState("Failed to try again"));
          }
        } catch (e) {
          emit(CustomerStateErrorState("Failed to try again"));
        }
      }
    });
    
  }
}