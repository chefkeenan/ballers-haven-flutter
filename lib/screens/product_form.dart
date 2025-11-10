import 'package:flutter/material.dart';
import 'package:ballershaven/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int? _price;
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  const Text('Product saved successfully'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $_name'),
                                    Text('Price: $_price'),
                                    Text('Description: $_description'),
                                    Text('Category: $_category'),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text(
                                      'Featured: ${_isFeatured ? "Yes" : "No"}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _name = "";
                                      _price = null;
                                      _description = "";
                                      _thumbnail = "";
                                      _category = "Shoes";
                                      _isFeatured = false;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
