import 'package:flutter/material.dart';
import 'package:ballershaven/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry productEntry;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.productEntry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fields = productEntry.fields;

    final imageUrl =
        'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(fields.thumbnail)}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  fields.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                Text('Harga: Rp ${fields.price}'),
                Text('Kategori: ${fields.category}'),
                const SizedBox(height: 6),

                Text(
                  fields.description.length > 100
                      ? '${fields.description.substring(0, 100)}...'
                      : fields.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),

                if (fields.isFeatured)
                  const Text(
                    'Featured',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
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
