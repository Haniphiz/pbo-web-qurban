<%@ page import="com.equrban.model.User" %>
<%@ page import="com.equrban.models.Delivery" %>
<%@ page import="java.util.List" %>

<script src="https://cdn.tailwindcss.com"></script>

<%
    User user = (User) request.getAttribute("userProfile");
    List<Delivery> deliveries = (List<Delivery>) request.getAttribute("deliveries");
%>

<div class="max-w-7xl mx-auto p-6">

    <!-- PROFIL USER -->
    <div class="bg-white shadow rounded p-6 mb-6">
        <h2 class="text-2xl font-bold mb-4">Profil Saya</h2>
        <p><b>Nama:</b> <%= user.getName() %></p>
        <p><b>Email:</b> <%= user.getEmail() %></p>
        <p><b>Telepon:</b> <%= user.getPhone() %></p>
        <p><b>Role:</b> <%= user.getRole() %></p>
        <p><b>Tanggal Daftar:</b> <%= user.getCreated_at() %></p>
    </div>

    <!-- DELIVERY LIST -->
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
                            <td class="border px-4 py-2"><%= d.getAddress() %></td>
                            <td class="border px-4 py-2">
                                <%
                                    String driver = d.getDriverName();
                                    if (driver == null || driver.isEmpty()) {
                                        out.print("-");
                                    } else {
                                        out.print(driver);
                                    }
                                %>
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
