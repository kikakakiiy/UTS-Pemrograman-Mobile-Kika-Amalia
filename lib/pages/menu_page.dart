import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/cake_tile.dart';
import '../models/cake.dart';
import '../pages/cake_details_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Cake menu
  List<Cake> cakeMenu = [
    Cake(
      name: "DMoon Cake",
      price: 300000,
      imagePath: "lib/images/11.png",
      rating: "5.0",
      description: "Delicious DMoon Cake with a soft and fluffy texture.",
    ),
    Cake(
      name: "Renew Cake",
      price: 200000,
      imagePath: "lib/images/7.png",
      rating: "4.9",
      description: "Renew Cake that renews your taste buds with every bite.",
    ),
    Cake(
      name: "Coco Cake",
      price: 250000,
      imagePath: "lib/images/8.png",
      rating: "4.9",
      description: "Rich and moist Coco Cake, a treat for chocolate lovers.",
    ),
    Cake(
      name: "Dblue Cake",
      price: 200000,
      imagePath: "lib/images/13.png",
      rating: "4.8",
      description: "Blue Cake with a delightful blueberry flavor.",
    ),
  ];

  List<Cake> popularFood = [
    Cake(
      name: "Hi Sky Cake",
      price: 220000,
      imagePath: "lib/images/14.png",
      rating: "4.9",
      description: "Hi Sky Cake that takes you to the skies with its taste.",
    ),
    Cake(
      name: "Strawberry Cake",
      price: 220000,
      imagePath: "lib/images/4.png",
      rating: "4.7",
      description: "Strawberry Cake with fresh and juicy strawberries.",
    ),
  ];

  List<Cake> _searchResultsCakeMenu = [];
  List<Cake> _searchResultsPopularFood = [];

  @override
  void initState() {
    super.initState();
    _searchResultsCakeMenu = cakeMenu;
    _searchResultsPopularFood = popularFood;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchResultsCakeMenu = cakeMenu
          .where(
              (cake) => cake.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _searchResultsPopularFood = popularFood
          .where(
              (cake) => cake.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void navigateToCakeDetails(Cake cake) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CakeDetailsPage(
          cake: cake,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 194, 250),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.grey[900],
        ),
        title: Text(
          'Cake',
          style: TextStyle(color: Colors.grey[900]),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promo banner
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 83, 44, 109),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Message new cake
                      Text(
                        'Get a New Cake!',
                        style: GoogleFonts.dmSerifDisplay(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Buy a new cake
                      MyButton(
                        text: "Buy Cake",
                        onTap: () {},
                      ),
                    ],
                  ),
                  // Image
                  Image.asset(
                    'lib/images/img4.png',
                    height: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return cakeMenu.map((cake) => cake.name).where((name) => name
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selected) {
                  _onSearchChanged(selected);
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  fieldTextController.addListener(() {
                    _onSearchChanged(fieldTextController.text);
                  });
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: fieldTextController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 147, 142, 151),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 147, 142, 151),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Search Here...",
                      ),
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Color.fromARGB(255, 238, 180, 193),
                      borderRadius: BorderRadius.circular(20),
                      elevation: 4,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                          maxWidth: MediaQuery.of(context).size.width - 50,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: options.map((String option) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                title: Text(option),
                                onTap: () {
                                  onSelected(option);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Cake Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Cake Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 290,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _searchResultsCakeMenu.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    width: 200,
                    child: CakeTile(
                      cake: _searchResultsCakeMenu[index],
                      onTap: () =>
                          navigateToCakeDetails(_searchResultsCakeMenu[index]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Popular Cake
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Popular Cake",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _searchResultsPopularFood.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () =>
                    navigateToCakeDetails(_searchResultsPopularFood[index]),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Image
                          Image.asset(
                            _searchResultsPopularFood[index].imagePath,
                            height: 60,
                          ),
                          const SizedBox(width: 20),
                          // Name and price
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              Text(
                                _searchResultsPopularFood[index].name,
                                style: GoogleFonts.dmSerifDisplay(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Rp${_searchResultsPopularFood[index].price.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
