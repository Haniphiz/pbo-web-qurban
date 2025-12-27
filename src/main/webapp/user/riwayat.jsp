<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.equrban.models.Order" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Riwayat Transaksi Qurban</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen">

    <!-- Navbar -->
    <jsp:include page="/navbar.jsp" />

    <!-- Container -->
    <div class="max-w-5xl mx-auto mt-10 bg-white shadow rounded-lg p-6">

        <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">
            Riwayat Transaksi Qurban
        </h2>

        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
        %>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-200 rounded">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="px-4 py-2 border text-left">ID Order</th>
                        <th class="px-4 py-2 border text-left">Nama Hewan</th>
                        <th class="px-4 py-2 border text-left">Total</th>
                        <th class="px-4 py-2 border text-left">Status</th>
                        <th class="px-4 py-2 border text-left">Tanggal</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order o : orders) { %>
                    <tr class="hover:bg-gray-50">
                        <td class="px-4 py-2 border"><%= o.getOrderId() %></td>
                        <td class="px-4 py-2 border"><%= o.getAnimalName() %></td>
                        <td class="px-4 py-2 border">
                            Rp <%= String.format("%,.0f", o.getTotalAmount()) %>
                        </td>
                        <td class="px-4 py-2 border">
                            <span class="px-2 py-1 rounded text-white
                                <%= "pending".equals(o.getStatus()) ? "bg-yellow-500" : "bg-green-600" %>">
                                <%= o.getStatus() %>
                            </span>
                        </td>
                        <td class="px-4 py-2 border"><%= o.getOrderDate() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <% } else { %>

        <!-- Jika belum ada transaksi -->
        <div class="text-center text-gray-600 py-10">
            <p class="text-lg">Belum ada transaksi qurban.</p>
            <a href="<%= request.getContextPath() %>/katalog"
               class="inline-block mt-4 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                Mulai Beli Qurban
            </a>
        </div>

        <% } %>

    </div>

</body>
</html>
