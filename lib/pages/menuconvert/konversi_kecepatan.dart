import 'package:flutter/material.dart';

class KonversiKecepatanPage extends StatefulWidget {
  @override
  _KonversiKecepatanPageState createState() => _KonversiKecepatanPageState();
}

class _KonversiKecepatanPageState extends State<KonversiKecepatanPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'm/s';
  String _selectedToUnit = 'km/h';
  String _result = '';

  void _convert() {
    String inputText = _controller.text;

    if (inputText.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    double input;
    try {
      input = double.parse(inputText);
    } catch (e) {
      setState(() {
        _result = 'Nilai input tidak valid.';
      });
      return;
    }

    double output = 0.0;

    if (_selectedFromUnit == 'm/s') {
      if (_selectedToUnit == 'km/h') {
        output = input * 3.6;
      } else if (_selectedToUnit == 'mph') {
        output = input * 2.237;
      } else if (_selectedToUnit == 'km/s') {
        output = input / 1000;
      } else if (_selectedToUnit == 'in/s') {
        output = input * 39.37;
      } else if (_selectedToUnit == 'Mach') {
        output = input / 343.2;
      } else if (_selectedToUnit == 'c') {
        output = input / 299792458;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'km/h') {
      if (_selectedToUnit == 'm/s') {
        output = input / 3.6;
      } else if (_selectedToUnit == 'mph') {
        output = input / 1.609;
      } else if (_selectedToUnit == 'km/s') {
        output = input / 3600;
      } else if (_selectedToUnit == 'in/s') {
        output = input * 0.02778;
      } else if (_selectedToUnit == 'Mach') {
        output = input / 1225.08;
      } else if (_selectedToUnit == 'c') {
        output = input / 1079252848;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'mph') {
      if (_selectedToUnit == 'm/s') {
        output = input * 0.44704;
      } else if (_selectedToUnit == 'km/h') {
        output = input * 1.609;
      } else if (_selectedToUnit == 'km/s') {
        output = input / 2236.936;
      } else if (_selectedToUnit == 'in/s') {
        output = input * 17.6;
      } else if (_selectedToUnit == 'Mach') {
        output = input / 761.2;
      } else if (_selectedToUnit == 'c') {
        output = input / 670616629;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'km/s') {
      if (_selectedToUnit == 'm/s') {
        output = input * 1000;
      } else if (_selectedToUnit == 'km/h') {
        output = input * 3600;
      } else if (_selectedToUnit == 'mph') {
        output = input * 2236.936;
      } else if (_selectedToUnit == 'in/s') {
        output = input * 39370.079;
      } else if (_selectedToUnit == 'Mach') {
        output = input * 291.6;
      } else if (_selectedToUnit == 'c') {
        output = input * 299792;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'in/s') {
      if (_selectedToUnit == 'm/s') {
        output = input * 0.0254;
      } else if (_selectedToUnit == 'km/h') {
        output = input * 0.09144;
      } else if (_selectedToUnit == 'mph') {
        output = input / 63.36;
      } else if (_selectedToUnit == 'km/s') {
        output = input / 39370.079;
      } else if (_selectedToUnit == 'Mach') {
        output = input / 13500;
      } else if (_selectedToUnit == 'c') {
        output = input / 1181.505;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'Mach') {
      if (_selectedToUnit == 'm/s') {
        output = input * 343.2;
      } else if (_selectedToUnit == 'km/h') {
        output = input * 1225.08;
      } else if (_selectedToUnit == 'mph') {
        output = input * 761.2;
      } else if (_selectedToUnit == 'km/s') {
        output = input * 0.2916;
      } else if (_selectedToUnit == 'in/s') {
        output = input * 13500;
      } else if (_selectedToUnit == 'c') {
        output = input * 0.000001;
      } else {
        output = input;
      }
    } else if (_selectedFromUnit == 'c') {
      if (_selectedToUnit == 'm/s') {
        output = input * 299792458;
      } else if (_selectedToUnit == 'km/h') {
        output = input * 1079252848;
      } else if (_selectedToUnit == 'mph') {
        output = input * 670616629;
      } else if (_selectedToUnit == 'km/s') {
        output = input * 299792;
      } else if (_selectedToUnit == 'in/s') {
        output = input * 1181.505;
      } else if (_selectedToUnit == 'Mach') {
        output = input * 299792458 / 343.2;
      } else {
        output = input;
      }
    }

    setState(() {
      _result = '$output $_selectedToUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Kecepatan'),
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
                  'assets/images/images/konversi_kecepatan.png',
                  height: 250.0,
                ),
              ),
              SizedBox(height: 16),
              // Box for input value
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pinkAccent),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.pinkAccent),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai kecepatan',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Container for dropdown menus
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.purpleAccent),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedFromUnit,
                                decoration: InputDecoration(
                                  labelText: 'Dari',
                                  border: InputBorder.none,
                                ),
                                items: [
                                  'm/s',
                                  'km/h',
                                  'mph',
                                  'km/s',
                                  'in/s',
                                  'Mach',
                                  'c'
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.swap_horiz,
                              size: 30, color: Colors.purple),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.purpleAccent),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedToUnit,
                                decoration: InputDecoration(
                                  labelText: 'Ke',
                                  border: InputBorder.none,
                                ),
                                items: [
                                  'm/s',
                                  'km/h',
                                  'mph',
                                  'km/s',
                                  'in/s',
                                  'Mach',
                                  'c'
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
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _convert,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Konversi'),
                    ),
                    SizedBox(height: 16),
                    // Conditionally display box for result
                    if (_result.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 239, 149),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        child: Text(
                          _result,
                          style: TextStyle(
                              fontSize: 24,
                              color: const Color.fromARGB(255, 0, 0, 0)),
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
