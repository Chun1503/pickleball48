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
    <link rel="stylesheet" href="https://cdn.datatables.net/2.2.2/css/dataTables.bootstrap5.css" />
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
    <div class="sidebar active">
      <div class="top">
        <div class="logo">
          <!-- <i class="bx bxl-codepen"></i> -->
          <span>Quản lý</span>
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
            <span class="nav-item">Thống kê</span>
          </a>
          <span class="tooltip">Thống kê</span>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/admin/products">
            <i style="font-size: 30px" class="bx bxs-shopping-bag"></i>
            <span class="nav-item">Sản phẩm</span>
          </a>
          <span class="tooltip">Sản phẩm</span>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/admin/order-history">
            <i style="font-size: 30px" class="bx bx-list-check"></i>
            <span class="nav-item">Đơn đặt</span>
          </a>
          <span class="tooltip">Đơn đặt</span>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/admin/order-payment">
            <i style="font-size: 30px" class="bx bxs-food-menu"></i>
            <span class="nav-item">Thanh toán</span>
          </a>
          <span class="tooltip">Thanh toán</span>
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
            <span class="nav-item">Vận chuyển</span>
          </a>
          <span class="tooltip">Vận chuyển</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-cog"></i>
            <span class="nav-item">Cài đặt</span>
          </a>
          <span class="tooltip">Cài đặt</span>
        </li>
        <li>
          <a href="#" id="logout">
            <i style="font-size: 30px" class="bx bx-log-out"></i>
            <span class="nav-item">Đăng xuất</span>
          </a>
          <span class="tooltip">Đăng xuất</span>
        </li>
      </ul>
    </div>

    <!-- data table  -->
    <main class="main-content">
      <div class="header"></div>
      <div class="data-table">
        <div class="success-message" id="success-message" style="display: none">
          <div class="success-text">
            <p>Dummy Text</p>
            <a id="success-message-cross" style="cursor: pointer">
              <i class="fa fa-times" style="font-size: 1.5rem; height: 1.5rem"></i>
            </a>
          </div>
          <div class="progress-container">
            <div class="progress-bar" id="progressBar"></div>
          </div>
        </div>
        <div class="toolbar">
          <div class="toolbar-button-wrapper">
            <a href="product-add.jsp">
                <button class="toolbar-button add-product-button" id="add-product-toolbar">
                  <span>Thêm sản phẩm</span>
                  <i class="bx bx-plus-medical"></i>
                </button>
            </a>
          </div>
        </div>
        <div class="table-container">

        <table id="example" class="table table-striped" style="width:100%; padding: 30px">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên</th>
                    <th>Mô tả</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td> <!-- STT tự động tăng -->
                        <td>${product.name}</td>
                        <td>${product.description}</td>
                        <td>${product.price}</td>
                        <td>${product.stock_quantity}</td>
                        <td>
                            <a href="/PickleBall47/admin/products/${product.product_id}" class="btn btn-warning">Sửa</a>
                            <a href="#" class="btn btn-danger" onclick="deleteProduct(${product.product_id}); return false;">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

      </div>
    </main>
  </body>
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.datatables.net/2.2.2/js/dataTables.js"></script>
  <script src="https://cdn.datatables.net/2.2.2/js/dataTables.bootstrap5.js"></script>
  <script>
      new DataTable('#example');
      function deleteProduct(productId) {
          console.log(productId);
        if (confirm('Bạn có chắc chắn muốn xóa?')) {
            fetch("/PickleBall47/admin/products/" + productId, {  // Gửi request DELETE với path parameter
                method: 'DELETE'
            })
            .then(response => {
                console.log(productId);
                console.log(response);
                if (response.ok) {
                    alert("Xóa thành công!");
                    window.location.reload();
                } else {
                    alert("Lỗi khi xóa sản phẩm!");
                }
            })
            .catch(error => console.error('Lỗi:', error));
        }
    }
  </script>
</html>