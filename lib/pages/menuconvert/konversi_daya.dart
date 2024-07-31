import 'package:flutter/material.dart';

class KonversiDayaPage extends StatefulWidget {
  @override
  _KonversiDayaPageState createState() => _KonversiDayaPageState();
}

class _KonversiDayaPageState extends State<KonversiDayaPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'Watt';
  String _selectedToUnit = 'kW';
  String _result = '';
  String _conversionProcess = '';

  static const Map<String, double> unitConversion = {
    'Watt': 1.0,
    'kW': 1000.0,
    'MW': 1e6,
    'HP': 745.7,
    'BTU/h': 3.414,
    'J/s': 1.0,
    'BTU/s': 3.414,
    'PS': 735.5,
    'kg·m/s': 9.80665,
    'kcal/s': 4184.0,
    'ft·lbf/s': 1.35582,
    'Nm/s': 1.0,
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

    double inputInWatts = input * unitConversion[_selectedFromUnit]!;
    double output = inputInWatts / unitConversion[_selectedToUnit]!;

    String explanation = '$input $_selectedFromUnit = $inputInWatts watt.\n';
    explanation += '$inputInWatts watt = $output $_selectedToUnit.';

    setState(() {
      _result = '$output $_selectedToUnit';
      _conversionProcess = explanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Daya'),
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
                  'assets/images/images/konversi_daya.png', // Adjust the path according to your asset structure
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
                        color: Color.fromARGB(255, 253, 255, 211),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai daya',
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
                                  color: Colors.orange[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.orangeAccent),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.swap_horiz,
                              color: Colors.purpleAccent,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
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
                      child: Text('Konversi'),
                    ),
                    SizedBox(height: 16),
                    // Conditionally display box for result
                    if (_result.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 182, 182),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color.fromARGB(255, 255, 46, 46)),
                        ),
                        child: Text(
                          _result,
                          style: TextStyle(
                              fontSize: 24,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    SizedBox(height: 16),
                    // Box for conversion process explanation
                    if (_conversionProcess.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 236, 173),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 217, 0)),
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
