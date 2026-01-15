# 📘 README – Konfigurasi Database & Koneksi Kode

Dokumen ini menjelaskan langkah-langkah **menghubungkan database PostgreSQL dengan aplikasi e-Qurban** serta **konfigurasi direktori penyimpanan gambar** agar aplikasi dapat berjalan dengan benar.

---

## 1️⃣ Konfigurasi Database

Aplikasi e-Qurban menggunakan **PostgreSQL** sebagai basis data dan **JDBC** sebagai penghubung antara aplikasi Java dengan database.

### 📂 Lokasi File

```
src/main/java/com/equrban/config/Database.java
```

### 🧩 Contoh Kode `Database.java`

```java
package com.equrban.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    
    private static final String URL = "jdbc:postgresql://localhost:5432/db_kurban";
    private static final String USER = "postgres";
    private static final String PASSWORD = "hanip10";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.out.println("Koneksi gagal: " + e.getMessage());
        }
        return conn;
    }
}
```

### ⚙️ Penyesuaian yang Wajib Dilakukan

Silakan **ubah bagian berikut sesuai dengan konfigurasi database di komputer Anda**:

* `URL` → nama database dan port PostgreSQL
* `USER` → username PostgreSQL
* `PASSWORD` → password PostgreSQL

📌 Contoh:

```java
private static final String USER = "username_db_anda";
private static final String PASSWORD = "password_db_anda";
```

Pastikan:

* PostgreSQL sudah berjalan
* Database `db_kurban` sudah dibuat
* Driver PostgreSQL sudah ditambahkan ke project (dependency)

---

## 2️⃣ Konfigurasi Direktori Gambar Pembayaran

Servlet ini digunakan untuk menampilkan **bukti pembayaran** yang diunggah oleh pengguna.

### 📂 Lokasi File

```
src/main/java/com/equrban/controllers/PaymentImageServlet.java
```

### 🧩 Potongan Kode

```java
@WebServlet("/images/payments/*")
public class PaymentImageServlet extends HttpServlet {

    private static final String IMAGE_DIR =
        "C:/Users/Lenovo/OneDrive/Documents/foto_hewan_qurban/verification";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // logic menampilkan gambar
    }
}
```

### ⚙️ Penyesuaian Direktori

Ubah nilai `IMAGE_DIR` sesuai dengan **folder penyimpanan gambar pembayaran di komputer Anda**.

📌 Contoh:

```java
private static final String IMAGE_DIR = "D:/uploads/payments";
```

Pastikan:

* Folder sudah dibuat
* Aplikasi memiliki izin untuk membaca file dari folder tersebut

---

## 3️⃣ Konfigurasi Direktori Gambar Hewan

Servlet ini digunakan untuk menampilkan **gambar hewan qurban** pada katalog.

### 📂 Lokasi File

```
src/main/java/com/equrban/controllers/AnimalImageServlet.java
```

### 🧩 Potongan Kode

```java
@WebServlet("/images/animals/*")
public class AnimalImageServlet extends HttpServlet {

    private static final String IMAGE_DIR =
            "C:/Users/Lenovo/OneDrive/Documents/foto_hewan_qurban/animals";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // logic menampilkan gambar
    }
}
```

### ⚙️ Penyesuaian Direktori

Silakan sesuaikan `IMAGE_DIR` dengan lokasi folder gambar hewan di perangkat Anda.

📌 Contoh:

```java
private static final String IMAGE_DIR = "D:/uploads/animals";
```

---

## 4️⃣ Catatan Penting

* Gunakan **path absolut** (absolute path) untuk menghindari error pembacaan file
* Hindari penggunaan spasi atau karakter khusus pada nama folder
* Jika aplikasi dijalankan di server Linux, sesuaikan path direktori (contoh: `/var/www/uploads`)

---

## ✅ Kesimpulan

Dengan melakukan penyesuaian pada **konfigurasi database** dan **direktori penyimpanan gambar**, aplikasi e-Qurban dapat terhubung dengan database serta menampilkan gambar hewan dan bukti pembayaran dengan benar.

---

📌 *Pastikan seluruh konfigurasi sudah disesuaikan sebelum menjalankan aplikasi.*
