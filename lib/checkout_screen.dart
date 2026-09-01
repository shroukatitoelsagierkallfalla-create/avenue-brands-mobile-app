import 'package:flutter/material.dart';
import 'confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;

  const CheckoutScreen({
    super.key,
    this.total = 1340.00,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final aptController = TextEditingController();
  final areaController = TextEditingController();
  final governorateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();

  bool emailOffers = false;
  bool saveInfo = false;

  static const double shippingCost = 75.00;

  double get orderTotal => widget.total + shippingCost;

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    aptController.dispose();
    areaController.dispose();
    governorateController.dispose();
    postalCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String? _validate() {
    if (emailController.text.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$')
        .hasMatch(emailController.text.trim())) {
      return 'Please enter a valid email';
    }
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (addressController.text.trim().isEmpty) {
      return 'Please enter your address';
    }
    if (areaController.text.trim().isEmpty ||
        governorateController.text.trim().isEmpty) {
      return 'Please enter your area and governorate';
    }
    if (phoneController.text.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  void _completeOrder() {
    final error = _validate();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ConfirmationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 32,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= ORDER SUMMARY =================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order summary',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'LE ${widget.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ================= CONTACT =================
                    const Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    _field(emailController, 'Email',
                        keyboardType: TextInputType.emailAddress),

                    const SizedBox(height: 6),

                    _checkboxRow(
                      value: emailOffers,
                      label: 'Email me with news and offers',
                      onChanged: (v) =>
                          setState(() => emailOffers = v ?? false),
                    ),

                    const SizedBox(height: 18),

                    // ================= DELIVERY =================
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'This will also be used as your billing address '
                      'for this order.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF0057A8),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'COUNTRY/REGION',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),

                    const SizedBox(height: 4),

                    _field(
                      TextEditingController(text: 'Egypt'),
                      'Country/Region',
                      enabled: false,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: _field(
                              firstNameController, 'First Name'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child:
                              _field(lastNameController, 'Last Name'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    _field(addressController, 'Address'),

                    const SizedBox(height: 8),

                    _field(aptController, 'Apt., suite, etc.'),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: _field(areaController, 'Area'),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: _field(
                              governorateController, 'Governorate'),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: _field(
                              postalCodeController, 'Postal Code'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    _field(phoneController, 'Phone number',
                        keyboardType: TextInputType.phone),

                    const SizedBox(height: 6),

                    _checkboxRow(
                      value: saveInfo,
                      label: 'Save this information for next time',
                      onChanged: (v) =>
                          setState(() => saveInfo = v ?? false),
                    ),

                    const SizedBox(height: 22),

                    // ================= SHIPPING METHOD =================
                    const Text(
                      'Shipping Method',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Standard',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Delivery takes 2-3 hours.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'LE ${shippingCost.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ================= PAYMENT =================
                    const Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Your payment method's billing address must "
                      'match the shipping address. All transactions '
                      'are secure and encrypted.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF0057A8),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.payments_outlined,
                            size: 18,
                            color: Color(0xFF0066B3),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Cash on delivery (COD)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              'assets/images/top.png',
                              width: 28,
                              height: 34,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              'assets/images/hair_bands.png',
                              width: 28,
                              height: 34,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ================= COMPLETE ORDER =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _completeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066B3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'COMPLETE ORDER',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEDEDED),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _checkboxRow({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF0066B3),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF0057A8),
            ),
          ),
        ),
      ],
    );
  }
}