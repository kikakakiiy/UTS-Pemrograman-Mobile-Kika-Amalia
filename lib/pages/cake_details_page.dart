import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart'; // Untuk CupertinoIcons
//import 'package:fluttertoast/fluttertoast.dart'; // Import untuk toast
import '../models/cake.dart'; // Pastikan path ini sesuai dengan struktur proyek Anda
import '../pages/checkout_page.dart';
import '../pages/toast_helper.dart'; // Import halaman Checkout

class CakeDetailsPage extends StatefulWidget {
  final Cake cake;
  const CakeDetailsPage({Key? key, required this.cake}) : super(key: key);

  @override
  _CakeDetailsPageState createState() => _CakeDetailsPageState();
}

class _CakeDetailsPageState extends State<CakeDetailsPage> {
  final List<Map<String, String>> additional = [
    {'image': 'lib/images/img2.png', 'name': 'Box'},
    {'image': 'lib/images/img1.png', 'name': 'Knife'},
    {'image': 'lib/images/img5.png', 'name': 'Candle'},
  ];

  final List<String> additionalItems = [];
  int quantity = 1; // Start with 1 quantity
  bool isAddedToCart = false;
  bool showNotification = false;
  bool isFavorite = false; // State for favorite status

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        // Minimum quantity should be 1
        quantity--;
      }
    });
  }

  void _addToCart() {
    setState(() {
      isAddedToCart = true;
      showNotification = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showNotification = false;
        });
      }
    });
  }

  // void _toggleFavorite() {
  //   setState(() {
  //     isFavorite = !isFavorite;
  //   });

  //   //showToastUnderFavoriteIcon();
  // }

  void _navigateToCheckout() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          cakes: [
            {
              'cake': widget.cake,
              'quantity': quantity,
              'additionalItems': additionalItems,
            }
          ],
        ),
      ),
    );
  }

  // void showToastUnderFavoriteIcon() {
  //   // Menampilkan toast dengan sedikit delay agar muncul di bawah ikon favorit
  //   Future.delayed(Duration(milliseconds: 300), () {
  //     Fluttertoast.showToast(
  //       msg: isFavorite ? "Added to Favorites" : "Removed from Favorites",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.black.withOpacity(0.8),
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   });
  // }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      showToastUnderFavoriteIcon(context, isFavorite); // Tampilkan toast
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color background = Color.fromARGB(255, 68, 39, 86);
    final Color yellow = Color.fromARGB(255, 217, 192, 49);
    final Color orange = Color.fromARGB(255, 195, 119, 6);
    final double iconSize = 24.0; // Ukuran ikon yang sama
    final double iconContainerSize = 40.0; // Ukuran lingkaran

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Cake Detail',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // Icon Shopping Cart
          Container(
            width: iconContainerSize, // Menetapkan ukuran lingkaran
            height: iconContainerSize, // Menetapkan ukuran lingkaran
            padding: EdgeInsets.all(8.0), // Padding di dalam lingkaran
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.shopping_cart,
                color: isAddedToCart ? Colors.green : Colors.white,
                size: iconSize, // Set ukuran ikon
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Icon Favorite
          Container(
            width: iconContainerSize, // Menetapkan ukuran lingkaran
            height: iconContainerSize, // Menetapkan ukuran lingkaran
            padding: EdgeInsets.all(1.0), // Padding di dalam lingkaran
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color:
                      isFavorite ? Colors.red : Colors.white.withOpacity(0.5),
                  size: iconSize, // Set ukuran ikon
                ),
                onPressed: _toggleFavorite, // Menangani klik ikon favorit
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: background,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130),
                    Center(
                      child: Image.asset(
                        widget.cake.imagePath,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${widget.cake.rating}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 24,
                        ),
                      ],
                    ),
                    Text(
                      widget.cake.description,
                      style: TextStyle(
                        color: Color.fromARGB(255, 244, 234, 250),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Price: Rp${widget.cake.price}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: yellow,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    CupertinoIcons.share_up,
                                    size: 26,
                                    color: Colors.white,
                                  ),
                                  onPressed:
                                      _navigateToCheckout, // Navigasi ke halaman Checkout
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: _addToCart,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Additional',
                        style: GoogleFonts.dmSerifDisplay(
                          color: Color.fromARGB(255, 244, 234, 250),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 700,
                      child: PageView.builder(
                        itemCount: additional.length,
                        controller: PageController(viewportFraction: .6),
                        padEnds: false,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          final isSelected = additionalItems
                              .contains(additional[index]['name']);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    additionalItems
                                        .remove(additional[index]['name']);
                                  } else {
                                    additionalItems
                                        .add(additional[index]['name']!);
                                  }
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isSelected
                                            ? Color.fromARGB(255, 255, 253,
                                                194) // Warna border saat item dipilih
                                            : Colors
                                                .transparent, // Warna border saat item tidak dipilih
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 5,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          additional[index]['image']!,
                                          width: 100,
                                          height: 100,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          additional[index]['name']!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 5, // Posisi di bawah AppBar
            right: 50,
            child: Visibility(
              visible: showNotification,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 60, 57, 57).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Add to cart',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40, // Ubah dari 1 menjadi 40
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cake.name,
                  style: TextStyle(
                    color: Color.fromARGB(255, 244, 234, 250),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'TO ENJOY',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 244, 234, 250),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 385,
            right: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 206, 177, 248),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 20),
                    onPressed: _decreaseQuantity,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$quantity',
                    style: GoogleFonts.dmSerifDisplay(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: _increaseQuantity,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 5, // Posisi toast favorit
          //   right: 50,
          //   child: Visibility(
          //     visible: isFavorite,
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          //       decoration: BoxDecoration(
          //         color: const Color.fromARGB(255, 60, 57, 57).withOpacity(0.8),
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       child: Text(
          //         isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
          //         style: TextStyle(color: Colors.white, fontSize: 16),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
