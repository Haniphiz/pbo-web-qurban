
<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />


<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="max-w-md mx-auto mt-20 bg-white p-8 rounded-lg shadow">
    <h2 class="text-2xl font-bold mb-4 text-center">Login</h2>

    <% if (request.getParameter("error") != null) { %>
        <p class="text-red-600 text-center mb-3">Email atau password salah!</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-4">
        <div>
            <label>Email</label>
            <input type="email" name="email" required class="w-full border p-2 rounded">
        </div>
        <div>
            <label>Password</label>
            <input type="password" name="password" required class="w-full border p-2 rounded">
        </div>
        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
            Login
        </button>
    </form>

    <div class="text-right mt-4">
        <span class="text-sm text-gray-600">Belum punya akun?</span>
        <a href="register.jsp" class="text-sm text-blue-600 hover:underline font-semibold">Daftar</a>
    </div>
</div>

</body>
</html>
