import 'package:flutter/material.dart';
import 'package:ballershaven/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ballershaven/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int? _price;
  int? _stock;
  String _description = "";
  String _thumbnail = "";
  String _category = "Shoes";
  bool _isFeatured = false;

  final List<String> _categories = [
    'Shoes',
    'Jersey',
    'Ball',
    'Accessories',
    'Player',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Product',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // productname
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      hintText: "Enter product name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value ?? "";
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Product name must not be empty!";
                      }
                      if (value.length < 3) {
                        return "Product name must be at least 3 characters!";
                      }
                      return null;
                    },
                  ),
                ),

                // price
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Price",
                      hintText: "Enter product price (in IDR)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _price = int.tryParse(value ?? "");
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Price must not be empty!";
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null) {
                        return "Price must be a number!";
                      }
                      if (parsed <= 0) {
                        return "Price must be greater than 0!";
                      }
                      return null;
                    },
                  ),
                ),

                // description
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter product description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    maxLines: 4,
                    onChanged: (String? value) {
                      setState(() {
                        _description = value ?? "";
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Description must not be empty";
                      }
                      if (value.length < 10) {
                        return "Description must be at least 10 characters!";
                      }
                      return null;
                    },
                  ),
                ),

                // category
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    value: _category,
                    items: _categories
                        .map(
                          (cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue ?? _category;
                      });
                    },
                  ),
                ),

                // url thumbnail
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Thumbnail URL",
                      hintText: "Enter product image URL (optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value ?? "";
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (!value.startsWith('http://') &&
                          !value.startsWith('https://')) {
                        return "Thumbnail URL must start with http:// or https://";
                      }
                      return null;
                    },
                  ),
                ),

                // isfeatured
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SwitchListTile(
                    title: const Text(
                      "Mark as featured product",
                    ),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16.0),

                // save button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
onPressed: () async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        
        final response = await request.postJson(
          "http://localhost:8000/create-flutter/", 
          jsonEncode({
            "name": _name,
            "price": _price,
            "description": _description, 
            "stock": _stock,
            "thumbnail": _thumbnail,
            "category": _category,
            "is_featured": _isFeatured,
          }),
        );
        if (context.mounted) {
          if (response['status'] == 'success') { 
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Produk baru berhasil ditambahkan!")));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal menambahkan produk: ${response['message'] ?? 'Unknown error'}")));
          }
        }
      }
    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
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
