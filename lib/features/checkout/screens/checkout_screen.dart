import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/checkout_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutModel _form = const CheckoutModel();

  final _fullNameCtrl   = TextEditingController();
  final _streetCtrl     = TextEditingController();
  final _cityCtrl       = TextEditingController();
  final _zipCtrl        = TextEditingController();
  final _telegramCtrl   = TextEditingController();
  final _phoneCtrl      = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _expiryCtrl     = TextEditingController();
  final _cvcCtrl        = TextEditingController();
  final _formKey        = GlobalKey<FormState>();

  static const _bg      = Color(0xFF020617);
  static const _surface = Color(0xFF0F172A);
  static const _accent  = Color(0xFF38BDF8);
  static const _label   = Color(0xFF64748B);

  @override
  void dispose() {
    for (final c in [
      _fullNameCtrl, _streetCtrl, _cityCtrl, _zipCtrl,
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
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: _accent, size: 28),
            SizedBox(width: 10),
            Text('Order Placed!',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ],
        ),
        content: const Text(
          'Your order has been placed successfully.\nWe\'ll contact you via Telegram or phone.',
          style: TextStyle(color: Color(0xFF94A3B8), height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            child: const Text('Back to Home',
                style:
                    TextStyle(color: _accent, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
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
                    backgroundColor: _bg,
                    surfaceTintColor: Colors.transparent,
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                    title: const Text('Checkout',
                        style: TextStyle(
                            color: Colors.white,
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
                          const Text('Checkout',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800)),

                          const SizedBox(height: 24),

                          // ══ SHIPPING ADDRESS ════════════════════════════
                          _SectionTitle('Shipping Address'),
                          const SizedBox(height: 12),
                          _AddressCard(
                            fullNameCtrl: _fullNameCtrl,
                            streetCtrl:   _streetCtrl,
                            cityCtrl:     _cityCtrl,
                            zipCtrl:      _zipCtrl,
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
                            method: PaymentMethod.applePay,
                            icon: Icons.apple_rounded,
                            label: 'Apple Pay',
                          ),
                          _buildPaymentOption(
                            method: PaymentMethod.localBank,
                            icon: Icons.account_balance_rounded,
                            label: 'Local Bank',
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

                          if (_form.paymentMethod == PaymentMethod.applePay) ...[
                            const SizedBox(height: 12),
                            _ApplePayPanel(amount: _totalAmount),
                          ],

                          if (_form.paymentMethod == PaymentMethod.localBank) ...[
                            const SizedBox(height: 12),
                            _LocalBankPanel(
                              selectedBank: _form.localBank,
                              amount: _totalAmount,
                              onBankChanged: (b) =>
                                  setState(() => _form = _form.copyWith(localBank: b)),
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
              color: _surface,
              border: Border(
                  top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.07))),
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

  // ── Single payment option row ─────────────────────────────────────────────
  Widget _buildPaymentOption({
    required PaymentMethod method,
    required IconData icon,
    required String label,
  }) {
    final selected = _form.paymentMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _form = _form.copyWith(paymentMethod: method)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.08) : _surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? _accent : Colors.white.withValues(alpha: 0.08),
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
                  color: selected ? _accent : _label,
                  width: selected ? 5 : 2,
                ),
                color: selected ? Colors.white : Colors.transparent,
              ),
            ),
            const SizedBox(width: 14),
            Icon(icon, color: selected ? _accent : _label, size: 22),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.white70,
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
// APPLE PAY PANEL
// ══════════════════════════════════════════════════════════════════════════════
class _ApplePayPanel extends StatelessWidget {
  final double amount;
  const _ApplePayPanel({required this.amount});

  static const _surface = Color(0xFF0F172A);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Apple Pay logo row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.apple_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 6),
              const Text('Pay',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5)),
            ],
          ),

          const SizedBox(height: 20),

          // Mock QR code box
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const _QrMock(),
          ),

          const SizedBox(height: 16),

          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 8),

          Text(
            'Scan this QR code with your iPhone\nor open Apple Pay on your device.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 13,
                height: 1.5),
          ),

          const SizedBox(height: 16),

          // Steps
          _ApplePayStep(
            number: '1',
            text: 'Open Camera or Wallet app on your iPhone',
          ),
          const SizedBox(height: 8),
          _ApplePayStep(
            number: '2',
            text: 'Point at the QR code above',
          ),
          const SizedBox(height: 8),
          _ApplePayStep(
            number: '3',
            text: 'Confirm payment with Face ID or Touch ID',
          ),

          const SizedBox(height: 16),

          // "Or pay with device" button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.apple_rounded,
                  color: Colors.white, size: 20),
              label: const Text('Pay with this device',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.2)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplePayStep extends StatelessWidget {
  final String number;
  final String text;
  const _ApplePayStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFF38BDF8),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(number,
                style: const TextStyle(
                    color: Color(0xFF020617),
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  height: 1.5)),
        ),
      ],
    );
  }
}

