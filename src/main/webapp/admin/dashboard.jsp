
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
                    Selamat datang, <b><%= user.getName()%></b>
                </p>
            </div>

            <!-- PROFIL ADMIN -->
            <div class="bg-white shadow rounded p-6 mb-6">
                <h2 class="text-xl font-bold mb-4">Profil Admin</h2>
                <p><b>Nama:</b> <%= user.getName()%></p>
                <p><b>Email:</b> <%= user.getEmail()%></p>
                <p><b>Telepon:</b>
                    <%= user.getPhone() != null ? user.getPhone() : "-"%>
                </p>
                <p><b>Role:</b> <%= user.getRole()%></p>
            </div>

            <!-- MENU ADMIN -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <a href="<%= request.getContextPath()%>/admin/payments"
                   class="group bg-primary text-white
                   hover:bg-blue-600
                   rounded-xl p-6
                   shadow-md hover:shadow-lg
                   transition-all duration-200 cursor-pointer">

                    <div class="flex items-start justify-between">
                        <div>
                            <h3 class="text-lg font-semibold text-white">
                                Verifikasi Pembayaran
                            </h3>
                            <p class="text-sm text-white/80 mt-1">
                                Kelola dan konfirmasi pembayaran qurban
                            </p>
                        </div>
                        <span class="text-white text-2xl font-bold">&rsaquo;</span>
                    </div>
                </a>

                <a href="<%= request.getContextPath()%>/admin/animal/add"
                   class="group bg-green-600 text-white
                   hover:bg-green-700
                   rounded-xl p-6
                   shadow-md hover:shadow-lg
                   transition-all duration-200 cursor-pointer">

                    <div class="flex items-start justify-between">
                        <div>
                            <h3 class="text-lg font-semibold text-white">
                                Tambah Hewan
                            </h3>
                            <p class="text-sm text-white/80 mt-1">
                                Tambahkan hewan qurban ke katalog
                            </p>
                        </div>
                        <span class="text-white text-2xl font-bold">&plus;</span>
                    </div>
                </a>

            </div>

        </div>

    </body>
</html>
