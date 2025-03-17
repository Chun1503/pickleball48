<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi Hệ Thống</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            text-align: center;
            padding: 50px;
        }
        .error-container {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 20px;
            border-radius: 8px;
            display: inline-block;
        }
        h1 {
            color: #721c24;
        }
        p {
            font-size: 18px;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #721c24;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #5a1a1d;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>❌ Đã xảy ra lỗi!</h1>
        <p><%= request.getParameter("message") != null ? request.getParameter("message") : "Lỗi không xác định. Vui lòng thử lại sau." %></p>
        <a href="index.jsp" class="btn">🏠 Quay về trang chủ</a>
    </div>
</body>
</html>
