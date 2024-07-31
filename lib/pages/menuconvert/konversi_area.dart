import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart'; // Tambahkan dependensi ini ke pubspec.yaml

class KonversiAreaPage extends StatefulWidget {
  @override
  _KonversiAreaPageState createState() => _KonversiAreaPageState();
}

class _KonversiAreaPageState extends State<KonversiAreaPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'm2'; // Updated to a valid unit
  String _selectedToUnit = 'km2'; // Updated to a valid unit
  String _result = '';
  String _conversionProcess = '';

  static const Map<String, double> unitConversion = {
    'm2': 1.0,
    'dm2': 0.01,
    'cm2': 0.0001,
    'mm2': 1e-6,
    'km2': 1e6,
    'Are': 100.0,
    'Hektar': 10000.0,
  };

  void _convert() {
    double input;
    try {
      input = double.parse(_controller.text);
    } catch (e) {
      setState(() {
        _result = '';
        _conversionProcess = 'Nilai input tidak valid.';
      });
      return;
    }

    double inputInSquareMeters = input * unitConversion[_selectedFromUnit]!;
    double output = inputInSquareMeters / unitConversion[_selectedToUnit]!;

    String explanation =
        '$input $_selectedFromUnit = $inputInSquareMeters m2.\n';
    explanation += '$inputInSquareMeters m2 = $output $_selectedToUnit.';

    setState(() {
      _result = '$output $_selectedToUnit';
      _conversionProcess = explanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Area'),
        backgroundColor: Color.fromARGB(255, 252, 214, 132),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Centered image at the top
              Center(
                child: Image.asset(
                  'assets/images/images/konversi_area.png', // Adjust the path according to your asset structure
                  height: 250.0, // Adjust height as needed
                ),
              ),
              SizedBox(height: 16),
              // Box for input value
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 50, 104),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color.fromARGB(255, 6, 7, 6)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Color.fromARGB(255, 15, 44, 93)),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai area',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Container for dropdown menus with extra padding and swap icon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 238, 189,
                                      255), // Color for 'Dari' dropdown
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 13, 18, 15)),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedFromUnit,
                                  decoration: InputDecoration(
                                    labelText: 'Dari',
                                    border: InputBorder.none,
                                  ),
                                  items:
                                      unitConversion.keys.map((String value) {
                                    return DropdownMenuItem<String>(
                                      //backgroundColor: Colors.blue,
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color: const Color.fromARGB(255, 13,
                                                21, 13)), // Dropdown item color
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedFromUnit = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          // Container for swap icon with rounded background
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 251, 251,
                                  110), // Background color for the icon
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.swap_horiz, // Swap icon
                              color: const Color.fromARGB(255, 40, 32, 32),
                              size: 30.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 239, 190,
                                      255), // Color for 'Ke' dropdown
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 6, 5, 4)),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedToUnit,
                                  decoration: InputDecoration(
                                    labelText: 'Ke',
                                    border: InputBorder.none,
                                  ),
                                  items:
                                      unitConversion.keys.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color: const Color.fromARGB(255, 22,
                                                20, 18)), // Dropdown item color
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedToUnit = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _convert,
                      child: Text('Konversi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Button color
                      ),
                    ),
                    SizedBox(height: 16),
                    // Conditionally display box for result
                    if (_result.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 15, 21, 18)),
                        ),
                        child: Text(
                          _result,
                          style: TextStyle(
                              fontSize: 24,
                              color: const Color.fromARGB(255, 15, 21, 15)),
                        ),
                      ),
                    SizedBox(height: 16),
                    // Box for conversion process explanation
                    if (_conversionProcess.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 211, 201),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 26, 26, 17)),
                        ),
                        child: Text(
                          _conversionProcess,
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 15, 21, 15)),
                        ),
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
}