/// Draws a minimal pixel-art QR pattern (purely decorative).
class _QrMock extends StatelessWidget {
  const _QrMock();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _QrPainter(),
      child: const SizedBox(width: 160, height: 160),
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(_) => false;
}

// ══════════════════════════════════════════════════════════════════════════════
// LOCAL BANK PANEL
// ══════════════════════════════════════════════════════════════════════════════
class _LocalBankPanel extends StatelessWidget {
  final LocalBank selectedBank;
  final double amount;
  final ValueChanged<LocalBank> onBankChanged;

  const _LocalBankPanel({
    required this.selectedBank,
    required this.amount,
    required this.onBankChanged,
  });

  static const _surface = Color(0xFF0F172A);

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
    final meta = _banks.firstWhere((b) => b.bank == selectedBank);

    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
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
                            : Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: active
                              ? b.color
                              : Colors.white.withValues(alpha: 0.08),
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
                                color: active ? Colors.white : Colors.white60,
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
                  valueColor: Colors.white,
                  valueBold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.06)),

          // ── Instructions ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('How to pay',
                    style: TextStyle(
                        color: Colors.white,
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
                        'Send us the transfer receipt via Telegram or phone'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color(0xFFFBBF24)
                            .withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          color: Color(0xFFFBBF24), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Your order will be confirmed after we verify your payment receipt.',
                          style: TextStyle(
                              color: const Color(0xFFFBBF24)
                                  .withValues(alpha: 0.85),
                              fontSize: 12,
                              height: 1.5),
                        ),
                      ),
                    ],
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
  final Color? valueColor;
  final bool valueBold;
  final bool isCopiable;

  const _BankDetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBold = false,
    this.isCopiable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFF64748B), fontSize: 13)),
        Row(
          children: [
            Text(value,
                style: TextStyle(
                    color: valueColor ?? Colors.white70,
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
                      backgroundColor: const Color(0xFF0F172A),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
              color: Color(0xFF1E293B), shape: BoxShape.circle),
          child: Center(
            child: Text(n,
                style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
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
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700));
}

class _AppBarIcon extends StatelessWidget {
  final IconData icon;
  const _AppBarIcon(this.icon);
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.07),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      );
}

// ── Address card ──────────────────────────────────────────────────────────────
class _AddressCard extends StatelessWidget {
  final TextEditingController fullNameCtrl;
  final TextEditingController streetCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController zipCtrl;

  const _AddressCard({
    required this.fullNameCtrl,
    required this.streetCtrl,
    required this.cityCtrl,
    required this.zipCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        children: [
          _FormField(controller: fullNameCtrl, hint: 'Full Name', isFirst: true),
          _Divider(),
          _FormField(controller: streetCtrl, hint: 'Street Address'),
          _Divider(),
          Row(
            children: [
              Expanded(child: _FormField(controller: cityCtrl, hint: 'City')),
              _VertDivider(),
              Expanded(
                child: _FormField(
                  controller: zipCtrl,
                  hint: 'ZIP',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
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
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      validator: validator ??
          (v) => (v == null || v.trim().isEmpty) ? '$hint is required' : null,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF475569), fontSize: 14),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color(0xFF38BDF8), size: 20)
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
      height: 1, thickness: 1, color: Colors.white.withValues(alpha: 0.06));
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: 1, height: 52, color: Colors.white.withValues(alpha: 0.06));
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