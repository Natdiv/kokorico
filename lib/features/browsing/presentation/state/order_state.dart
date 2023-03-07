import 'auth_state.dart';

class OrderState extends AuthState {
  String? status; // OK
  String? paymentMethod; // OK
  String? paymentStatus; // OK
  String? deliveryAddress; // OK
  String? referenceAddress; // OK
  String deliveryCity = 'Kolwezi'; // OK
  String deliveryCountry = 'RDC'; // OK
  String? deliveryPhone; // OK
  String? paymentPhone; // OK
  String? deliveryEmail; // OK
  String deliveryNotes = ''; // OK
  double? deliveryPrice; // OK
  double? totalPrice; // OK
  List<Map<String, int>>? products; // OK
}
