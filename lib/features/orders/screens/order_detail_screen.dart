import 'package:flutter/material.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/checkout_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  Color _statusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _paymentLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.localBank:
        return 'Local Bank';
      case PaymentMethod.qrPayment:
        return 'QR Payment';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }

  String _bankLabel(LocalBank bank) {
    switch (bank) {
      case LocalBank.aceleda:
        return 'Aceleda';
      case LocalBank.aba:
        return 'ABA';
    }
  }

  String _maskCard(String number) {
    if (number.length < 4) return number;
    return '**** ${number.substring(number.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final form = order.form;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order #${order.orderId}',
          style: TextStyle(color: theme.textTheme.titleLarge?.color, fontSize: 20),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _statusColor(order.status).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _statusLabel(order.status),
              style: TextStyle(
                color: _statusColor(order.status),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${order.timestamp.day}/${order.timestamp.month}/${order.timestamp.year}',
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),

          // ── Shipping Address ──
          Text('Shipping Address',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _InfoCard(theme: theme, children: [
            _InfoRow(label: 'Name', value: form.fullName),
            _InfoRow(label: 'Address', value: form.streetAddress),
            _InfoRow(label: 'City', value: form.city),
            _InfoRow(label: 'Telegram', value: form.telegram),
            _InfoRow(label: 'Phone', value: form.phone),
          ]),

          const SizedBox(height: 24),

          // ── Payment ──
          Text('Payment', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _InfoCard(theme: theme, children: [
            _InfoRow(label: 'Method', value: _paymentLabel(form.paymentMethod)),
            if (form.paymentMethod == PaymentMethod.creditCard) ...[
              _InfoRow(label: 'Card', value: _maskCard(form.cardNumber)),
              _InfoRow(label: 'Expiry', value: form.expiry),
            ],
            if (form.paymentMethod == PaymentMethod.localBank)
              _InfoRow(label: 'Bank', value: _bankLabel(form.localBank)),
          ]),

          const SizedBox(height: 24),

          // ── Items ──
          Text('Items (${order.items.length})',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...order.items.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.image,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 56,
                            height: 56,
                            color: theme.dividerColor,
                            child: Icon(Icons.image, color: theme.iconTheme.color?.withValues(alpha: 0.4)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: TextStyle(color: theme.textTheme.titleMedium?.color, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('\$${item.price.toStringAsFixed(2)}',
                                style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          const SizedBox(height: 24),

          // ── Total ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                Text('\$${order.total.toStringAsFixed(2)}',
                    style: TextStyle(color: theme.colorScheme.primary, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final ThemeData theme;
  final List<Widget> children;
  const _InfoCard({required this.theme, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6), fontSize: 14)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
