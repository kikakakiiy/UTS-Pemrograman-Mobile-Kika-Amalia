import 'package:flutter/material.dart';

class PerhitunganDiskonPage extends StatefulWidget {
  @override
  _PerhitunganDiskonPageState createState() => _PerhitunganDiskonPageState();
}

class _PerhitunganDiskonPageState extends State<PerhitunganDiskonPage> {
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _diskonController = TextEditingController();
  String _hargaSetelahDiskon = '';
  String _jumlahDiskon = '';

  void _hitungDiskon() {
    double harga = double.parse(_hargaController.text);
    double diskon = double.parse(_diskonController.text);

    double jumlahDiskon = harga * (diskon / 100);
    double hargaSetelahDiskon = harga - jumlahDiskon;

    setState(() {
      _hargaSetelahDiskon = 'Rp${hargaSetelahDiskon.toStringAsFixed(2)}';
      _jumlahDiskon = 'Rp${jumlahDiskon.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan Diskon'),
        backgroundColor:
            Color.fromARGB(255, 252, 214, 132), // Set AppBar color to orange
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/images/19.png', // Ganti dengan path gambar Anda
                height: 300, // Sesuaikan tinggi gambar sesuai kebutuhan
              ),
              SizedBox(height: 16),
              TextField(
                controller: _hargaController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Harga',
                  filled: true,
                  fillColor: Colors.purple[50], // Pastel purple
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _diskonController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Diskon (%)',
                  filled: true,
                  fillColor: Colors.purple[50], // Pastel purple
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _hitungDiskon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400], // Pastel pink
                ),
                child: Text(
                  'Hitung Diskon',
                  style: TextStyle(color: Colors.black), // Text color black
                ),
              ),
              SizedBox(height: 16),
              if (_hargaSetelahDiskon.isNotEmpty && _jumlahDiskon.isNotEmpty)
                Column(
                  children: [
                    _buildResultBox('Hasil Harga', _hargaSetelahDiskon),
                    SizedBox(height: 16),
                    _buildResultBox('Diskon', _jumlahDiskon),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultBox(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[50], // Pastel purple
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.purple[200]!), // Lighter pastel purple
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
