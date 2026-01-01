<%@ page import="com.equrban.models.Order" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <title>Pembayaran</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">

<%@ include file="/layout/head.jsp" %>
<jsp:include page="/components/navbar.jsp" />

<%
    Order order = (Order) request.getAttribute("order");
    if (order == null) {
%>
    <div class="max-w-xl mx-auto mt-10 bg-white p-6 rounded-xl shadow">
        <p class="text-red-600 text-center font-semibold">
            Data order tidak ditemukan.
        </p>
    </div>
<%
        return;
    }
%>

<div class="max-w-xl mx-auto mt-10 bg-white p-6 rounded-xl shadow">

    <h1 class="text-2xl font-bold mb-6 text-gray-800">
        Pembayaran
    </h1>

    <!-- ================= INFO REKENING ================= -->
    <div class="mb-6 p-4 rounded-lg bg-blue-50 border border-blue-200">
        <h2 class="font-semibold text-blue-700 mb-2">
            Informasi Rekening Pembayaran
        </h2>

        <p class="text-sm text-gray-700">
            <b>Bank BCA</b><br>
            No. Rekening: <span class="font-semibold">1234567890</span><br>
            Atas Nama: <span class="font-semibold">EQurbanCompany</span>
        </p>

        <hr class="my-3">

        <p class="text-sm text-gray-700">
            <b>Bank Mandiri</b><br>
            No. Rekening: <span class="font-semibold">9876543210</span><br>
            Atas Nama: <span class="font-semibold">EQurbanCompany</span>
        </p>
    </div>

    <!-- ================= INFO ORDER ================= -->
    <div class="mb-6 grid grid-cols-1 gap-2 text-gray-700">
        <p>
            <span class="text-gray-500 text-sm">Order ID</span><br>
            <span class="font-semibold"><%= order.getOrderId() %></span>
        </p>

        <p>
            <span class="text-gray-500 text-sm">Total Bayar</span><br>
            <span class="font-bold text-green-600 text-xl">
                Rp <%= String.format("%,.0f", order.getTotalAmount()) %>
            </span>
        </p>

        <p>
            <span class="text-gray-500 text-sm">Status</span><br>
            <span class="font-semibold capitalize">
                <%= order.getStatus() %>
            </span>
        </p>
    </div>

    <!-- ================= FORM PAYMENT ================= -->
    <form action="<%= request.getContextPath() %>/payment"
          method="post"
          enctype="multipart/form-data"
          class="space-y-4">

        <!-- hidden order id -->
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

        <!-- hidden amount -->
        <input type="hidden" name="amount" value="<%= order.getTotalAmount() %>">

        <!-- METODE -->
        <div>
            <label class="block mb-1 font-semibold text-gray-700">
                Metode Pembayaran
            </label>
            <select name="payment_method" required
                    class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none">
                <option value="">-- Pilih Metode --</option>
                <option value="transfer_bank_bca">Transfer Bank BCA</option>
                <option value="transfer_bank_mandiri">Transfer Bank Mandiri</option>
            </select>
        </div>

        <!-- BUKTI -->
        <div>
            <label class="block mb-1 font-semibold text-gray-700">
                Upload Bukti Pembayaran
            </label>
            <input type="file"
                   name="proof_image"
                   accept="image/*"
                   required
                   class="w-full border rounded-lg px-3 py-2 bg-white">
        </div>

        <!-- SUBMIT -->
        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded-lg font-semibold hover:bg-blue-700 transition">
            Kirim Pembayaran
        </button>
    </form>

</div>

</body>
</html>
