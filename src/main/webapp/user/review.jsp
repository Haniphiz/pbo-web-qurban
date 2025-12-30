<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    Integer animalId = (Integer) request.getAttribute("animalId");
    if (animalId == null) {
        response.sendRedirect(request.getContextPath() + "/riwayat");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Beri Ulasan</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
        select, textarea, button {
            width: 100%;
            margin-top: 8px;
            padding: 10px;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        button {
            margin-top: 20px;
            background: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background: #218838;
        }
        .back {
            margin-top: 15px;
            text-align: center;
        }
        .back a {
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Beri Ulasan</h2>

    <form action="<%= request.getContextPath() %>/review" method="post">
        
        <!-- KIRIM animalId -->
        <input type="hidden" name="animalId" value="<%= animalId %>">

        <label for="rating">Rating</label>
        <select name="rating" id="rating" required>
            <option value="">-- Pilih Rating --</option>
            <option value="5">★★★★★ (Sangat Baik)</option>
            <option value="4">★★★★☆ (Baik)</option>
            <option value="3">★★★☆☆ (Cukup)</option>
            <option value="2">★★☆☆☆ (Kurang)</option>
            <option value="1">★☆☆☆☆ (Buruk)</option>
        </select>

        <label for="comment">Ulasan</label>
        <textarea name="comment" id="comment" placeholder="Tulis ulasan Anda..." required></textarea>

        <button type="submit">Kirim Ulasan</button>
    </form>

    <div class="back">
        <a href="<%= request.getContextPath() %>/riwayat">← Kembali ke Riwayat</a>
    </div>
</div>

</body>
</html>
