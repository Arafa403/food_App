import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const StoreScreen({super.key, required this.cart});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  void inc(int i) => setState(() => widget.cart[i]["qty"]++);
  void dec(int i) {
    setState(() {
      if (widget.cart[i]["qty"] > 1) {
        widget.cart[i]["qty"]--;
      } else {
        widget.cart.removeAt(i);
      }
    });
  }

  void del(int i) => setState(() => widget.cart.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🛒 Cart")),

      body: widget.cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (context, i) {
          final item = widget.cart[i];

          return Card(
            child: ListTile(
              title: Text(item["name"]),
              subtitle: Text("${item["price"]} EGP"),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => dec(i),
                  ),
                  Text("${item["qty"]}"),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => inc(i),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => del(i),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}