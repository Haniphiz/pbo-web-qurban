<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>

<%@ include file="/layout/head.jsp" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Tambah Hewan Qurban</title>
    <script src="https://cdn.tailwindcss.com"></script>

</head>
<body class="bg-gray-100">

<!-- NAVBAR -->
<jsp:include page="/components/navbar.jsp" />

<div class="max-w-3xl mx-auto p-6">

    <!-- HEADER -->
    <div class="mb-6">
        <h1 class="text-2xl font-bold text-primary">Tambah Hewan Qurban</h1>
        <p class="text-gray-600">Isi data hewan untuk ditampilkan di katalog</p>
    </div>

    <!-- CARD FORM -->
    <div class="bg-white shadow rounded-xl p-6">

        <form method="post"
              action="<%= request.getContextPath() %>/admin/animal/add"
              enctype="multipart/form-data"
              class="space-y-5">

            <!-- NAMA -->
            <div>
                <label class="block font-semibold mb-1">Nama Hewan</label>
                <input type="text" name="name" required
                       class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none">
            </div>

            <!-- KATEGORI -->
            <div>
                <label class="block font-semibold mb-1">Kategori</label>
                <select name="category_id" required
                        class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none">
                    <option value="">-- Pilih Kategori --</option>
                    <option value="1">Sapi</option>
                    <option value="2">Kambing</option>
                    <option value="3">Domba</option>
                </select>
            </div>

            <!-- GRID -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                <div>
                    <label class="block font-semibold mb-1">Umur (tahun)</label>
                    <input type="number" name="age" min="0"
                           class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none">
                </div>

                <div>
                    <label class="block font-semibold mb-1">Berat (kg)</label>
                    <input type="number" step="0.01" name="weight"
                           class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none">
                </div>

                <div>
                    <label class="block font-semibold mb-1">Harga</label>
                    <input type="number" step="0.01" name="price" required
                           class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none">
                </div>

                <div>
                    <label class="block font-semibold mb-1">Stok</label>
                    <input type="number" name="stock" value="1"
                           class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none">
                </div>

            </div>

            <!-- DESKRIPSI -->
            <div>
                <label class="block font-semibold mb-1">Deskripsi</label>
                <textarea name="description" rows="3"
                          class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary outline-none"></textarea>
            </div>

            <!-- FOTO -->
            <div>
                <label class="block font-semibold mb-1">Foto Hewan</label>
                <input type="file" name="photo" accept="image/*" required
                       class="w-full border rounded-lg px-3 py-2 bg-white">
            </div>

            <!-- BUTTON -->
            <div class="flex justify-end gap-3 pt-4">
                <a href="<%= request.getContextPath() %>/admin/dashboard"
                   class="px-5 py-2 rounded-lg border text-gray-600 hover:bg-gray-100">
                    Batal
                </a>

                <button type="submit"
                        class="px-5 py-2 rounded-lg bg-primary text-white font-semibold hover:opacity-90 transition">
                    Simpan Hewan
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>
