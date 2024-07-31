import 'package:flutter/material.dart';

class KonversiMataUangPage extends StatefulWidget {
  @override
  _KonversiMataUangPageState createState() => _KonversiMataUangPageState();
}

class _KonversiMataUangPageState extends State<KonversiMataUangPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'USD';
  String _selectedToUnit = 'IDR';
  String _result = '';

  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'GBP': 0.75,
    'IDR': 14350.0,
    'KRW': 1150.0,
    'MYR': 4.2,
    'PHP': 50.0,
  };

  final Map<String, String> _currencyFlags = {
    'USD': 'us',
    'GBP': 'gb',
    'IDR': 'id',
    'KRW': 'kr',
    'MYR': 'my',
    'PHP': 'ph',
  };

  void _convert() {
    double input = double.parse(_controller.text);
    double rateFrom = _exchangeRates[_selectedFromUnit]!;
    double rateTo = _exchangeRates[_selectedToUnit]!;
    double output = (input / rateFrom) * rateTo;

    setState(() {
      _result = '$output $_selectedToUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
        backgroundColor: Color.fromARGB(255, 252, 214, 132),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Tambahan Gambar di atas
            Center(
              child: Image.asset(
                'assets/images/images/holidays.png', // Ganti URL dengan gambar yang diinginkan
                height: 220, // Ukuran tinggi gambar
                width: double
                    .infinity, // Memperluas lebar gambar hingga memenuhi kontainer
                fit: BoxFit
                    .cover, // Menjaga proporsi gambar dan mengisi area yang tersedia
              ),
            ),
            SizedBox(height: 16),
            // Container untuk semua elemen di bawah gambar
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Input Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 196, 235, 146), // Warna background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Masukkan nilai mata uang',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Dropdown Dari
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                                255, 239, 202, 137), // Warna background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedFromUnit,
                            decoration: InputDecoration(
                              labelText: 'Dari',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            items: _exchangeRates.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'icons/flags/png/${_currencyFlags[value]}.png',
                                      package: 'country_icons',
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(value),
                                  ],
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
                      // Icon Bolak-Balik
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // Tukar mata uang dari dan ke
                              String temp = _selectedFromUnit;
                              _selectedFromUnit = _selectedToUnit;
                              _selectedToUnit = temp;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 44, 87, 161),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.swap_horiz,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      // Dropdown Ke
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                255, 255, 174, 186), // Warna background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedToUnit,
                            decoration: InputDecoration(
                              labelText: 'Ke',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            items: _exchangeRates.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'icons/flags/png/${_currencyFlags[value]}.png',
                                      package: 'country_icons',
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(value),
                                  ],
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
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _convert,
                    child: Text('Konversi'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
