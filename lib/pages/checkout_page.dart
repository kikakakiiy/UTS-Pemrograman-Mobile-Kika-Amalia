import 'package:flutter/material.dart';
import 'package:flutter_apputskika2/models/cake.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// For date formatting

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cakes;
  const CheckoutPage({Key? key, required this.cakes}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final Map<String, bool> _flavors = {
    'Chocolate': false,
    'Cheesecake': false,
    'Rainbow': false,
  };

  String _selectedSize = '';
  bool _isUserInfoFilled = false;
  bool _isFlavorSelected = false;
  bool _isSizeSelected = false;
  double _userRating = 0;
  double _satisfactionRating = 0;
  DateTime _selectedDate =
      DateTime.now().add(Duration(days: 1)); // Default to tomorrow
  TimeOfDay? _selectedTime; // Changed to nullable
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateUserInfoStatus);
    _emailController.addListener(_updateUserInfoStatus);
    _addressController.addListener(_updateUserInfoStatus);
    _checkFlavorSelection();
  }

  void _updateUserInfoStatus() {
    setState(() {
      _isUserInfoFilled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _addressController.text.isNotEmpty;
    });
  }

  void _checkFlavorSelection() {
    setState(() {
      _isFlavorSelected = _flavors.values.contains(true);
    });
  }

  Future<bool> _onWillPop() async {
    final bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Are you sure you want to exit the checkout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm exit
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Stay on the page
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    return shouldExit ?? false;
  }

  void _showOrderConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/images/success_icon.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Order Successfully Placed!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showRatingDialog(); // Tampilkan dialog rating setelah OK
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate Your Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Rate the app:'),
              RatingBar.builder(
                initialRating: _userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _userRating = rating;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Rate your satisfaction:'),
              RatingBar.builder(
                initialRating: _satisfactionRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _satisfactionRating = rating;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/menuPageCake');
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildSatisfactionRating() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: List.generate(5, (index) {
  //       return IconButton(
  //         icon: Text(
  //           index < _satisfactionRating ? '😁' : '😐',
  //           style: TextStyle(fontSize: 24),
  //         ),
  //         onPressed: () {
  //           setState(() {
  //             _satisfactionRating = index + 1.0;
  //           });
  //         },
  //       );
  //     }),
  //   );
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().add(Duration(days: 1)), // Start from tomorrow
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(), // Handle nullable
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _buildPaymentMethodLogo() {
    String logoPath;
    switch (_selectedPaymentMethod) {
      case 'ShopeePay':
        logoPath = 'lib/images/spay.png';
        break;
      case 'GoPay':
        logoPath = 'lib/images/gopay.png';
        break;
      case 'mBanking':
        logoPath = 'lib/images/bni_logo.jpg';
        break;
      default:
        logoPath = '';
    }
    return logoPath.isNotEmpty
        ? Image.asset(logoPath, height: 50, width: 50)
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var cakeEntry in widget.cakes) {
      final cake = cakeEntry['cake'] as Cake;
      final quantity = cakeEntry['quantity'] as int;
      totalPrice += cake.price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        backgroundColor: Color.fromARGB(255, 68, 39, 86),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Warna ikon putih
          ),
          onPressed: () async {
            bool shouldExit = await _onWillPop();
            if (shouldExit) {
              Navigator.of(context).pop(); // Navigate back to Cake Detail Page
            }
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Information Heading
              Text(
                'Please fill out the user information below completely:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // User Information Section
              GestureDetector(
                onTap: () {
                  if (!_isUserInfoFilled) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Fill User Information'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildInfoBox('Name', _nameController),
                              _buildInfoBox('Email', _emailController),
                              _buildInfoBox('Address', _addressController),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (_nameController.text.isNotEmpty &&
                                    _emailController.text.isNotEmpty &&
                                    _addressController.text.isNotEmpty) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Finish'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  color: _isUserInfoFilled
                      ? Color.fromARGB(255, 186, 148, 204) // Pastel Purple
                      : Color.fromARGB(255, 234, 169, 169), // Disabled Color
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Fill User Information',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Cake List
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.cakes.length,
                itemBuilder: (context, index) {
                  final cakeEntry = widget.cakes[index];
                  final cake = cakeEntry['cake'] as Cake;
                  final quantity = cakeEntry['quantity'] as int;
                  final additionalItems =
                      cakeEntry['additionalItems'] as List<String>;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(cake.name),
                      subtitle: Text(
                          'Quantity: $quantity\nAdditional: ${additionalItems.join(', ')}'),
                      trailing: Text('Rp${cake.price * quantity}'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Flavour Selection
              Text(
                'Select Cake Flavors:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ..._flavors.keys.map((flavor) {
                return CheckboxListTile(
                  title: Text(flavor),
                  value: _flavors[flavor],
                  onChanged: (bool? value) {
                    setState(() {
                      _flavors[flavor] = value ?? false;
                      _checkFlavorSelection();
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 20),
              // Size Selection
              Text(
                'Select Cake Size:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Mini Cake'),
                      leading: Radio<String>(
                        value: 'Mini Cake',
                        groupValue: _selectedSize,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedSize = value!;
                            _isSizeSelected = true;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Original'),
                      leading: Radio<String>(
                        value: 'Original',
                        groupValue: _selectedSize,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedSize = value!;
                            _isSizeSelected = true;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Date and Time Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 205, 247),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Date:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat('yyyy-MM-dd').format(_selectedDate),
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: Text('Select Date'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 205, 247),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Time:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _selectedTime != null
                                  ? _selectedTime!.format(context)
                                  : 'No time selected',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => _selectTime(context),
                              child: Text('Select Time'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Payment Method and Confirm Order
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 198, 238),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Method
                    Text(
                      'Select Payment Method:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: _selectedPaymentMethod,
                      hint: Text('Select Payment Method'), // Added hint
                      items: [
                        'ShopeePay',
                        'GoPay',
                        'mBanking',
                      ].map((method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      },
                    ),

                    const SizedBox(width: 50),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0), // Jarak vertikal dari dropdown
                      child: _buildPaymentMethodLogo(),
                    ),

                    const SizedBox(height: 20),
                    // Total Price and Confirm Order Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: Rp$totalPrice',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (_isUserInfoFilled &&
                                  _isFlavorSelected &&
                                  _isSizeSelected)
                              ? () {
                                  _showOrderConfirmationDialog();
                                }
                              : null,
                          child: Text('Confirm Order'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (_isUserInfoFilled &&
                                    _isFlavorSelected &&
                                    _isSizeSelected)
                                ? Color.fromARGB(
                                    255, 186, 148, 204) // Pastel Purple
                                : Color.fromARGB(
                                    255, 234, 169, 169), // Disabled Color
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 205, 247),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $label',
            ),
          ),
        ],
      ),
    );
  }
}
