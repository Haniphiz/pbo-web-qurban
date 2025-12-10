<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="navbar.jsp"%>
<%@page import="java.sql.*"%>
<%
Connection connection = null;
try {
    String url = "jdbc:postgresql://localhost:5432/db_kurban";
    String user = "postgres";   // default user PostgreSQL
    String pass = "hanip10"; // isi password yang benar

    Class.forName("org.postgresql.Driver");
    connection = DriverManager.getConnection(url, user, pass);
    out.println("Koneksi BERHASIL!");
} catch (Exception e) {
    out.println("GAGAL KONEKSI: " + e.getMessage());
}
%>

<div class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="text-center p-10">
        <h1 class="text-4xl font-bold text-blue-600 mb-4">
            Selamat Datang di Website e-Qurban
        </h1>
        <p class="text-lg text-gray-700 max-w-xl mx-auto">
            Platform untuk memudahkan pembelian hewan qurban secara online.
            Pilih hewan terbaik dan amanah untuk kebutuhan ibadah Anda.
        </p>

        <a href="about.jsp"
           class="mt-6 inline-block bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">
            Pelajari Lebih Lanjut
        </a>
    </div>
</div>
