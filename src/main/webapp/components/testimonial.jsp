<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.equrban.models.Review" %>

<div class="max-w-6xl mx-auto mt-16">
    <h2 class="text-2xl font-bold text-center mb-8">
        Testimoni Peserta Qurban
    </h2>

    <%
        List<Review> reviews =
            (List<Review>) request.getAttribute("reviews");

        if (reviews != null && !reviews.isEmpty()) {
    %>

    <div class="grid md:grid-cols-3 gap-6">
        <% for (Review r : reviews) { %>
        <div class="bg-white shadow rounded p-4">

            <!-- NAMA USER -->
            <p class="text-sm font-semibold mb-1">
                <%= r.getUserName() %>
            </p>

            <!-- RATING -->
            <p class="text-yellow-500 mb-2">
                <% for (int i = 0; i < r.getRating(); i++) { %>
                    ★
                <% } %>
            </p>

            <!-- KOMENTAR -->
            <p class="text-gray-700 italic mb-3">
                "<%= r.getComment() %>"
            </p>

            <!-- HEWAN -->
            <p class="text-xs text-gray-500">
                Qurban <%= r.getAnimalName() %>
            </p>

        </div>
        <% } %>
    </div>

    <% } else { %>
        <p class="text-center text-gray-500">
            Belum ada testimoni.
        </p>
    <% } %>
</div>
