
<%@ page import="com.equrban.models.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!-- ===== INCLUDE NAVBAR GLOBAL ===== -->

<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />



<div class="max-w-5xl mx-auto p-6">

    <!-- HEADER -->
    <div class="mb-6">
        <h1 class="text-3xl font-bold">Dashboard Admin</h1>
        <p class="text-gray-600">
            Selamat datang, <b><%= user.getName() %></b>
        </p>
    </div>

    <!-- PROFIL ADMIN -->
    <div class="bg-white shadow rounded p-6 mb-6">
        <h2 class="text-xl font-bold mb-4">Profil Admin</h2>
        <p><b>Nama:</b> <%= user.getName() %></p>
        <p><b>Email:</b> <%= user.getEmail() %></p>
        <p><b>Telepon:</b>
            <%= user.getPhone() != null ? user.getPhone() : "-" %>
        </p>
        <p><b>Role:</b> <%= user.getRole() %></p>
    </div>

    <!-- MENU ADMIN -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

        <a href="<%= request.getContextPath() %>/admin/payments"
           class="bg-white shadow hover:shadow-lg transition rounded p-6 block">
            <h3 class="text-lg font-bold mb-2">Verifikasi Pembayaran</h3>
            <p class="text-gray-600">Kelola pembayaran qurban</p>
        </a>

          <a href="<%= request.getContextPath() %>/admin/animal/add"
             class="bg-white shadow hover:shadow-lg transition rounded p-6 block">
              <h3 class="text-lg font-bold mb-2">Tambah Hewan</h3>
              <p class="text-gray-600">Tambahkan hewan qurban ke katalog</p>
          </a>

    </div>

</div>

</body>
</html>
