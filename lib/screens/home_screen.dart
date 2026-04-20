import 'package:flutter/material.dart';
import 'store_screen.dart';
import 'checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> cart = [];
  String searchText = "";

  final List<Map<String, dynamic>> foods = const [
    {"name": "Burger", "price": 100, "image": "assets/images/img_1.png"},
    {"name": "Pizza", "price": 200, "image": "assets/images/img_2.png"},
    {"name": "Drinks", "price": 75, "image": "assets/images/img_3.png"},
  ];

  List<Map<String, dynamic>> get filteredFoods {
    if (searchText.isEmpty) return foods;

    return foods.where((food) {
      return food["name"]
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();
  }

  void addToCart(Map<String, dynamic> food) {
    setState(() {
      int index = cart.indexWhere((e) => e["name"] == food["name"]);

      if (index != -1) {
        cart[index]["qty"]++;
      } else {
        cart.add({
          "name": food["name"],
          "price": food["price"],
          "qty": 1,
        });
      }
    });
  }

  Widget buildImage(String path) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: Image.asset(
        path,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = widget.isDark;

    return Scaffold(
      backgroundColor: dark ? const Color(0xFF121212) : Colors.grey[100],

      appBar: AppBar(
        title: const Text("🍔 Food App"),
        backgroundColor: dark ? const Color(0xFF1E1E1E) : Colors.orange,

        actions: [
          // 🌙 DARK MODE
          IconButton(
            icon: Icon(
              dark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: widget.onToggleTheme,
          ),

          // 🛒 CART
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoreScreen(cart: cart),
                    ),
                  ).then((_) {
                    setState(() {}); // refresh بعد الرجوع
                  });
                },
              ),

              // 🔴 BADGE
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${cart.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // 💳 CHECKOUT
          IconButton(
            icon: const Icon(Icons.payment, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(cart: cart),
                ),
              ).then((_) {
                setState(() {}); // مهم لتحديث الـ badge
              });
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              style: TextStyle(
                color: dark ? Colors.white : Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search food...",
                hintStyle: TextStyle(
                  color: dark ? Colors.grey[400] : Colors.grey,
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: dark ? const Color(0xFF1E1E1E) : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🍔 LIST
          Expanded(
            child: ListView.builder(
              itemCount: filteredFoods.length,
              itemBuilder: (context, i) {
                final food = filteredFoods[i];

                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: dark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Column(
                    children: [
                      buildImage(food["image"]),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              food["name"],
                              style: TextStyle(
                                color: dark ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${food["price"]} EGP",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () => addToCart(food),
                        child: const Text(
                          "Add +",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}