<%@ page import="com.equrban.model.User" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<jsp:include page="../navbar.jsp" />

<div class="max-w-4xl mx-auto mt-10 bg-white p-6 rounded shadow">
    <h1 class="text-2xl font-bold mb-4">Dashboard User</h1>
    <p>Selamat datang, <b><%= user.getName() %></b></p>

    <ul class="mt-4 list-disc ml-6">
        <li>Daftar Qurban</li>
        <li>Riwayat Qurban</li>
        <li>Profil Saya</li>
    </ul>
</div>

</body>
</html>
