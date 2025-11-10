## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() menambahkan halaman baru di atas halaman saat ini (seperti menambahkan tumpukan ke atas stack) sehingga pengguna masih bisa kembali dengan tombol back. Contohnya pada tugas ini, cocok untuk tombol “Create/Add Product” dari halaman utama menuju halaman form.

Navigator.pushReplacement() mengganti halaman saat ini dan menghapusnya dari stack, jadi tombol back tidak akan kembali ke halaman sebelumnya. Contoh penggunaan pada tugas ini adalah dipakai di drawer saat pindah ke home atau add Product supaya navigasi tidak menumpuk halaman.

## Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Pada tugas ini, setiap halaman utama dibangun di atas hierarchy widget ini:
Scaffold -> AppBar -> Drawer -> body. 

Scaffold menjadi kerangka utama yang menyediakan slot untuk AppBar, Drawer, dan isi halaman (body), sehingga semua halaman memiliki struktur dasar yang seragam. Dengan begitu, ketika berpindah dari halaman home ke halaman add product, pengguna tetap mengenali pola yang sama: posisi appBar di atas, menu navigasi di Drawer di sisi kiri, dan konten utama di tengah.

AppBar digunakan untuk menampilkan judul aplikasi "Baller’s Haven" atau judul halaman seperti "Add Product". Drawer didefinisikan sebagai widget terpisah (LeftDrawer) dan digunakan di beberapa halaman (Home dan ProductFormPage), sehingga navigasi ke bagian halaman utama dan tambah produk memiliki tampilan dan perilaku yang sama.

##  Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Padding dipakai untuk memberi jarak antar komponen, pada tugas ini contohnya ada jarak antar field Product Name, Price, dan Description, sehingga form lebih rapi dan mudah dibaca.

SingleChildScrollView membungkus Column agar form bisa di-scroll dan tidak menimbulkan error overflow pada layar yang kecil, contohnya di tugas ini pada form ProductFormPage.

ListView adalah widget Flutter untuk menampilkan daftar elemen yang bisa di-scroll (misalnya list produk). 

## Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Warna tema aplikasi ini diatur di MaterialApp menggunakan ThemeData dan ColorScheme, misalnya primarySwatch: Colors.blue dan secondary: Colors.blueAccent[400].
AppBar dan tombol seperti Save mengambil warna dari Theme.of(context).colorScheme.primary, sehingga seluruh halaman konsisten dan mencerminkan identitas visual brand toko.