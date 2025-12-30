<%@ page import="com.equrban.models.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String address    = user.getAddress() != null ? user.getAddress() : "";
    String province   = user.getProvince() != null ? user.getProvince() : "";
    String city       = user.getCity() != null ? user.getCity() : "";
    String district   = user.getDistrict() != null ? user.getDistrict() : "";
    String postalCode = user.getPostalCode() != null ? user.getPostalCode() : "";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Alamat</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">


<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />



<div class="max-w-xl mx-auto mt-10 bg-white shadow rounded p-6">
    <h2 class="text-2xl font-bold mb-4">Edit Alamat</h2>

    <form action="<%= request.getContextPath() %>/updateAddress" method="post">

        <!-- Alamat -->
        <label class="block font-semibold mb-1">Alamat Lengkap</label>
        <textarea name="address"
                  rows="3"
                  class="w-full border rounded px-3 py-2 mb-3"
                  required><%= address %></textarea>

        <!-- Provinsi -->
        <label class="block font-semibold mb-1">Provinsi</label>
        <input type="text"
               name="province"
               value="<%= province %>"
               class="w-full border rounded px-3 py-2 mb-3"
               required>

        <!-- Kota -->
        <label class="block font-semibold mb-1">Kota / Kabupaten</label>
        <input type="text"
               name="city"
               value="<%= city %>"
               class="w-full border rounded px-3 py-2 mb-3"
               required>

        <!-- Kecamatan -->
        <label class="block font-semibold mb-1">Kecamatan</label>
        <input type="text"
               name="district"
               value="<%= district %>"
               class="w-full border rounded px-3 py-2 mb-3"
               required>

        <!-- Kode Pos -->
        <label class="block font-semibold mb-1">Kode Pos</label>
        <input type="text"
               name="postal_code"
               value="<%= postalCode %>"
               class="w-full border rounded px-3 py-2 mb-4"
               required>

        <div class="flex justify-between">
            <a href="<%= request.getContextPath() %>/user/dashboard"
               class="bg-gray-500 text-white px-4 py-2 rounded">
                Batal
            </a>

            <button type="submit"
                    class="bg-blue-600 text-white px-4 py-2 rounded">
                Simpan Alamat
            </button>
        </div>

    </form>
</div>

</body>
</html>
