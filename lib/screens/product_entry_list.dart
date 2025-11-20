import 'package:flutter/material.dart';
import 'package:ballershaven/models/product_entry.dart';
import 'package:ballershaven/widgets/left_drawer.dart';
import 'package:ballershaven/screens/product_detail.dart';
import 'package:ballershaven/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool filterByMe = false;

  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    String url = 'http://localhost:8000/json/';

    if (filterByMe) {
      url = 'http://localhost:8000/json/?filter=my';
    }

    final response = await request.get(url);
    var data = response as List<dynamic>;

    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Column(
        children: [
          SwitchListTile(
            title: const Text("Tampilkan Produk Saya Saja"),
            value: filterByMe,
            onChanged: (bool value) {
              setState(() {
                filterByMe = value;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Tidak ada produk."));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => ProductEntryCard(
                      productEntry: snapshot.data![index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProductPage(
                              productEntry:
                                  snapshot.data![index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
