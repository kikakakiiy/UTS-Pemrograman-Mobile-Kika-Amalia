import 'package:flutter/material.dart';

class KonversiBeratPage extends StatefulWidget {
  @override
  _KonversiBeratPageState createState() => _KonversiBeratPageState();
}

class _KonversiBeratPageState extends State<KonversiBeratPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'Gram';
  String _selectedToUnit = 'Kilogram';
  String _result = '';
  String _conversionProcess = '';

  static const Map<String, double> unitConversion = {
    'Gram': 1.0,
    'Mikrogram': 1e-6,
    'Kwintal': 100000.0,
    'Karat': 0.2,
    'Ton': 1000000.0,
    'Miligram': 0.001,
    'Kilogram': 1000.0,
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

    double inputInGrams = input * unitConversion[_selectedFromUnit]!;
    double output = inputInGrams / unitConversion[_selectedToUnit]!;

    String explanation = '$input $_selectedFromUnit = $inputInGrams gram.\n';
    explanation += '$inputInGrams gram = $output $_selectedToUnit.';

    setState(() {
      _result = '$output $_selectedToUnit';
      _conversionProcess = explanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Berat'),
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
                  'assets/images/images/konversi_berat.png', // Adjust the path according to your asset structure
                  height: 250.0, // Adjust height as needed
                ),
              ),
              SizedBox(height: 16),
              // Box for input value
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 106, 15, 15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color.fromARGB(255, 247, 240, 163)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 251, 242, 171)),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai berat',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Container for dropdown menus with extra padding
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 234, 175, 175),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(255, 251, 247, 191)),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _selectedFromUnit,
                              decoration: InputDecoration(
                                labelText: 'Dari',
                                border: InputBorder.none,
                              ),
                              items: unitConversion.keys.map((String value) {
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
                        SizedBox(width: 16),
                        // Icon with rounded background
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 241, 120),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.swap_horiz),
                            onPressed: () {
                              // Swap functionality if needed
                              String temp = _selectedFromUnit;
                              setState(() {
                                _selectedFromUnit = _selectedToUnit;
                                _selectedToUnit = temp;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 199, 199),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color.fromARGB(255, 251, 255, 190)),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _selectedToUnit,
                              decoration: InputDecoration(
                                labelText: 'Ke',
                                border: InputBorder.none,
                              ),
                              items: unitConversion.keys.map((String value) {
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
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _convert,
                      child: Text('Konversi'),
                    ),
                    SizedBox(height: 16),
                    // Conditionally display box for result
                    if (_result.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 227, 192, 251),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color.fromARGB(255, 62, 46, 91)),
                        ),
                        child: Text(
                          _result,
                          style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    SizedBox(height: 16),
                    // Box for conversion process explanation
                    if (_conversionProcess.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color.fromARGB(255, 25, 43, 54)),
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
