import 'package:flutter/material.dart';

class KonversiPanjangPage extends StatefulWidget {
  @override
  _KonversiPanjangPageState createState() => _KonversiPanjangPageState();
}

class _KonversiPanjangPageState extends State<KonversiPanjangPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'Kilometer';
  String _selectedToUnit = 'Meter';
  String _result = '';
  String _conversionProcess = '';

  static const Map<String, double> unitConversion = {
    'Kilometer': 1000.0,
    'Hektameter': 100.0,
    'Dekameter': 10.0,
    'Meter': 1.0,
    'Desimeter': 0.1,
    'Sentimeter': 0.01,
    'Milimeter': 0.001,
    'Nanometer': 1e-9,
    'Mikrometer': 1e-6,
  };

  void _convert() {
    double input = double.parse(_controller.text);
    double inputInMeters = input * unitConversion[_selectedFromUnit]!;
    double output = inputInMeters / unitConversion[_selectedToUnit]!;

    String explanation = '$input $_selectedFromUnit = $inputInMeters meter.\n';
    explanation += '$inputInMeters meter = $output $_selectedToUnit.';

    setState(() {
      _result = '$output $_selectedToUnit';
      _conversionProcess = explanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Panjang'),
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
                  'assets/images/images/konversi_panjang.png', // Adjust the path according to your asset structure
                  height: 200.0, // Adjust height as needed
                ),
              ),
              SizedBox(height: 16),
              // Box for input value
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 77, 130),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 172, 218, 230),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 254, 249, 200)),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Masukkan nilai panjang',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Container for dropdown menus
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 251, 227),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Color.fromARGB(255, 59, 9, 9)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: DropdownButtonFormField<String>(
                              value: _selectedFromUnit,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.0),
                                labelText: 'Dari',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
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
                          SizedBox(height: 16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: DropdownButtonFormField<String>(
                              value: _selectedToUnit,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.0),
                                labelText: 'Ke',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
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
                        ],
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
              // Box for result
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 209, 187),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hasil:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _result,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Box for conversion process
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 206, 206),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Proses Konversi:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _conversionProcess,
                      style: TextStyle(fontSize: 20),
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
