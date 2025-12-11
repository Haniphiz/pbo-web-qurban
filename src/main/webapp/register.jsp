<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="navbar.jsp" %>

<div class="max-w-md mx-auto mt-10 p-6 shadow-lg bg-white rounded">
    <h2 class="text-2xl font-bold mb-4 text-center">Daftar Akun</h2>

    <form action="register" method="POST">

        <input type="text" name="name" placeholder="Nama Lengkap"
               class="w-full border px-3 py-2 rounded mb-3" required>

        <input type="email" name="email" placeholder="Email"
               class="w-full border px-3 py-2 rounded mb-3" required>

        <input type="password" name="password" placeholder="Password"
               class="w-full border px-3 py-2 rounded mb-3" required>

        <input type="text" name="phone" placeholder="Nomor Telepon"
               class="w-full border px-3 py-2 rounded mb-3" required>

        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
            Daftar
        </button>
    </form>
</div>
