<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.equrban.models.Order" %>

<!DOCTYPE html>
<html>
<head>
    <title>Pembayaran</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<jsp:include page="../navbar.jsp" />

<%
    Order order = (Order) request.getAttribute("order");
    if (order == null) {
%>
    <div class="max-w-xl mx-auto mt-10 bg-white p-6 rounded shadow">
        <p class="text-red-600">Data order tidak ditemukan.</p>
    </div>
<%
        return;
    }
%>

<div class="max-w-xl mx-auto mt-10 bg-white p-6 rounded shadow">
    <h1 class="text-2xl font-bold mb-6">Pembayaran</h1>

    <!-- INFO ORDER -->
    <div class="mb-6">
        <p><b>Order ID:</b> <%= order.getOrderId() %></p>
        <p><b>Total Bayar:</b> Rp <%= order.getTotalAmount() %></p>
        <p><b>Status:</b> <%= order.getStatus() %></p>
    </div>

    <!-- FORM PAYMENT -->
    <form action="<%= request.getContextPath() %>/payment"
          method="post"
          enctype="multipart/form-data"
          class="space-y-4">

        <!-- hidden order id -->
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

        <!-- hidden amount (agar konsisten) -->
        <input type="hidden" name="amount" value="<%= order.getTotalAmount() %>">

        <!-- METODE -->
        <div>
            <label class="block mb-1 font-semibold">Metode Pembayaran</label>
         <select name="payment_method" required
        class="w-full border rounded px-3 py-2">
    <option value="">-- Pilih Metode --</option>
    <option value="transfer_bank_bca">Transfer Bank BCA</option>
    <option value="transfer_bank_mandiri">Transfer Bank Mandiri</option>
</select>

        </div>

        <!-- BUKTI -->
        <div>
            <label class="block mb-1 font-semibold">Upload Bukti Pembayaran</label>
            <input type="file"
                   name="proof_image"
                   accept="image/*"
                   required
                   class="w-full border rounded px-3 py-2">
        </div>

        <!-- SUBMIT -->
        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
            Kirim Pembayaran
        </button>
    </form>
</div>

</body>
</html>
