import 'package:flutter/material.dart';

class KonversiBilanganPage extends StatefulWidget {
  @override
  _KonversiBilanganPageState createState() => _KonversiBilanganPageState();
}

class _KonversiBilanganPageState extends State<KonversiBilanganPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFromUnit = 'Desimal';
  String _decimalResult = 'Invalid';
  String _binaryResult = 'Invalid';
  String _octalResult = 'Invalid';
  String _hexadecimalResult = 'Invalid';

  void _convert() {
    String input = _controller.text;
    int decimalValue;

    try {
      if (_selectedFromUnit == 'Desimal') {
        decimalValue = int.parse(input);
      } else if (_selectedFromUnit == 'Biner') {
        decimalValue = int.parse(input, radix: 2);
      } else if (_selectedFromUnit == 'Hexadesimal') {
        decimalValue = int.parse(input, radix: 16);
      } else {
        decimalValue = int.parse(input, radix: 8);
      }

      setState(() {
        _decimalResult = decimalValue.toString();
        _binaryResult = decimalValue.toRadixString(2);
        _octalResult = decimalValue.toRadixString(8);
        _hexadecimalResult = decimalValue.toRadixString(16).toUpperCase();
      });
    } catch (e) {
      setState(() {
        _decimalResult = 'Invalid';
        _binaryResult = 'Invalid';
        _octalResult = 'Invalid';
        _hexadecimalResult = 'Invalid';
      });
    }
  }

  void _clearAllFields() {
    _controller.clear();
    setState(() {
      _decimalResult = 'Invalid';
      _binaryResult = 'Invalid';
      _octalResult = 'Invalid';
      _hexadecimalResult = 'Invalid';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Bilangan'),
        backgroundColor:
            Color.fromARGB(255, 252, 214, 132), // Warna app bar coklat
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[100], // Coklat muda
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Masukkan nilai bilangan',
                      labelStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Membuat dropdown lebih kecil
                  decoration: BoxDecoration(
                    color: Colors.brown[100], // Coklat muda
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedFromUnit,
                    dropdownColor:
                        Colors.brown[100], // Warna background dropdown box
                    decoration: InputDecoration(
                      labelText: 'Dari',
                      labelStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    items: ['Desimal', 'Biner', 'Hexadesimal', 'Oktal']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.brown[100], // Warna pink
                            borderRadius:
                                BorderRadius.circular(8.0), // Sudut melengkung
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal:
                                  20.0), // Menambahkan padding untuk isi
                          child: Text(value),
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
              SizedBox(height: 16),
              Image.asset(
                'assets/images/images/hasil1.png',
                width: 200, // Ubah ukuran lebar sesuai kebutuhan
                height: 200, // Ubah ukuran tinggi sesuai kebutuhan
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: _convert,
                  child: Text('Konversi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 229, 196, 183),
                    // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildResultRow('Desimal', _decimalResult),
              _buildResultRow('Biner', _binaryResult),
              _buildResultRow('Oktal', _octalResult),
              _buildResultRow('Hexadesimal', _hexadecimalResult),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: _clearAllFields,
                  child: Text('Kosongkan Semua Isian'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 255, 209, 110), // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[50], // Coklat muda
          border: Border.all(color: Colors.brown[300]!),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2, // Lebar kolom label diperluas
              child: Text('$label:', style: TextStyle(fontSize: 16)),
            ),
            Expanded(
              flex: 3,
              child: Text(result, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
