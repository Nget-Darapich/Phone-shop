enum PaymentMethod { creditCard, applePay, localBank }

enum LocalBank { aceleda, aba }

class CheckoutModel {
  final String fullName;
  final String streetAddress;
  final String city;
  final String zip;
  final String telegram;
  final String phone;
  final PaymentMethod paymentMethod;
  final String cardNumber;
  final String expiry;
  final String cvc;
  final LocalBank localBank;

  const CheckoutModel({
    this.fullName = '',
    this.streetAddress = '',
    this.city = '',
    this.zip = '',
    this.telegram = '',
    this.phone = '',
    this.paymentMethod = PaymentMethod.creditCard,
    this.cardNumber = '',
    this.expiry = '',
    this.cvc = '',
    this.localBank = LocalBank.aceleda,
  });

  CheckoutModel copyWith({
    String? fullName,
    String? streetAddress,
    String? city,
    String? zip,
    String? telegram,
    String? phone,
    PaymentMethod? paymentMethod,
    String? cardNumber,
    String? expiry,
    String? cvc,
    LocalBank? localBank,
  }) {
    return CheckoutModel(
      fullName: fullName ?? this.fullName,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      telegram: telegram ?? this.telegram,
      phone: phone ?? this.phone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvc: cvc ?? this.cvc,
      localBank: localBank ?? this.localBank,
    );
  }
}