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

    <img 
    src="<%= request.getContextPath() %>/assets/img/<%= animal.getPhoto() %>"
    alt="<%= animal.getName() %>"class="w-full h-64 object-cover rounded mb-4"/>


        <h2 class="text-2xl font-bold mb-2"><%= animal.getName() %></h2>
        <p class="text-green-600 font-bold text-xl mb-2">
            Rp <%= animal.getPrice() %>
        </p>
        <p class="text-gray-700 mb-4"><%= animal.getDescription() %></p>

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
