import 'package:flutter/material.dart';
import 'checkout_model.dart';
import 'product_model.dart';

enum OrderStatus { pending, confirmed, shipped, delivered, cancelled }

class OrderModel {
  final String orderId;
  final DateTime timestamp;
  final OrderStatus status;
  final List<ProductModel> items;
  final double total;
  final CheckoutFormModel form;

  const OrderModel({
    required this.orderId,
    required this.timestamp,
    required this.status,
    required this.items,
    required this.total,
    required this.form,
  });

  OrderModel copyWith({
    String? orderId,
    DateTime? timestamp,
    OrderStatus? status,
    List<ProductModel>? items,
    double? total,
    CheckoutFormModel? form,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      items: items ?? this.items,
      total: total ?? this.total,
      form: form ?? this.form,
    );
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'timestamp': timestamp.toIso8601String(),
    'status': status.name,
    'items': items.map((p) => p.toJson()).toList(),
    'total': total,
    'form': form.toJson(),
  };

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: OrderStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => OrderStatus.pending),
      items: (json['items'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      form: CheckoutFormModel.fromJson(json['form'] as Map<String, dynamic>),
    );
  }
}

final ValueNotifier<List<OrderModel>> orderHistoryNotifier =
    ValueNotifier<List<OrderModel>>(<OrderModel>[]);
