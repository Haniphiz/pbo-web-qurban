<%@ page import="com.equrban.models.User" %>
<%@ page import="com.equrban.models.Delivery" %>
<%@ page import="java.util.List" %>

<%
    User userProfile = (User) request.getAttribute("userProfile");
    List<Delivery> deliveries = (List<Delivery>) request.getAttribute("deliveries");

    if (userProfile == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">

<%@ include file="/layout/head.jsp" %>
<jsp:include page="/components/navbar.jsp" />

<div class="max-w-5xl mx-auto mt-10 px-4">

    <!-- ================= PROFIL USER ================= -->
    <div class="bg-white shadow-md rounded-xl p-6 mb-6">

        <h2 class="text-2xl font-bold mb-6 text-gray-800">
            Profil Saya
        </h2>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-gray-700">
            <div>
                <p class="text-sm text-gray-500">Nama</p>
                <p class="font-semibold"><%= userProfile.getName() %></p>
            </div>

            <div>
                <p class="text-sm text-gray-500">Email</p>
                <p class="font-semibold"><%= userProfile.getEmail() %></p>
            </div>

            <div>
                <p class="text-sm text-gray-500">Nomor Telepon</p>
                <p class="font-semibold">
                    <%= userProfile.getPhone() != null ? userProfile.getPhone() : "-" %>
                </p>
            </div>

            <div>
                <p class="text-sm text-gray-500">Alamat</p>
                <p class="font-semibold">
                    <%= userProfile.getAddress() != null ? userProfile.getAddress() : "-" %>
                </p>
            </div>
        </div>

        <!-- ================= BUTTON ACTION ================= -->
        <div class="mt-6 flex flex-wrap gap-3">

            <%
                if (userProfile.getAddress() == null || userProfile.getAddress().isEmpty()) {
            %>
                <a href="<%= request.getContextPath() %>/editAddress"
                   class="px-4 py-2 rounded-lg bg-green-600 text-white text-sm font-semibold hover:opacity-90 transition">
                    Tambahkan Alamat
                </a>
            <%
                } else {
            %>
                <a href="<%= request.getContextPath() %>/editAddress"
                   class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-semibold hover:opacity-90 transition">
                    Edit Alamat
                </a>
            <%
                }
            %>

            <a href="<%= request.getContextPath() %>/editProfile"
               class="px-4 py-2 rounded-lg bg-yellow-500 text-white text-sm font-semibold hover:opacity-90 transition">
                Edit Profil
            </a>
        </div>

    </div>

</div>

</body>
</html>
