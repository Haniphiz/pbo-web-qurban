<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.equrban.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Alamat</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<jsp:include page="../navbar.jsp" />

<div class="max-w-xl mx-auto mt-10 bg-white shadow rounded p-6">
    <h2 class="text-2xl font-bold mb-4">Edit Alamat</h2>

    <form action="<%= request.getContextPath() %>/updateAddress" method="post">
        
        <!-- USER ID -->
        <input type="hidden" name="user_id" value="<%= user.getUser_id() %>">

        <label class="block mb-2 font-semibold">Alamat Lengkap</label>
        <textarea 
            name="address"
            rows="4"
            class="w-full border rounded px-3 py-2 mb-4"
            required
        ><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>

        <div class="flex justify-between">
            <a href="<%= request.getContextPath() %>/user/dashboard"
               class="bg-gray-500 text-white px-4 py-2 rounded">
                Batal
            </a>

            <button type="submit"
                    class="bg-blue-600 text-white px-4 py-2 rounded">
                Simpan
            </button>
        </div>

    </form>
</div>

</body>
</html>
