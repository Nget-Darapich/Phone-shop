import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/checkout_model.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/product_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutFormModel _form = const CheckoutFormModel();

  final _fullNameCtrl   = TextEditingController();
  final _streetCtrl     = TextEditingController();
  final _cityCtrl       = TextEditingController();
  final _telegramCtrl   = TextEditingController();
  final _phoneCtrl      = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _expiryCtrl     = TextEditingController();
  final _cvcCtrl        = TextEditingController();
  final _formKey        = GlobalKey<FormState>();
  String? _screenshotPath;

  @override
  void dispose() {
    for (final c in [
      _fullNameCtrl, _streetCtrl, _cityCtrl,
      _telegramCtrl, _phoneCtrl, _cardNumberCtrl, _expiryCtrl, _cvcCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double get _totalAmount {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is double) return args;
    return 0.0;
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;

    final form = CheckoutFormModel(
      fullName: _fullNameCtrl.text,
      streetAddress: _streetCtrl.text,
      city: _cityCtrl.text,
      telegram: _telegramCtrl.text,
      phone: _phoneCtrl.text,
      paymentMethod: _form.paymentMethod,
      cardNumber: _cardNumberCtrl.text,
      expiry: _expiryCtrl.text,
      cvc: _cvcCtrl.text,
      localBank: _form.localBank,
    );

    final order = OrderModel(
      orderId: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      status: OrderStatus.pending,
      items: cartProducts(),
      total: _totalAmount,
      form: form,
    );

    orderHistoryNotifier.value = [...orderHistoryNotifier.value, order];
    cartIdsNotifier.value = <String>[];

    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary, size: 28),
            const SizedBox(width: 10),
            Text('Order Placed!',
                style: TextStyle(
                    color: onSurface, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Text(
          'Your order has been placed successfully.\nWe\'ll contact you via Telegram or phone.',
          style: TextStyle(color: onSurface.withValues(alpha: 0.6), height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            child: Text('Back to Home',
                style:
                    TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomNav(selectedIndex: 4),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  // ── AppBar ────────────────────────────────────────────
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: theme.scaffoldBackgroundColor,
                    surfaceTintColor: Colors.transparent,
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: onSurface.withValues(alpha: 0.07),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: onSurface, size: 18),
                      ),
                    ),
                    title: Text('Checkout',
                        style: TextStyle(
                            color: onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    actions: [
                      _AppBarIcon(Icons.search_rounded),
                      _AppBarIcon(Icons.notifications_none_rounded),
                      _AppBarIcon(Icons.wb_sunny_outlined),
                      const SizedBox(width: 8),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Checkout',
                              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),

                          const SizedBox(height: 24),

                          // ══ SHIPPING ADDRESS ════════════════════════════
                          _SectionTitle('Shipping Address'),
                          const SizedBox(height: 12),
                          _AddressCard(
                            fullNameCtrl: _fullNameCtrl,
                            streetCtrl:   _streetCtrl,
                            cityCtrl:     _cityCtrl,
                          ),

                          const SizedBox(height: 24),

                          // ══ CONTACT INFO ════════════════════════════════
                          _SectionTitle('Contact Info'),
                          const SizedBox(height: 12),
                          _ContactCard(
                            telegramCtrl: _telegramCtrl,
                            phoneCtrl:    _phoneCtrl,
                          ),

                          const SizedBox(height: 24),

                          // ══ PAYMENT METHOD ══════════════════════════════
                          _SectionTitle('Payment Method'),
                          const SizedBox(height: 12),
                          _buildPaymentOption(
                            method: PaymentMethod.creditCard,
                            icon: Icons.credit_card_rounded,
                            label: 'Credit Card',
                          ),
                          _buildPaymentOption(
                            method: PaymentMethod.localBank,
                            icon: Icons.account_balance_rounded,
                            label: 'Local Bank',
                          ),
                          _buildPaymentOption(
                            method: PaymentMethod.qrPayment,
                            icon: Icons.qr_code_scanner_rounded,
                            label: 'QR Payment',
                          ),
                          _buildPaymentOption(
                            method: PaymentMethod.cashOnDelivery,
                            icon: Icons.money_rounded,
                            label: 'Cash on Delivery',
                          ),

                          // ── Conditional payment detail panels ──────────
                          if (_form.paymentMethod == PaymentMethod.creditCard) ...[
                            const SizedBox(height: 12),
                            _CardDetailsCard(
                              cardNumberCtrl: _cardNumberCtrl,
                              expiryCtrl:     _expiryCtrl,
                              cvcCtrl:        _cvcCtrl,
                            ),
                          ],

                          if (_form.paymentMethod == PaymentMethod.qrPayment) ...[
                            const SizedBox(height: 12),
                            _QrPaymentPanel(
                              amount: _totalAmount,
                              screenshotPath: _screenshotPath,
                              onPickScreenshot: _pickScreenshot,
                            ),
                          ],

                          if (_form.paymentMethod == PaymentMethod.cashOnDelivery) ...[
                            const SizedBox(height: 12),
                            const _CashOnDeliveryPanel(),
                          ],

                          if (_form.paymentMethod == PaymentMethod.localBank) ...[
                            const SizedBox(height: 12),
                            _LocalBankPanel(
                              selectedBank: _form.localBank,
                              amount: _totalAmount,
                              onBankChanged: (b) =>
                                  setState(() => _form = _form.copyWith(localBank: b)),
                              screenshotPath: _screenshotPath,
                              onPickScreenshot: _pickScreenshot,
                            ),
                          ],

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Fixed CTA bar ─────────────────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(
                20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(top: BorderSide(color: theme.dividerColor)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        const Text('Place Order',
                            style: TextStyle(
                                color: Color(0xFF020617),
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            '\$${_totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Color(0xFF020617),
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickScreenshot() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _screenshotPath = file.path);
    }
  }

  // ── Single payment option row ─────────────────────────────────────────────
  Widget _buildPaymentOption({
    required PaymentMethod method,
    required IconData icon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final primary = theme.colorScheme.primary;
    final selected = _form.paymentMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _form = _form.copyWith(paymentMethod: method)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? primary.withValues(alpha: 0.08) : theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? primary : theme.dividerColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? primary : onSurface.withValues(alpha: 0.5),
                  width: selected ? 5 : 2,
                ),
                color: selected ? theme.scaffoldBackgroundColor : Colors.transparent,
              ),
            ),
            const SizedBox(width: 14),
            Icon(icon, color: selected ? primary : onSurface.withValues(alpha: 0.5), size: 22),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    color: selected ? onSurface : onSurface.withValues(alpha: 0.7),
                    fontSize: 15,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// QR PAYMENT PANEL
// ══════════════════════════════════════════════════════════════════════════════
class _QrPaymentPanel extends StatelessWidget {
  final double amount;
  final String? screenshotPath;
  final VoidCallback onPickScreenshot;

  const _QrPaymentPanel({
    required this.amount,
    required this.screenshotPath,
    required this.onPickScreenshot,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Scan to Pay',
            style: TextStyle(
                color: onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/qr_payment.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Container(
                width: 200,
                height: 200,
                color: theme.scaffoldBackgroundColor,
                child: Icon(Icons.qr_code, size: 80, color: onSurface.withValues(alpha: 0.3)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
                color: onSurface,
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Scan this QR code with your banking app\nto complete the payment.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: onSurface.withValues(alpha: 0.5),
                fontSize: 13,
                height: 1.5),
          ),

          const SizedBox(height: 20),

          // Upload screenshot section
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Upload Payment Screenshot',
                style: TextStyle(
                    color: onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onPickScreenshot,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.dividerColor,
                  style: BorderStyle.solid,
                ),
              ),
              child: screenshotPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              screenshotPath!,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(screenshotPath!),
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    )
                  : Column(
                      children: [
                        Icon(Icons.cloud_upload_outlined,
                            size: 36,
                            color: onSurface.withValues(alpha: 0.4)),
                        const SizedBox(height: 8),
                        Text('Tap to upload receipt',
                            style: TextStyle(
                                color: onSurface.withValues(alpha: 0.5),
                                fontSize: 14)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CASH ON DELIVERY PANEL
// ══════════════════════════════════════════════════════════════════════════════
class _CashOnDeliveryPanel extends StatelessWidget {
  const _CashOnDeliveryPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Icon(Icons.money_rounded,
              size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text('Pay when your order arrives.',
              style: TextStyle(
                  color: onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(
            'No additional steps needed. Our delivery team\nwill collect the payment at your doorstep.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: onSurface.withValues(alpha: 0.5),
                fontSize: 13,
                height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// LOCAL BANK PANEL
// ══════════════════════════════════════════════════════════════════════════════
class _LocalBankPanel extends StatelessWidget {
  final LocalBank selectedBank;
  final double amount;
  final ValueChanged<LocalBank> onBankChanged;
  final String? screenshotPath;
  final VoidCallback onPickScreenshot;

  const _LocalBankPanel({
    required this.selectedBank,
    required this.amount,
    required this.onBankChanged,
    required this.screenshotPath,
    required this.onPickScreenshot,
  });

  // Bank metadata
  static const _banks = [
    (
      bank:        LocalBank.aceleda,
      name:        'ACELEDA Mobile',
      shortCode:   'ACELEDA',
      accountNo:   '001 234 5678 90',
      accountName: 'Phone Shop Co., Ltd',
      color:       Color(0xFF0EA5E9),   // blue
      iconBg:      Color(0xFF0C4A6E),
    ),
    (
      bank:        LocalBank.aba,
      name:        'ABA Mobile',
      shortCode:   'ABA',
      accountNo:   '000 123 456',
      accountName: 'Phone Shop Co., Ltd',
      color:       Color(0xFF22C55E),   // green
      iconBg:      Color(0xFF14532D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final meta = _banks.firstWhere((b) => b.bank == selectedBank);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Bank selector tabs ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: _banks.map((b) {
                final active = b.bank == selectedBank;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onBankChanged(b.bank),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: EdgeInsets.only(
                          right: b.bank == LocalBank.aceleda ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: active
                            ? b.color.withValues(alpha: 0.15)
                            : onSurface.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: active
                              ? b.color
                              : theme.dividerColor,
                          width: active ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Bank logo circle
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: b.iconBg,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                b.shortCode[0],
                                style: TextStyle(
                                    color: b.color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            b.shortCode,
                            style: TextStyle(
                                color: active ? onSurface : onSurface.withValues(alpha: 0.5),
                                fontSize: 13,
                                fontWeight: active
                                    ? FontWeight.w700
                                    : FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // ── Account details ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer to ${meta.name}',
                  style: TextStyle(
                      color: meta.color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                _BankDetailRow(
                    label: 'Account Name', value: meta.accountName),
                const SizedBox(height: 8),
                _BankDetailRow(
                  label: 'Account Number',
                  value: meta.accountNo,
                  isCopiable: true,
                ),
                const SizedBox(height: 8),
                _BankDetailRow(
                  label: 'Amount',
                  value: '\$${amount.toStringAsFixed(2)}',
                  valueBold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: theme.dividerColor),

          // ── Instructions ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How to pay',
                    style: TextStyle(
                        color: onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                _BankStep(
                    n: '1',
                    text: 'Open ${meta.name} on your phone'),
                const SizedBox(height: 6),
                _BankStep(
                    n: '2',
                    text: 'Go to Transfer → To Other Account'),
                const SizedBox(height: 6),
                _BankStep(
                    n: '3',
                    text:
                        'Enter account number ${meta.accountNo} and amount \$${amount.toStringAsFixed(2)}'),
                const SizedBox(height: 6),
                _BankStep(
                    n: '4',
                    text:
                        'Add your name as remark, confirm with PIN'),
                const SizedBox(height: 6),
                _BankStep(
                    n: '5',
                    text:
                        'Upload the transfer receipt below'),

                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Upload Payment Screenshot',
                      style: TextStyle(
                          color: onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onPickScreenshot,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.dividerColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: screenshotPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: kIsWeb
                                ? Image.network(
                                    screenshotPath!,
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(screenshotPath!),
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : Column(
                            children: [
                              Icon(Icons.cloud_upload_outlined,
                                  size: 36,
                                  color: onSurface.withValues(alpha: 0.4)),
                              const SizedBox(height: 8),
                              Text('Tap to upload receipt',
                                  style: TextStyle(
                                      color: onSurface.withValues(alpha: 0.5),
                                      fontSize: 14)),
                            ],
                          ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BankDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool valueBold;
  final bool isCopiable;

  const _BankDetailRow({
    required this.label,
    required this.value,
    this.valueBold = false,
    this.isCopiable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: onSurface.withValues(alpha: 0.5), fontSize: 13)),
        Row(
          children: [
            Text(value,
                style: TextStyle(
                    color: onSurface,
                    fontSize: 13,
                    fontWeight: valueBold
                        ? FontWeight.w700
                        : FontWeight.w500)),
            if (isCopiable) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Account number copied'),
                      backgroundColor: theme.cardColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Icon(Icons.copy_rounded,
                    color: Color(0xFF38BDF8), size: 15),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _BankStep extends StatelessWidget {
  final String n;
  final String text;
  const _BankStep({required this.n, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: onSurface.withValues(alpha: 0.15), shape: BoxShape.circle),
          child: Center(
            child: Text(n,
                style: TextStyle(
                    color: onSurface.withValues(alpha: 0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: onSurface.withValues(alpha: 0.55),
                  fontSize: 12,
                  height: 1.5)),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SHARED SUB-WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Text(text,
        style: TextStyle(
            color: onSurface, fontSize: 17, fontWeight: FontWeight.w700));
  }
}

class _AppBarIcon extends StatelessWidget {
  final IconData icon;
  const _AppBarIcon(this.icon);
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.07),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: onSurface, size: 18),
    );
  }
}

// ── Address card ──────────────────────────────────────────────────────────────
class _AddressCard extends StatelessWidget {
  final TextEditingController fullNameCtrl;
  final TextEditingController streetCtrl;
  final TextEditingController cityCtrl;

  const _AddressCard({
    required this.fullNameCtrl,
    required this.streetCtrl,
    required this.cityCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _FormField(controller: fullNameCtrl, hint: 'Full Name', isFirst: true),
          _Divider(),
          _FormField(controller: streetCtrl, hint: 'Street Address'),
          _Divider(),
          _FormField(controller: cityCtrl, hint: 'City'),
        ],
      ),
    );
  }
}

// ── Contact card ──────────────────────────────────────────────────────────────
class _ContactCard extends StatelessWidget {
  final TextEditingController telegramCtrl;
  final TextEditingController phoneCtrl;

  const _ContactCard({required this.telegramCtrl, required this.phoneCtrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _FormField(
            controller: telegramCtrl,
            hint: 'Telegram (@username)',
            prefixIcon: Icons.send_rounded,
            isFirst: true,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Telegram is required';
              if (!v.startsWith('@') && !v.startsWith('+')) {
                return 'Enter @username or phone number';
              }
              return null;
            },
          ),
          _Divider(),
          _FormField(
            controller: phoneCtrl,
            hint: 'Phone Number',
            prefixIcon: Icons.phone_rounded,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s()]'))
            ],
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Phone number is required';
              if (v.trim().length < 8) return 'Enter a valid phone number';
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// ── Card details card ─────────────────────────────────────────────────────────
class _CardDetailsCard extends StatelessWidget {
  final TextEditingController cardNumberCtrl;
  final TextEditingController expiryCtrl;
  final TextEditingController cvcCtrl;

  const _CardDetailsCard({
    required this.cardNumberCtrl,
    required this.expiryCtrl,
    required this.cvcCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _FormField(
            controller: cardNumberCtrl,
            hint: 'Card Number',
            keyboardType: TextInputType.number,
            isFirst: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _CardNumberFormatter(),
            ],
            validator: (v) {
              final digits = v?.replaceAll(' ', '') ?? '';
              if (digits.length != 16) return 'Enter a valid 16-digit card number';
              return null;
            },
          ),
          _Divider(),
          Row(
            children: [
              Expanded(
                child: _FormField(
                  controller: expiryCtrl,
                  hint: 'MM/YY',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _ExpiryFormatter(),
                  ],
                  validator: (v) =>
                      (v == null || v.length < 5) ? 'Invalid' : null,
                ),
              ),
              _VertDivider(),
              Expanded(
                child: _FormField(
                  controller: cvcCtrl,
                  hint: 'CVC',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: (v) =>
                      (v == null || v.length < 3) ? 'Invalid' : null,
                  obscureText: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Reusable form field ───────────────────────────────────────────────────────
class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final bool isFirst;
  final bool obscureText;

  const _FormField({
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.validator,
    this.isFirst = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      validator: validator ??
          (v) => (v == null || v.trim().isEmpty) ? '$hint is required' : null,
      style: TextStyle(color: onSurface, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: onSurface.withValues(alpha: 0.4), fontSize: 14),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: theme.colorScheme.primary, size: 20)
            : null,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        errorStyle:
            const TextStyle(color: Color(0xFFF87171), fontSize: 11),
        errorMaxLines: 1,
      ),
    );
  }
}

// ── Dividers ──────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Divider(
      height: 1, thickness: 1, color: Theme.of(context).dividerColor);
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: 1, height: 52, color: Theme.of(context).dividerColor);
}

// ── Input formatters ──────────────────────────────────────────────────────────
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final digits = next.text.replaceAll(' ', '');
    if (digits.length > 16) return old;
    final buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i != 0 && i % 4 == 0) buf.write(' ');
      buf.write(digits[i]);
    }
    final s = buf.toString();
    return next.copyWith(
        text: s, selection: TextSelection.collapsed(offset: s.length));
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final digits = next.text.replaceAll('/', '');
    if (digits.length > 4) return old;
    final buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2) buf.write('/');
      buf.write(digits[i]);
    }
    final s = buf.toString();
    return next.copyWith(
        text: s, selection: TextSelection.collapsed(offset: s.length));
  }
}