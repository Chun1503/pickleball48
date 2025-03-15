<%-- 
    Document   : product-list
    Created on : 14 thg 3, 2025, 21:23:04
    Author     : Asus
--%>

<%@ page import="java.util.List, model.Products" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Danh Sách Sản Phẩm</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Quản lý Sản phẩm</h2>
    <a href="add-product.jsp">Thêm sản phẩm</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tên sản phẩm</th>
            <th>Mô tả</th>
            <th>Giá</th>
            <th>Tồn kho</th>
            <th>Ngày tạo</th>
            <th>Hành động</th>
        </tr>
        <%
            List<Products> products = (List<Products>) request.getAttribute("products");
            if (products != null) {
                for (Products product : products) {
        %>
        <tr>
            <td><%= product.getProduct_id() %></td>
            <td><%= product.getName() %></td>
            <td><%= product.getDescription() %></td>
            <td><%= product.getPrice() %> VND</td>
            <td><%= product.getStock_quantity() %></td>
            <td><%= product.getCreated_at() %></td>
            <td>
                <a href="edit-product.jsp?id=<%= product.getProduct_id() %>">Sửa</a> | 
                <a href="delete-product?id=<%= product.getProduct_id() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
