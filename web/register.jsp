<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - EasyKost</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 500px;
            margin-top: 100px;
        }
        .btn-register {
            background-color: #56c4e3;
            color: white;
            width: 100%;
        }
        .btn-register:hover {
            background-color: #E85C51;
        }
        /* Styling Navbar */
    .navbar {
        background-color: #f8f9fa;
        padding: 10px 20px;
    }

    .navbar-brand {
        font-size: 1.5rem;
        font-weight: bold;
        color: #007bff;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: color 0.3s;
    }

    .navbar-brand:hover {
        color: #0056b3;
    }

    .nav-item .nav-link {
        font-size: 1rem;
        font-weight: 500;
        color: #555;
        transition: color 0.3s, padding-left 0.3s;
    }

    .nav-item .nav-link:hover {
        color: #007bff;
        padding-left: 10px;
    }

    .navbar-nav .nav-item {
        margin-left: 15px;
    }

    /* Toggler Icon Styling */
    .navbar-toggler-icon {
        background-color: #007bff;
    }

        /* Responsiveness */
        @media (max-width: 991px) {
            .navbar-nav {
                text-align: center;
            }
            .navbar-nav .nav-item {
                margin-bottom: 10px;
            }
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 28px;
            }

            .service-card h5 {
                font-size: 16px;
            }

            .service-card p {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-primary" href="<%= request.getContextPath() %>/home">EasyKost</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/home">Layanan</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="home?action=login">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="home?action=register">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Register Form -->
    <div class="container my-4">
        <h2 class="text-center">Register</h2>
        <form method="POST" action="<%= request.getContextPath() %>/register">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" name="username" placeholder="Username" required>
                <label>Username</label>
            </div>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
                <label>Password</label>
            </div>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
                <label>Confirm Password</label>
            </div>
            <button type="submit" class="btn btn-register">Register</button>
        </form>
        <div class="text-center mt-3">
            <p>Already have an account? <a href="home?action=login">Login here</a></p>
        </div>
        <% if (request.getParameter("error") != null && request.getParameter("error").equals("exists")) { %>
        <div class="alert alert-danger mt-3 text-center">
            Username already exists!
        </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>