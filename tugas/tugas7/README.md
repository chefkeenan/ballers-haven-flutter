## Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget tree adalah struktur hierarki yang menggambarkan bagaimana setiap widget tersusun dan saling membungkus satu sama lain di layar. Setiap elemen UI di Flutter adalah widget, mulai dari teks, tombol, hingga layout seperti row dan column.

Hubungan parent–child bekerja dengan cara di mana widget parent membungkus widget lain di dalamnya, sedangkan widget child mengikuti aturan tata letak dan properti dari parent-nya. Contohnya, column adalah parent yang menyusun beberapa child secara vertikal, seperti text dan GridView.

## Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

| Widget | Fungsi |
|---------|--------|
| **MaterialApp** | Root widget untuk mengatur tema, navigasi, dan struktur global aplikasi. |
| **Scaffold** | Menyediakan struktur dasar halaman (seperti AppBar dan Body). |
| **AppBar** | Bagian atas yang menampilkan judul aplikasi “Baller’s Haven”. |
| **Text** | Menampilkan teks untuk nama, NPM, dan kelas|
| **Padding** | Memberikan jarak di sekitar widget untuk merapihkan. |
| **Column** | Menyusun widget secara vertikal dari atas ke bawah. |
| **Row** | Menyusun widget secara horizontal (misalnya tiga InfoCard berdampingan). |
| **SizedBox** | Memberi jarak antar widget secara vertikal. |
| **Center** | Menempatkan widget di posisi tengah layar. |
| **GridView.count** | Menampilkan beberapa item dalam bentuk grid dengan jumlah kolom tertentu. |
| **Card** | Menampilkan konten dalam bentuk kotak dengan shadow. |
| **Container** | Container untuk mengatur ukuran, padding, dan tata letak widget. |
| **Material** | Memberikan efek Material Design seperti warna dasar dan bayangan. |
| **SnackBar** | Menampilkan pop-up message di bagian bawah layar. |
| **ScaffoldMessenger** | Menampilkan SnackBar di dalam Scaffold. |
| **MediaQuery** | Untuk responsivitas layarnya. |
| **List / Map** | Menyimpan data item. |

## Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp berfungsi sebagai pembungkus utama (root widget) dalam aplikasi Flutter yang menggunakan gaya Material Design.  

Widget ini mengatur banyak hal penting dalam aplikasi, seperti:
- Tema global (warna, font, dan tampilan komponen Material Design).  
- Navigasi dan routing antar halaman (home, routes, dan navigator).  
- Judul aplikasi serta konfigurasi global seperti locale dan debug banner.  

MaterialApp biasanya dijadikan widget root karena widget ini menyediakan context Material untuk seluruh widget di bawahnya, seperti Scaffold, AppBar, dan SnackBar, sehingga widget-widget tersebut dapat menggunakan fitur Material Design dengan benar. Selain itu, MaterialApp mengaktifkan elemen-elemen desain dan perilaku khas Material Design di seluruh aplikasi, seperti tema warna, navigasi, serta tampilan komponen standar Android.

## Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

- StatelessWidget digunakan untuk tampilan yang tidak berubah selama aplikasi berjalan. StatelessWidget hanya bergantung pada data dari luar dan tidak memiliki state internal, sehingga cocok untuk elemen statis seperti teks, ikon, atau tombol sederhana.

- StatefulWidget digunakan untuk tampilan yang dapat berubah karena memiliki state internal yang bisa diperbarui. Cocok untuk fitur dinamis seperti form input, animasi, atau data yang diload ulang.

## Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang menunjukkan posisi widget di dalam widget tree. Objek ini penting karena digunakan untuk mengakses data dari parent (seperti tema, ukuran layar, atau navigator) dan menampilkan elemen seperti SnackBar atau dialog. Dalam metode build(), context dipakai agar widget tahu lingkungan tempatnya berada dan bisa membangun tampilan sesuai hierarki aplikasi.

##  Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
- Hot reload adalah fitur Flutter yang memperbarui kode aplikasi tanpa mengulang seluruh proses dari awal. Saat menyimpan perubahan, Flutter hanya memuat ulang bagian kode yang berubah dan mempertahankan state aplikasi, sehingga tidak perlu menjalankan ulang aplikasi setiap kali ada perubahan kecil.

- Hot restart adalah fitur Flutter yang akan menjalankan ulang seluruh aplikasi dari awal dan menghapus semua state yang tersimpan. Hot restart digunakan saat perubahan terjadi pada variabel global, struktur state, atau inisialisasi yang tidak bisa diperbarui dengan hot reload.