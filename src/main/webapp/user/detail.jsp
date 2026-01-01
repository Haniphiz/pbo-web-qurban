<%@ page import="com.equrban.models.Animal" %>

<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />

<html>
    <head>
        <title>Detail Hewan Qurban</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100">
        <%
            Animal animal = (Animal) request.getAttribute("animal");
        %>
        <div class="w-full h-[470px] bg-gray-200 overflow-hidden">
            <img
                src="${pageContext.request.contextPath}/images/animals/<%= animal.getPhoto()%>"
                alt="Foto <%= animal.getName()%>"
                class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                />
        </div>

        <!-- CONTENT -->
        <div class="p-6">

            <h2 class="text-3xl font-bold text-gray-800 mb-3">
                <%= animal.getName()%>
            </h2>

            <p class="text-green-600 font-bold text-2xl mb-4">
                Rp <%= String.format("%,.0f", animal.getPrice())%>
            </p>

            <p class="text-gray-700 leading-relaxed mb-6">
                <%= animal.getDescription()%>
            </p>

            <form action="${pageContext.request.contextPath}/order" method="get">
                <input type="hidden" name="animalId" value="${animal.animal_id}">
                <button type="submit" 
                        class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                    Beli Hewan Ini
                </button>
            </form>
        </div>
    </body>
</html>
