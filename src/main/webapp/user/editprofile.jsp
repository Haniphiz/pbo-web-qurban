<%@ page import="com.equrban.models.User" %>

<%
    User userProfile = (User) request.getAttribute("userProfile");

    // Proteksi jika user belum login / attribute kosong
    if (userProfile == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profil</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />

<div class="max-w-xl mx-auto mt-10 bg-white shadow rounded p-6">
    <h2 class="text-2xl font-bold mb-6">Edit Profil</h2>

    <form action="<%= request.getContextPath() %>/updateProfile" method="post">

        <!-- Hidden user_id -->
        <input type="hidden" name="user_id" value="<%= userProfile.getUser_id() %>">

        <!-- Nama -->
        <label class="font-semibold">Nama</label>
        <input
            type="text"
            name="name"
            value="<%= userProfile.getName() %>"
            required
            class="w-full border rounded p-2 mb-4"
        >

        <!-- Email (readonly / tidak bisa diubah) -->
        <label class="font-semibold">Email</label>
        <input
            type="email"
            value="<%= userProfile.getEmail() %>"
            readonly
            class="w-full border rounded p-2 mb-4 bg-gray-100"
        >

        <!-- Telepon -->
        <label class="font-semibold">No. Telepon</label>
        <input
            type="text"
            name="phone"
            value="<%= userProfile.getPhone() != null ? userProfile.getPhone() : "" %>"
            class="w-full border rounded p-2 mb-6"
        >

        <!-- Tombol -->
        <div class="flex justify-between">
            <a href="<%= request.getContextPath() %>/dashboard"
               class="bg-gray-500 text-white px-4 py-2 rounded">
                Batal
            </a>

            <button
                type="submit"
                class="bg-green-600 text-white px-4 py-2 rounded">
                Simpan Perubahan
            </button>
        </div>
    </form>
</div>

</body>
</html>
