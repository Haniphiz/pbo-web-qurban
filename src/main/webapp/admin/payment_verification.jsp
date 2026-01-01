<%@ page import="java.util.List" %>
<%@ page import="com.equrban.models.Payment" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Verifikasi Pembayaran</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-gray-100">

        <%@ include file="/layout/head.jsp" %>
        <jsp:include page="/components/navbar.jsp" />

        <div class="max-w-5xl mx-auto mt-10 bg-white p-6 rounded shadow">

            <h1 class="text-2xl font-bold mb-6">Verifikasi Pembayaran</h1>

            <%
                List<Payment> payments
                        = (List<Payment>) request.getAttribute("payments");

                if (payments == null || payments.isEmpty()) {
            %>
            <p class="text-gray-500">
                Tidak ada pembayaran menunggu verifikasi.
            </p>
            <%
            } else {
                for (Payment p : payments) {
            %>

            <div class="border p-4 mb-4 rounded bg-gray-50">

                <p><b>Payment ID:</b> <%= p.getPaymentId()%></p>
                <p><b>Order ID:</b> <%= p.getOrderId()%></p>
                <p><b>Metode:</b> <%= p.getPaymentMethod()%></p>
                <p><b>Jumlah:</b> Rp <%= String.format("%,.0f", p.getAmount())%></p>


                <div class="mt-3">
                    <b>Bukti:</b><br>
                    <%
                        String proof = p.getProofImage();
                        if (proof != null && !proof.isEmpty()) {
                            // Gunakan request.getContextPath() + "/uploads/" + filename
%>
                    <img src="<%= request.getContextPath() + "/images/payments/" + proof%>"
                         onclick="openImageModal(this.src)"
                         class="w-64 border rounded mt-2 cursor-pointer hover:opacity-90 transition"
                         title="Klik untuk memperbesar">

                    <%
                    } else {
                    %>
                    <p class="text-red-500 text-sm">Bukti pembayaran tidak tersedia</p>
                    <%
                        }
                    %>
                </div>


                <form method="post"
                      action="<%= request.getContextPath()%>/admin/payment/verify"
                      class="mt-4 flex gap-4">

                    <input type="hidden" name="paymentId"
                           value="<%= p.getPaymentId()%>">

                    <input type="hidden" name="orderId"
                           value="<%= p.getOrderId()%>">

                    <button type="submit" name="action" value="approve"
                            class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                        Approve
                    </button>

                    <button type="submit" name="action" value="reject"
                            class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">
                        Reject
                    </button>

                </form>
            </div>

            <%
                    } // end for
                } // end if
%>

        </div>
        <script>
            function openImageModal(src) {
                const modal = document.getElementById("imageModal");
                const img = document.getElementById("modalImage");

                img.src = src;
                modal.classList.remove("hidden");
                modal.classList.add("flex");
            }

            function closeImageModal() {
                const modal = document.getElementById("imageModal");
                modal.classList.add("hidden");
                modal.classList.remove("flex");
            }
        </script>


    </body>
    <!-- IMAGE MODAL -->
    <div id="imageModal"
         class="fixed inset-0 bg-black bg-opacity-80 hidden items-center justify-center z-50">

        <img id="modalImage"
             src=""
             class="max-w-[90%] max-h-[90%] rounded shadow-lg">

        <!-- CLOSE AREA -->
        <div onclick="closeImageModal()"
             class="absolute inset-0 cursor-pointer"></div>
    </div>

</html>
