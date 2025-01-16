<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Saldo Tidak Cukup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-danger text-center" role="alert">
            <h4 class="alert-heading">Transaksi Gagal!</h4>
            <p>${message}</p>
            <hr>
            <a href="order?menu=view" class="btn btn-secondary">Kembali ke Pesanan</a>
        </div>
    </div>
</body>
</html>
