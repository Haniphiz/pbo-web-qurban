<%@ page import="java.util.List, com.equrban.models.Animal" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Katalog Hewan Qurban</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<%@ include file="/layout/head.jsp" %>
<jsp:include page="/components/navbar.jsp" />

<body class="bg-gray-100">
 
    <h2 class="text-2xl font-bold mb-6 text-center mt-6">
        Daftar Hewan Qurban
    </h2>

    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <%
                List<Animal> animals = (List<Animal>) request.getAttribute("animals");

                if (animals != null && !animals.isEmpty()) {
                    for (Animal animal : animals) {

                        String desc = animal.getDescription();
                        int maxLength = 120;

                        if (desc != null && desc.length() > maxLength) {
                            desc = desc.substring(0, maxLength) + "...";
                        }
            %>

            <div class="bg-white shadow rounded-lg p-4 flex flex-col">
                <img
                    src="${pageContext.request.contextPath}/images/animals/<%= animal.getPhoto() %>"
                    alt="Foto <%= animal.getName() %>"
                    class="w-full h-48 object-cover rounded"
                />

                <h3 class="text-lg font-semibold mt-3">
                    <%= animal.getName() %>
                </h3>

                <p class="text-green-600 font-bold text-2xl mb-2">
                    Rp <%= String.format("%,.0f", animal.getPrice()) %>
                </p>

                <!-- DESKRIPSI DIPOTONG -->
                <p class="text-gray-600 text-sm flex-grow">
                    <%= desc %>
                </p>

                <a href="<%= request.getContextPath() %>/animalDetail?id=<%= animal.getAnimal_id() %>"
                   class="inline-block mt-4 px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold text-center hover:opacity-90 transition">
                    Lihat Detail
                </a>
            </div>

            <%
                    }
                } else {
            %>

            <p class="text-gray-600 col-span-3 text-center">
                Belum ada hewan qurban tersedia.
            </p>

            <%
                }
            %>
        </div>
    </div>

</body>
</html>
