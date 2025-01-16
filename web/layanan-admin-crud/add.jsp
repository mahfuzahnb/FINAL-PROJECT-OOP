<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Tambah Layanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h2>Tambah Layanan</h2>
            </div>
            <div class="card-body">
                <form method="POST" action="layanan">
                    <input type="hidden" name="action" value="add">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="nama" placeholder="Nama Layanan" required>
                        <label>Nama Layanan</label>
                    </div>
                    <div class="form-floating mb-3">
                        <textarea class="form-control" name="deskripsi" placeholder="Deskripsi Layanan" style="height: 100px" required></textarea>
                        <label>Deskripsi Layanan</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="harga" placeholder="Harga Layanan" required>
                        <label>Harga Layanan</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="durasi" placeholder="Harga Layanan" required>
                        <label>Durasi Layanan</label>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Simpan</button>
                </form>
                <div class="mt-3 text-center">
                    <a href="layanan?menu=view" class="btn btn-secondary">Kembali ke Daftar Layanan</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>