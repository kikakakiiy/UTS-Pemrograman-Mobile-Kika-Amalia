import 'package:flutter/material.dart';

class KonversiVolumePage extends StatefulWidget {
  @override
  _KonversiVolumePageState createState() => _KonversiVolumePageState();
}

class _KonversiVolumePageState extends State<KonversiVolumePage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'L';
  String _selectedToUnit = 'mL';
  String _result = '';
  String _conversionProcess = '';

  static const Map<String, double> unitConversion = {
    'Hektoliter': 100.0,
    'm3': 1000.0,
    'cm3': 0.001,
    'Desiliter': 0.1,
    'Centiliter': 0.01,
    'dm3': 1.0,
    'L': 1.0,
    'mm3': 1e-6,
    'mL': 0.001,
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

    double inputInLiters = input * unitConversion[_selectedFromUnit]!;
    double output = inputInLiters / unitConversion[_selectedToUnit]!;

    String explanation = '$input $_selectedFromUnit = $inputInLiters liter.\n';
    explanation += '$inputInLiters liter = $output $_selectedToUnit.';

    setState(() {
      _result = '$output $_selectedToUnit';
      _conversionProcess = explanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Volume'),
        backgroundColor:
            Color.fromARGB(255, 252, 214, 132), // Green color for AppBar
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
                  'assets/images/images/konversi_volume.png', // Adjust the path according to your asset structure
                  height: 250.0, // Adjust height as needed
                ),
              ),
              SizedBox(height: 16),
              // Box for input value
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green[50], // Light green background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.greenAccent), // Green border
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.greenAccent),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai volume',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Container for dropdown menus with extra padding
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
                                  color: Colors
                                      .green[100], // Light green background
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.greenAccent),
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
                                      value: value,
                                      child: Text(value),
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
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.green[
                                  200], // Slightly darker green for the icon container
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.swap_horiz,
                              color: Colors.white, // Icon color
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .green[100], // Light green background
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.greenAccent),
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
                                      child: Text(value),
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
                      child: Text('Konversi',
                          style: TextStyle(
                              color: Colors.black)), // Black text color
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Green background color
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
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        child: Text(
                          _result,
                          style: TextStyle(fontSize: 24, color: Colors.green),
                        ),
                      ),
                    SizedBox(height: 16),
                    // Box for conversion process explanation
                    if (_conversionProcess.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        child: Text(
                          _conversionProcess,
                          style: TextStyle(fontSize: 16),
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
