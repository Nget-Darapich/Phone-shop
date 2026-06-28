enum PaymentMethod { creditCard, applePay, localBank }

enum LocalBank { aceleda, aba }

class CheckoutFormModel {
  final String fullName;
  final String streetAddress;
  final String city;
  final String telegram;
  final String phone;
  final PaymentMethod paymentMethod;
  final String cardNumber;
  final String expiry;
  final String cvc;
  final LocalBank localBank;

  const CheckoutFormModel({
    this.fullName = '',
    this.streetAddress = '',
    this.city = '',
    this.telegram = '',
    this.phone = '',
    this.paymentMethod = PaymentMethod.creditCard,
    this.cardNumber = '',
    this.expiry = '',
    this.cvc = '',
    this.localBank = LocalBank.aceleda,
  });

  CheckoutFormModel copyWith({
    String? fullName,
    String? streetAddress,
    String? city,
    String? telegram,
    String? phone,
    PaymentMethod? paymentMethod,
    String? cardNumber,
    String? expiry,
    String? cvc,
    LocalBank? localBank,
  }) {
    return CheckoutFormModel(
      fullName: fullName ?? this.fullName,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      telegram: telegram ?? this.telegram,
      phone: phone ?? this.phone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvc: cvc ?? this.cvc,
      localBank: localBank ?? this.localBank,
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'streetAddress': streetAddress,
    'city': city,
    'telegram': telegram,
    'phone': phone,
    'paymentMethod': paymentMethod.name,
    'cardNumber': cardNumber,
    'expiry': expiry,
    'cvc': cvc,
    'localBank': localBank.name,
  };

  factory CheckoutFormModel.fromJson(Map<String, dynamic> json) =>
      CheckoutFormModel(
        fullName: json['fullName'] as String? ?? '',
        streetAddress: json['streetAddress'] as String? ?? '',
        city: json['city'] as String? ?? '',
        telegram: json['telegram'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        paymentMethod: PaymentMethod.values.firstWhere(
            (e) => e.name == json['paymentMethod'],
            orElse: () => PaymentMethod.creditCard),
        cardNumber: json['cardNumber'] as String? ?? '',
        expiry: json['expiry'] as String? ?? '',
        cvc: json['cvc'] as String? ?? '',
        localBank: LocalBank.values.firstWhere(
            (e) => e.name == json['localBank'],
            orElse: () => LocalBank.aceleda),
      );
}
