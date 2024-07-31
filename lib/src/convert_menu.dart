import 'package:flutter/material.dart';
import 'package:flutter_apputskika2/pages/menuconvert/bmicalculator.dart';
import 'package:flutter_apputskika2/pages/calculator_isi.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_area.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_berat.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_bilangan.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_panjang.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_volume.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_suhu.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_kecepatan.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_daya.dart';
import 'package:flutter_apputskika2/pages/menuconvert/konversi_matauang.dart';
import 'package:flutter_apputskika2/pages/menuconvert/perhitungan_diskon.dart';

void main() {
  runApp(MyAppConvert());
}

class MyAppConvert extends StatelessWidget {
  final Map<int, Color> yellowPastel = {
    50: Color.fromRGBO(255, 249, 193, .1),
    100: Color.fromRGBO(255, 249, 193, .2),
    200: Color.fromRGBO(255, 249, 193, .3),
    300: Color.fromRGBO(255, 249, 193, .4),
    400: Color.fromRGBO(255, 249, 193, .5),
    500: Color.fromRGBO(255, 249, 193, .6),
    600: Color.fromRGBO(255, 249, 193, .7),
    700: Color.fromRGBO(255, 249, 193, .8),
    800: Color.fromRGBO(255, 249, 193, .9),
    900: Color.fromRGBO(255, 249, 193, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konversi Aplikasi',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFFFF9C1, yellowPastel),
        scaffoldBackgroundColor: Color(0xFFFFF9C1),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kika MyApp'),
        backgroundColor: Color(0xFFFFF9C1),
      ),
      endDrawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Konversi Pro',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/images/images/welcome.png',
              height: 250,
            ),
            SizedBox(height: 30),
            Text(
              'Aplikasi konversi perhitungan terlengkap!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Color.fromARGB(255, 255, 187, 13),
                foregroundColor: Colors.white,
              ).copyWith(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color.fromARGB(
                          255, 236, 186, 37); // Color when pressed
                    }
                    return Color.fromARGB(255, 95, 89, 73); // Default color
                  },
                ),
              ),
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Konversi'),
        backgroundColor: Color.fromARGB(255, 252, 214, 132),
      ),
      endDrawer: CustomDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: <Widget>[
          ImageButton(
            imagePath: 'assets/images/images/calculator.png',
            title: 'Kalkulator',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorIsiPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_bilangan.png',
            title: 'Konversi Bilangan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiBilanganPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/bmi.png',
            title: 'BMI',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BMIPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/perhitungan_diskon.png',
            title: 'Diskon',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PerhitunganDiskonPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_mata_uang.png',
            title: 'Mata Uang',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiMataUangPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_suhu.png',
            title: 'Suhu',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiSuhuPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_kecepatan.png',
            title: 'Kecepatan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => KonversiKecepatanPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_panjang.png',
            title: 'Panjang',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiPanjangPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_area.png',
            title: 'Area',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiAreaPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_volume.png',
            title: 'Volume',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiVolumePage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_daya.png',
            title: 'Daya',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiDayaPage()),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/images/images/konversi_berat.png',
            title: 'Berat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiBeratPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onPressed;

  ImageButton(
      {required this.imagePath, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Color.fromARGB(255, 112, 71, 95),
          highlightColor: Color.fromARGB(255, 112, 71, 95).withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<DrawerItem> drawerItems = [
    DrawerItem(
        icon: Icons.calculate, text: 'Kalkulator', page: CalculatorIsiPage()),
    DrawerItem(
        icon: Icons.swap_horiz,
        text: 'Konversi Bilangan',
        page: KonversiBilanganPage()),
    DrawerItem(icon: Icons.height, text: 'BMI', page: BMIPage()),
    DrawerItem(
        icon: Icons.percent, text: 'Diskon', page: PerhitunganDiskonPage()),
    DrawerItem(
        icon: Icons.money, text: 'Mata Uang', page: KonversiMataUangPage()),
    DrawerItem(icon: Icons.thermostat, text: 'Suhu', page: KonversiSuhuPage()),
    DrawerItem(
        icon: Icons.speed, text: 'Kecepatan', page: KonversiKecepatanPage()),
    DrawerItem(
        icon: Icons.square_foot, text: 'Panjang', page: KonversiPanjangPage()),
    DrawerItem(icon: Icons.crop_square, text: 'Area', page: KonversiAreaPage()),
    DrawerItem(
        icon: Icons.view_in_ar, text: 'Volume', page: KonversiVolumePage()),
    DrawerItem(icon: Icons.flash_on, text: 'Daya', page: KonversiDayaPage()),
    DrawerItem(
        icon: Icons.line_weight, text: 'Berat', page: KonversiBeratPage()),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> filteredItems = drawerItems
        .where((item) =>
            item.text.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            color: Color.fromARGB(255, 252, 214, 132),
            height: 350,
            child: Column(
              children: [
                // Add an image here
                Image.asset(
                  'assets/images/s4.png', // Ganti dengan path gambar Anda
                  width: double.infinity,
                  height: 250, // Atur tinggi gambar sesuai kebutuhan
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.0), // Spasi antara gambar dan TextField
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Cari...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: filteredItems.map((item) {
                return CustomDrawerItem(
                  icon: item.icon,
                  text: item.text,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item.page),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String text;
  final Widget page;

  DrawerItem({required this.icon, required this.text, required this.page});
}

class CustomDrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;

  CustomDrawerItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
