<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="max-w-md mx-auto mt-20 bg-white p-8 rounded-lg shadow">
    <h2 class="text-2xl font-bold mb-4 text-center">Login</h2>

    <% if (request.getParameter("error") != null) { %>
        <p class="text-red-600 text-center mb-3">Email atau password salah!</p>
    <% } %>

    <form action="LoginServlet" method="post" class="space-y-4">
        <div>
            <label class="block font-medium">Email</label>
            <input type="email" name="email" required class="w-full border p-2 rounded">
        </div>

        <div>
            <label class="block font-medium">Password</label>
            <input type="password" name="password" required class="w-full border p-2 rounded">
        </div>

        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
            Login
        </button>
    </form>

    <!-- Tombol Daftar -->
    <div class="text-right mt-4">
         <a href="register.jsp" class="text-blue-600 hover:underline font-normal"<span>Belum punya akun? DAFTAR</span>

      
       