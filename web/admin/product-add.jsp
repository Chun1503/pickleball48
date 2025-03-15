<%-- 
    Document   : list
    Created on : Mar 15, 2025, 12:58:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Product Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/data-table.css" />
  </head>
  <body>
    <!-- sidebar  -->
    <div class="sidebar">
      <div class="top">
        <div class="logo">
          <!-- <i class="bx bxl-codepen"></i> -->
          <span>Product Management</span>
        </div>
        <i style="font-size: 30px"  class="bx bx-menu" id="sidebar-menu-btn"></i>
      </div>
      <div class="user">
        <i class="bx bxs-user-rectangle user-img"></i>
        <div class="user-info">
          <p class="bold" id="sidebar-username"></p>
          <p id="sidebar-user-email"></p>
        </div>
      </div>
      <ul style="padding-left: 0">
        <li>
          <a href="#">
              <i style="font-size: 30px" class="bx bxs-grid-alt"></i>
            <span class="nav-item">Dashboard</span>
          </a>
          <span class="tooltip">Dashboard</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bxs-shopping-bag"></i>
            <span class="nav-item">Products</span>
          </a>
          <span class="tooltip">Products</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-list-check"></i>
            <span class="nav-item">Catagories</span>
          </a>
          <span class="tooltip">Catagories</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bxs-food-menu"></i>
            <span class="nav-item">Orders</span>
          </a>
          <span class="tooltip">Orders</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-body"></i>
            <span class="nav-item">Customers</span>
          </a>
          <span class="tooltip">Customers</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-location-plus"></i>
            <span class="nav-item">Shipping</span>
          </a>
          <span class="tooltip">Shipping</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-cog"></i>
            <span class="nav-item">Settings</span>
          </a>
          <span class="tooltip">Settings</span>
        </li>
        <li>
          <a href="#" id="logout">
            <i style="font-size: 30px" class="bx bx-log-out"></i>
            <span class="nav-item">Logout</span>
          </a>
          <span class="tooltip">Logout</span>
        </li>
      </ul>
    </div>

    <main class="main-content container" style="width: 90%">
          <div class="modal-header">
            <h2>Thêm sản phẩm</h2>
          </div>
          <div>
            <form class="modal-form" id="modal-add-form" method="post" action="${pageContext.request.contextPath}/admin/products" enctype="multipart/form-data">
              <label for="modal-add-name">
                <span>Tên sản phẩm</span>
                <input type="text" id="modal-add-name" name="name" />
                <p class="modal-error" id="modal-add-name-error"></p>
              </label>
              <label for="modal-add-title">
                <span>Giá</span>
                <input type="number" id="modal-add-title" name="price" />
                <p class="modal-error" id="modal-add-title-error"></p>
              </label>
              <label for="modal-add-vendor">
                <span>Số lượng</span>
                <input type="number" id="modal-add-vendor" name="qty" />
                <p class="modal-error" id="modal-add-vendor-error"></p>
              </label>
              <label for="modal-add-image">
                <span>Hình ảnh</span>
                <input type="file" id="modal-add-image" name="image" accept="image/*" />
                <p class="modal-error" id="modal-add-image-error"></p>
              </label>
              <label for="modal-add-desc" class="modal-desc-label">
                <span>Mô tả</span>
                <textarea id="modal-add-desc" name="desc" rows="5" maxlength="400">Enter description here...</textarea>
                <p class="modal-error" id="modal-add-desc-error"></p>
              </label>

              <div class="modal-buttons">
                <button type="button" class="cancel" formmethod="dialog" id="add-close-button">Hủy</button>
                <button type="submit" class="submit">Thêm</button>
              </div>
            </form>
          </div>
    </main>
  </body>
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</html>