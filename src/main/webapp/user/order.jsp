<%@page import="com.equrban.models.Animal"%>
<%@page import="com.equrban.model.User"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="../navbar.jsp" />

<html>
<head>
    <title>Order Hewan</title>
</head>
<body>

<h2>Form Pesanan</h2>

<%
    // Ambil user dari session
    User user = (User) session.getAttribute("user");
    String defaultAddress = "";
    if (user != null && user.getAddress() != null) {
        defaultAddress = user.getAddress();
    }

    Animal animal = (Animal) request.getAttribute("animal");
%>

<form action="<%= request.getContextPath() %>/order" method="post">

    <!-- animalId diambil dari object animal -->
    <input type="hidden" name="animalId" value="<%= animal.getAnimal_id() %>">

    <label>Alamat Pengiriman</label><br>
    <textarea name="address"
              required
              class="w-full border rounded p-2"
              placeholder="Masukkan alamat pengiriman"><%= defaultAddress %></textarea>
    <br><br>

    <label>Tanggal Pengiriman</label><br>
    <input type="date"
           name="delivery_date"
           required
           class="border rounded p-2">
    <br><br>

    <button type="submit"
            class="bg-green-600 text-white px-4 py-2 rounded">
        Konfirmasi Pesanan
    </button>

</form>

</body>
</html>
