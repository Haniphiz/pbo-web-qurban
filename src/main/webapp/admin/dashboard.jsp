<%@ page import="com.equrban.model.User" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<jsp:include page="../navbar.jsp" />

<div class="max-w-4xl mx-auto mt-10 bg-white p-6 rounded shadow">
    <h1 class="text-2xl font-bold mb-4">Dashboard Admin</h1>
    <p>Halo, <b><%= user.getName() %></b></p>

    <ul class="mt-4 list-disc ml-6">
        <li>Kelola User</li>
        <li>Kelola Data Qurban</li>
        <li>Laporan Transaksi</li>
    </ul>
</div>

</body>
</html>
