import 'package:flutter/material.dart';

class KonversiSuhuPage extends StatefulWidget {
  @override
  _KonversiSuhuPageState createState() => _KonversiSuhuPageState();
}

class _KonversiSuhuPageState extends State<KonversiSuhuPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'Celsius';
  String _selectedToUnit = 'Fahrenheit';
  String _result = '';
  String _conversionProcess = '';

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

    double output;

    if (_selectedFromUnit == 'Celsius') {
      if (_selectedToUnit == 'Fahrenheit') {
        output = (input * 9 / 5) + 32;
      } else if (_selectedToUnit == 'Kelvin') {
        output = input + 273.15;
      } else if (_selectedToUnit == 'Rankine') {
        output = (input + 273.15) * 9 / 5;
      } else if (_selectedToUnit == 'Reamur') {
        output = input * 4 / 5;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'Fahrenheit') {
      if (_selectedToUnit == 'Celsius') {
        output = (input - 32) * 5 / 9;
      } else if (_selectedToUnit == 'Kelvin') {
        output = (input - 32) * 5 / 9 + 273.15;
      } else if (_selectedToUnit == 'Rankine') {
        output = input + 459.67;
      } else if (_selectedToUnit == 'Reamur') {
        output = (input - 32) * 4 / 9;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'Kelvin') {
      if (_selectedToUnit == 'Celsius') {
        output = input - 273.15;
      } else if (_selectedToUnit == 'Fahrenheit') {
        output = (input - 273.15) * 9 / 5 + 32;
      } else if (_selectedToUnit == 'Rankine') {
        output = input * 9 / 5;
      } else if (_selectedToUnit == 'Reamur') {
        output = (input - 273.15) * 4 / 5;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'Rankine') {
      if (_selectedToUnit == 'Celsius') {
        output = (input - 491.67) * 5 / 9;
      } else if (_selectedToUnit == 'Fahrenheit') {
        output = input - 459.67;
      } else if (_selectedToUnit == 'Kelvin') {
        output = input * 5 / 9;
      } else if (_selectedToUnit == 'Reamur') {
        output = (input - 491.67) * 4 / 9;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'Reamur') {
      if (_selectedToUnit == 'Celsius') {
        output = input * 5 / 4;
      } else if (_selectedToUnit == 'Fahrenheit') {
        output = (input * 9 / 4) + 32;
      } else if (_selectedToUnit == 'Kelvin') {
        output = (input * 5 / 4) + 273.15;
      } else if (_selectedToUnit == 'Rankine') {
        output = (input * 9 / 4) + 491.67;
      } else {
        output = input;
      }
    } else {
      output = input;
    }

    String explanation =
        '$input $_selectedFromUnit dikonversi ke $_selectedToUnit adalah $output $_selectedToUnit.';

    setState(() {
      _result = '$output $_selectedToUnit';
      _conversionProcess = explanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
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
                  'assets/images/images/konversi_suhu.png', // Adjust the path according to your asset structure
                  height: 250.0, // Adjust height as needed
                ),
              ),
              SizedBox(height: 16),
              // Box for input value
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai suhu',
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
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.blueAccent),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedFromUnit,
                                  decoration: InputDecoration(
                                    labelText: 'Dari',
                                    border: InputBorder.none,
                                  ),
                                  items: [
                                    'Celsius',
                                    'Fahrenheit',
                                    'Kelvin',
                                    'Rankine',
                                    'Reamur'
                                  ].map((String value) {
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.blueAccent),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedToUnit,
                                  decoration: InputDecoration(
                                    labelText: 'Ke',
                                    border: InputBorder.none,
                                  ),
                                  items: [
                                    'Celsius',
                                    'Fahrenheit',
                                    'Kelvin',
                                    'Rankine',
                                    'Reamur'
                                  ].map((String value) {
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
                      child: Text('Konversi'),
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
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.yellowAccent),
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
