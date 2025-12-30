<%@ page import="com.equrban.models.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<header class="sticky top-0 z-50 w-full bg-white dark:bg-[#1a2e22]
               shadow-sm border-b border-[#f0f4f2] dark:border-[#2a4032]">

    <div class="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">

        <!-- Logo -->
        <a href="<%= request.getContextPath() %>/index"
           class="flex items-center gap-3 text-secondary dark:text-white font-display">

            <div class="size-10 bg-primary/10 rounded-lg flex items-center justify-center text-primary">
                <span class="material-symbols-outlined !text-3xl">mosque</span>
            </div>
            <span class="text-xl font-bold tracking-tight">e-Qurban</span>
        </a>

        <!-- Menu Tengah -->
        <nav class="hidden md:flex items-center gap-8 text-sm font-semibold">
            <a href="<%= request.getContextPath() %>/index"
               class="hover:text-primary transition-colors">
                Beranda
            </a>

            <a href="<%= request.getContextPath() %>/katalog"
               class="hover:text-primary transition-colors">
                Katalog Hewan
            </a>

            <a href="<%= request.getContextPath() %>/about.jsp"
               class="hover:text-primary transition-colors">
               Tentang kami
            </a>

         

            <% if (user != null) { %>
                <% if ("admin".equals(user.getRole())) { %>
                    <a href="<%= request.getContextPath() %>/admin/dashboard"
                       class="hover:text-primary transition-colors">
                        Dashboard Admin
                    </a>
                <% } else { %>
                    <a href="<%= request.getContextPath() %>/user/dashboard"
                       class="hover:text-primary transition-colors">
                        Profil
                    </a>
                    <a href="<%= request.getContextPath() %>/riwayat"
                       class="hover:text-primary transition-colors">
                        Riwayat
                    </a>
                <% } %>
            <% } %>
        </nav>

        <!-- Menu Kanan -->
        <div class="flex items-center gap-4">

            <% if (user == null) { %>
                <!-- LOGIN -->
                <a href="<%= request.getContextPath() %>/login.jsp"
                   class="h-10 px-5 flex items-center justify-center rounded-lg
                          bg-primary hover:bg-primary-dark text-white
                          text-sm font-bold transition-all shadow-md shadow-primary/20">
                    Login
                </a>
            <% } else { %>
                <!-- USER INFO -->
                <span class="hidden md:block text-sm text-gray-600 dark:text-gray-300">
                    Halo, <b><%= user.getName() %></b>
                </span>

                <!-- LOGOUT -->
                <a href="<%= request.getContextPath() %>/LogoutServlet"
                   class="h-10 px-5 flex items-center justify-center rounded-lg
                          bg-red-500 hover:bg-red-600 text-white
                          text-sm font-bold transition-all shadow-md shadow-red-500/20">
                    Logout
                </a>
            <% } %>

            <!-- Mobile Menu Icon (UI only) -->
            <button class="md:hidden p-2 text-secondary dark:text-white">
                <span class="material-symbols-outlined">menu</span>
            </button>
        </div>

    </div>
</header>
