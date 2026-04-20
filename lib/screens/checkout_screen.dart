import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  const CheckoutScreen({super.key, required this.cart});

  int get total {
    int sum = 0;
    for (var item in cart) {
      sum += (item["price"] as int) * (item["qty"] as int);
    }
    return sum;
  }

  void pay(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful 🎉"),
        content: const Text("Your order has been placed"),
        actions: [
          TextButton(
            onPressed: () {
              cart.clear(); // 🧹 تفريغ السلة

              Navigator.pop(context); // dialog
              Navigator.pop(context); // back Home
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? const Color(0xFF121212) : Colors.grey[100],

      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: dark ? const Color(0xFF1E1E1E) : Colors.orange,
      ),

      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, i) {
          final item = cart[i];

          return Card(
            color: dark ? const Color(0xFF1E1E1E) : Colors.white,
            child: ListTile(
              title: Text(
                item["name"],
                style: TextStyle(
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                "Qty: ${item["qty"]}",
                style: TextStyle(
                  color: dark ? Colors.grey : Colors.grey,
                ),
              ),
              trailing: Text(
                "${item["price"] * item["qty"]} EGP",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: dark ? const Color(0xFF1E1E1E) : Colors.orange,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Total: $total EGP",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () => pay(context),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}