<%@ page import="com.equrban.model.User" %>
<%@ page import="com.equrban.models.Delivery" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User userProfile = (User) request.getAttribute("userProfile");
    List<Delivery> deliveries = (List<Delivery>) request.getAttribute("deliveries");

    if (userProfile == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
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

<!-- Navbar -->
<jsp:include page="../navbar.jsp" />

<div class="max-w-7xl mx-auto mt-10 p-6">

<!-- ================= PROFIL USER ================= -->
<div class="bg-white shadow rounded p-6 mb-6">
    <h2 class="text-2xl font-bold mb-4">Profil Saya</h2>

    <p><b>Nama:</b> <%= userProfile.getName() %></p>
    <p><b>Email:</b> <%= userProfile.getEmail() %></p>
    <p><b>Telepon:</b> <%= userProfile.getPhone() != null ? userProfile.getPhone() : "-" %></p>
    <p><b>Role:</b> <%= userProfile.getRole() %></p>
    <p><b>Tanggal Daftar:</b> <%= userProfile.getCreated_at() != null ? userProfile.getCreated_at() : "-" %></p>

    <p class="mt-2">
        <b>Alamat:</b>
        <%= userProfile.getAddress() != null ? userProfile.getAddress() : "-" %>
    </p>

    <!-- Tombol Tambah / Edit Alamat -->
    <div class="mt-4">
        <%
            if (userProfile.getAddress() == null || userProfile.getAddress().isEmpty()) {
        %>
            <a href="<%= request.getContextPath() %>/editAddress"
               class="bg-green-600 text-white px-4 py-2 rounded">
                Tambahkan Alamat
            </a>
        <%
            } else {
        %>
            <a href="<%= request.getContextPath() %>/editAddress"
               class="bg-blue-600 text-white px-4 py-2 rounded">
                Edit Alamat
            </a>
        <%
            }
        %>
    </div>

    <!-- Tombol Edit Profil -->
    <div class="mt-4">
        <a href="<%= request.getContextPath() %>/editProfile"
           class="bg-yellow-600 text-white px-4 py-2 rounded">
            Edit Profil
        </a>
    </div>
</div>

<!-- ================= DELIVERY LIST ================= -->
<div class="bg-white shadow rounded p-6">
    <h2 class="text-2xl font-bold mb-4">Jadwal Pengiriman</h2>

    <%
        if (deliveries == null || deliveries.isEmpty()) {
    %>
        <p>Belum ada jadwal pengiriman.</p>
    <%
        } else {
    %>
        <table class="min-w-full table-auto border-collapse border border-gray-200">
            <thead>
                <tr class="bg-gray-100">
                    <th class="border px-4 py-2">Order ID</th>
                    <th class="border px-4 py-2">Tanggal</th>
                    <th class="border px-4 py-2">Alamat</th>
                    <th class="border px-4 py-2">Driver</th>
                    <th class="border px-4 py-2">Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Delivery d : deliveries) {
                %>
                <tr>
                    <td class="border px-4 py-2"><%= d.getOrderId() %></td>
                    <td class="border px-4 py-2"><%= d.getDeliveryDate() %></td>
                    <td class="border px-4 py-2"><%= d.getAddress() != null ? d.getAddress() : "-" %></td>
                    <td class="border px-4 py-2">
                        <%= d.getDriverName() != null ? d.getDriverName() : "-" %>
                    </td>
                    <td class="border px-4 py-2">
                        <%
                            String status = d.getStatus();
                            if ("pending".equals(status)) {
                        %>
                            <span class="text-orange-500 font-bold">Menunggu</span>
                        <%
                            } else if ("scheduled".equals(status)) {
                        %>
                            <span class="text-blue-500 font-bold">Dijadwalkan</span>
                        <%
                            } else if ("delivered".equals(status)) {
                        %>
                            <span class="text-green-500 font-bold">Terkirim</span>
                        <%
                            } else {
                                out.print(status);
                            }
                        %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>
</div>

</div>

</body>
</html>
