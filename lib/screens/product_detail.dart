import 'package:flutter/material.dart';
import 'package:ballershaven/models/product_entry.dart';

class DetailProductPage extends StatelessWidget {
  final ProductEntry productEntry;
  const DetailProductPage({super.key, required this.productEntry});


  @override
  Widget build(BuildContext context) {
    final fields = productEntry.fields; 
    final imageUrl = 'http://localhost:8000/main/proxy-image/?url=${Uri.encodeComponent(fields.thumbnail)}';

    return Scaffold(
      appBar: AppBar(
        title: Text(fields.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fields.thumbnail.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (fields.isFeatured)
                    Container(
                      child: const Text('Featured',),
                    ),

                  Text(fields.name, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  Text('Kategori: ${fields.category}'),
                  Text('Harga: Rp ${fields.price}'),
                  Text('Stok: ${fields.stock}'),
                  Text('User ID Penjual: ${fields.user}'),
                  
                  const Divider(height: 32),

                  Text(fields.description, style: const TextStyle(fontSize: 16.0, height: 1.6), textAlign: TextAlign.justify),
                  const SizedBox(height: 24),
                  
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Kembali ke Daftar Item"),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}