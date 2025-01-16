<%-- 
    Document   : editProfile
    Created on : 27 Dec 2024, 21.40.49
    Author     : Asus
--%>
<%@page import="models.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    Customer customer = (Customer) request.getAttribute("customer");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Edit Profile</h2>
                        <form action="<%= request.getContextPath() %>/customerr?action=editProfile" method="POST">
                             
                            <input type="hidden" id="id" name="id" value="<%= customer.getId() %>">
                             
                            <div class="mb-3">
                                <label for="username" class="form-label">Username:</label>
                                <input type="text" id="username" name="username" class="form-control" value="<%=customer.getUsername()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" id="email" name="email" class="form-control" value="<%=customer.getEmail()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="name" class="form-label">Nama Lengkap:</label>
                                <input type="text" id="name" name="name" class="form-control" value="<%=customer.getName()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Alamat:</label>
                                <input type="text" id="address" name="address" class="form-control" value="<%=customer.getAddress()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Nomor Telepon:</label>
                                <input type="text" id="phone" name="phone" class="form-control" value="<%=customer.getPhone()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password:</label>
                                <input type="password" id="password" name="password" class="form-control" value="<%=customer.getPassword()%>" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                            <a class="btn btn-secondary" href="<%= request.getContextPath() %>/customerr/profile" role="button">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

