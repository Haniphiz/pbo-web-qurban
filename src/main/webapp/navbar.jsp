<%@ page import="com.equrban.model.User" %>
<script src="https://cdn.tailwindcss.com"></script>

<%
    User user = (User) session.getAttribute("user");
%>

<nav class="bg-white shadow-lg">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex justify-between items-center h-16">

            <!-- Logo -->
            <a href="<%= request.getContextPath() %>/index.jsp"
               class="text-2xl font-bold text-blue-600">e-Qurban</a>

            <!-- Menu tengah -->
            <div class="hidden md:flex space-x-6">
                <a href="<%= request.getContextPath() %>/index.jsp" class="text-gray-700 hover:text-blue-600">Home</a>
                <a href="<%= request.getContextPath() %>/katalog" class="text-gray-700 hover:text-blue-600">Produk</a>
                <a href="<%= request.getContextPath() %>/about.jsp" class="text-gray-700 hover:text-blue-600">About Us</a>

                <% if (user != null) { %>
                    <% if ("admin".equals(user.getRole())) { %>
                        <a href="<%= request.getContextPath() %>/admin/dashboard" class="text-gray-700 hover:text-blue-600">Dashboard Admin</a>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/user/dashboard" class="text-gray-700 hover:text-blue-600">Profil</a>
                        <a href="<%= request.getContextPath() %>/riwayat" class="text-gray-700 hover:text-blue-600">Riwayat</a>
                    <% } %>
                <% } %>
            </div>

            <!-- Menu kanan -->
            <div class="flex items-center space-x-4">
                <% if (user == null) { %>
                    <a href="<%= request.getContextPath() %>/login.jsp" class="text-gray-700 hover:text-blue-600">Login</a>
                    <a href="<%= request.getContextPath() %>/register.jsp" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Daftar</a>
                <% } else { %>
                    <span class="text-gray-700">Halo, <b><%= user.getName() %></b></span>
                    <a href="<%= request.getContextPath() %>/LogoutServlet" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Logout</a>
                <% } %>
            </div>

        </div>
    </div>
</nav>
