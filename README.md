# live_notes
Rasya Aprilia (362458302115)

## Tugas Praktikum

1. Update Feature: Tambahkan fitur edit. Ketika ListTile ditekan (onTap), munculkan
formulir yang sudah terisi data lama, dan update data tersebut di Firebase menggunakan
perintah .update().
2. Testing: Jalankan aplikasi di 2 device berbeda (Emulator HP Fisik atau 2 Emulator).
Buktikan bahwa data tersinkronisasi secara otomatis.

# Langkah-Langkah :
1. Edit data (update catatan saat klik ontap) :
- memodifikasi fungsi yang ada di main, modifikasi fungsi showfrom menambahkan logika pengecekan jika isi documensnapshot tidak kosong maka ditambapilkan data controller yang lama untuk diedit
- didalam elevatedbutton, ditambahkan logika else jika datanya tidak null sesuai dengan pengecekan tadi untuk diupdate, yang mengupdate disini
kode intinya :
<img width="454" height="119" alt="image" src="https://github.com/user-attachments/assets/73fd1622-e240-40a0-9062-6bee5ee6603b" />

- menghubungkan ontap ke showform, di list view tepatnya di listtile ditambahkan handler ontap yang langsung memanggi ke showform dengan mengirimkan isi parameternya
kode intinya :
<img width="288" height="20" alt="image" src="https://github.com/user-attachments/assets/6aa3e531-eb00-437a-82c2-d2ad4f42fa76" />

2. Sinkronisasi otomatis :
setelah dicoba menggunakan 2 device berbeda terbukti hasilnya tersinkron otomatis sesuai yang ada di database firebase

## Hasil Praktikum :
1. gambar tampilan awal :
<img width="1080" height="2340" alt="image" src="https://github.com/user-attachments/assets/d613b983-677d-45c6-8384-e6193f902bd8" />

2. gambar setelah menambahkan catatan :
<img width="1080" height="2340" alt="image" src="https://github.com/user-attachments/assets/8700a8b2-c0f3-44a4-b7d5-f23ce46eabae" />

3. setelah klik sekali pada catatan, untuk diperbarui :
<img width="1080" height="2340" alt="image" src="https://github.com/user-attachments/assets/3c02d623-a23a-4e06-b1ff-3025b80f21a3" />

4. setelah catatan diperbarui :
<img width="1080" height="2340" alt="image" src="https://github.com/user-attachments/assets/dd7dd79f-d8ad-4c99-b2b2-9ff60eea2be6" />

5. menambahkan catatan kedua dan menghapus catatan :
<img width="1080" height="2340" alt="image" src="https://github.com/user-attachments/assets/d6f59aa7-c189-4195-a499-9f734dcce959" />

<img width="1080" height="2340" alt="image" src="https://github.com/user-attachments/assets/6a8452f2-116d-4554-9771-10d32f271161" />

