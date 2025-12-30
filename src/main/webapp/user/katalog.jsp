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

    <h2 class="text-2xl font-bold mb-6 text-center">
        Daftar Hewan Qurban
    </h2>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <%  
            List<Animal> animals =
                (List<Animal>) request.getAttribute("animals");

            if (animals != null && !animals.isEmpty()) {
                for (Animal animal : animals) {
        %>
        <div class="bg-white shadow rounded-lg p-4">
            <img
                src="<%= request.getContextPath() %>/assets/img/<%= animal.getPhoto() %>"
                alt="<%= animal.getName() %>"
                class="w-full h-40 object-cover rounded"
            />

            <h3 class="text-lg font-semibold mt-3">
                <%= animal.getName() %>
            </h3>

            <p class="text-green-600 font-bold">
                Rp <%= animal.getPrice() %>
            </p>
            
            <p class="text-gray-600 text-sm">
                <%= animal.getDescription() %>
            </p>
             <a href="<%= request.getContextPath() %>/animalDetail?id=<%= animal.getAnimal_id() %>"
            class="text-blue-600 hover:underline">Lihat Detail</a>
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

</body>
</html>
