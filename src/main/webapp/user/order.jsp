<%@ page import="com.equrban.models.User" %>
<%@ page import="com.equrban.models.Animal" %>

<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Animal animal = (Animal) request.getAttribute("animal");
    if (animal == null) {
        response.sendError(400, "Animal tidak ditemukan");
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
    <title>Order Hewan</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="max-w-xl mx-auto mt-10 bg-white shadow rounded p-6">

<h2 class="text-2xl font-bold mb-6">Form Pesanan</h2>

<form action="<%= request.getContextPath() %>/order" method="post">

    <input type="hidden" name="animalId" value="<%= animal.getAnimal_id() %>">

    <label class="font-semibold">Provinsi</label>
    <input type="text" name="province"
           value="<%= province %>"
           required class="w-full border rounded p-2 mb-4">

    <label class="font-semibold">Kota / Kabupaten</label>
    <input type="text" name="city"
           value="<%= city %>"
           required class="w-full border rounded p-2 mb-4">

    <label class="font-semibold">Kecamatan</label>
    <input type="text" name="district"
           value="<%= district %>"
           required class="w-full border rounded p-2 mb-4">

    <label class="font-semibold">Alamat Lengkap</label>
    <textarea name="address"
              required
              class="w-full border rounded p-2 mb-4"><%= address %></textarea>

    <label class="font-semibold">Kode Pos</label>
    <input type="text" name="postal_code"
           value="<%= postalCode %>"
           required class="w-full border rounded p-2 mb-4">

    <label class="font-semibold">Tanggal Pengiriman</label>
    <input type="date" name="delivery_date"
           required class="w-full border rounded p-2 mb-6">

    <button type="submit"
            class="bg-green-600 text-white px-4 py-2 rounded w-full">
        Konfirmasi Pesanan
    </button>

</form>

</div>
</body>
</html>
