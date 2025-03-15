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

        <div id="selected-products" class="selected-products"></div>

        <!-- modals -->

        <dialog data-modal id="add-modal">
          <div class="modal-header">
            <h2>Add Product</h2>
            <a class="modal-close" data-id="add-modal">
              <i class="fa fa-times" style="font-size: 1.5rem; height: 1.5rem"></i>
            </a>
          </div>
          <div>
            <form class="modal-form" id="modal-add-form" method="post">
              <label for="modal-add-name">
                <span>Name</span>
                <input type="text" id="modal-add-name" name="modal-add-name" />
                <p class="modal-error" id="modal-add-name-error"></p>
              </label>
              <label for="modal-add-title">
                <span>Title</span>
                <input type="text" id="modal-add-title" name="modal-add-title" />
                <p class="modal-error" id="modal-add-title-error"></p>
              </label>
              <label for="modal-add-desc" class="modal-desc-label">
                <span>Description</span>
                <textarea id="modal-add-desc" name="modal-add-desc" rows="5" maxlength="400">Enter description here...</textarea>
                <p class="modal-error" id="modal-add-desc-error"></p>
              </label>
              <label for="modal-add-vendor">
                <span>Vendor</span>
                <input type="text" id="modal-add-vendor" name="modal-add-vendor" />
                <p class="modal-error" id="modal-add-vendor-error"></p>
              </label>
              <label for="modal-add-product-type">
                <span>Product Type</span>
                <input type="text" id="modal-add-product-type" name="modal-add-product-type" />
                <p class="modal-error" id="modal-add-product-type-error"></p>
              </label>
              <label for="modal-add-address" class="modal-address-label">
                <span>Address</span>
                <input type="text" id="modal-add-address" name="modal-add-address" />
                <p class="modal-error" id="modal-add-address-error"></p>
              </label>
              <label for="modal-add-in-stock">
                <span>In Stock</span>
                <input type="number" id="modal-add-in-stock" name="modal-add-in-stock" min="0" />
              </label>
              <label for="modal-add-buying-price">
                <span>Buying Price</span>
                <input type="number" id="modal-add-buying-price" name="modal-add-buying-price" min="0" />
              </label>
              <label for="modal-add-sale-price">
                <span>Sale Price</span>
                <input type="number" id="modal-add-sale-price" name="modal-add-sale-price" min="0" />
              </label>
              <label for="modal-add-purchase-quantity">
                <span>Purchase Quantity</span>
                <input type="number" id="modal-add-purchase-quantity" name="modal-add-purchase-quantity" min="0" />
              </label>
              <label for="modal-add-shipping-rates">
                <span>Shipping Rates</span>
                <input type="number" id="modal-add-shipping-rates" name="modal-add-shipping-rates" min="0" />
              </label>
              <label for="modal-add-refill-limit">
                <span>Refill Limit</span>
                <input type="number" id="modal-add-refill-limit" name="modal-add-refill-limit" min="0" />
              </label>

              <div class="modal-buttons">
                <button type="button" class="cancel" formmethod="dialog" id="add-close-button">Cancel</button>
                <button type="submit" class="submit">Submit</button>
              </div>
            </form>
          </div>
        </dialog>

        <dialog data-modal id="view-modal">
          <div class="modal-header">
            <h2>Product Details</h2>
            <button class="modal-close" data-id="view-modal">
              <i class="fa fa-times" style="font-size: 1.5rem; height: 1.5rem"></i>
            </button>
          </div>
          <div class="view-container">
            <div class="view-content">
              <span>Name</span>
              <p id="modal-view-name">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Title</span>
              <p id="modal-view-title">Dummy Text</p>
            </div>
            <div class="view-content view-desc">
              <span>Description</span>
              <p id="modal-view-desc">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Vendor</span>
              <p id="modal-view-vendor">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Product Type</span>
              <p id="modal-view-product-type">Dummy Text</p>
            </div>
            <div class="view-content view-address">
              <span>Address</span>
              <p id="modal-view-address">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>In Stock</span>
              <p id="modal-view-in-stock">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Buying Price</span>
              <p id="modal-view-buying-price">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Sale Price</span>
              <p id="modal-view-sale-price">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Purchase Quantity</span>
              <p id="modal-view-purchase-quantity">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Shipping Rates</span>
              <p id="modal-view-shipping-rates">Dummy Text</p>
            </div>
            <div class="view-content">
              <span>Refill Limit</span>
              <p id="modal-view-refill-limit">Dummy Text</p>
            </div>

            <div class="modal-buttons">
              <button class="close" id="view-close-button">Close</button>
            </div>
          </div>
        </dialog>

        <dialog data-modal id="edit-modal">
          <div class="modal-header">
            <h2>Edit Product</h2>
            <a class="modal-close" data-id="edit-modal">
              <i class="fa fa-times" style="font-size: 1.5rem; height: 1.5rem"></i>
            </a>
          </div>
          <div>
            <form class="modal-form" id="modal-edit-form" method="post">
              <label for="modal-edit-name">
                <span>Name</span>
                <input type="text" id="modal-edit-name" name="modal-edit-name" />
                <p class="modal-error" id="modal-edit-name-error"></p>
              </label>
              <label for="modal-edit-title">
                <span>Title</span>
                <input type="text" id="modal-edit-title" name="modal-edit-title" />
                <p class="modal-error" id="modal-edit-title-error"></p>
              </label>
              <label for="modal-edit-desc" class="modal-desc-label">
                <span>Description</span>
                <textarea id="modal-edit-desc" name="modal-edit-desc" rows="5"></textarea>
                <p class="modal-error" id="modal-edit-desc-error"></p>
              </label>
              <label for="modal-edit-vendor">
                <span>Vendor</span>
                <input type="text" id="modal-edit-vendor" name="modal-edit-vendor" />
                <p class="modal-error" id="modal-edit-vendor-error"></p>
              </label>
              <label for="modal-edit-product-type">
                <span>Product Type</span>
                <input type="text" id="modal-edit-product-type" name="modal-edit-product-type" />
                <p class="modal-error" id="modal-edit-product-type-error"></p>
              </label>
              <label for="modal-edit-address" class="modal-address-label">
                <span>Address</span>
                <input type="text" id="modal-edit-address" name="modal-edit-address" />
                <p class="modal-error" id="modal-edit-address-error"></p>
              </label>
              <label for="modal-edit-in-stock">
                <span>In Stock</span>
                <input type="number" id="modal-edit-in-stock" name="modal-edit-in-stock" min="0" />
              </label>
              <label for="modal-edit-buying-price">
                <span>Buying Price</span>
                <input type="number" id="modal-edit-buying-price" name="modal-edit-buying-price" min="0" />
              </label>
              <label for="modal-edit-sale-price">
                <span>Sale Price</span>
                <input type="number" id="modal-edit-sale-price" name="modal-edit-sale-price" min="0" />
              </label>
              <label for="modal-edit-purchase-quantity">
                <span>Purchase Quantity</span>
                <input type="number" id="modal-edit-purchase-quantity" name="modal-edit-purchase-quantity" min="0" />
              </label>
              <label for="modal-edit-shipping-rates">
                <span>Shipping Rates</span>
                <input type="number" id="modal-edit-shipping-rates" name="modal-edit-shipping-rates" min="0" />
              </label>
              <label for="modal-edit-refill-limit">
                <span>Refill Limit</span>
                <input type="number" id="modal-edit-refill-limit" name="modal-edit-refill-limit" min="0" />
              </label>

              <div class="modal-buttons">
                <button type="button" class="cancel" formmethod="dialog" id="edit-close-button">Cancel</button>
                <button type="submit" class="submit">Submit</button>
              </div>
            </form>
          </div>
        </dialog>

        <dialog data-modal id="delete-modal">
          <div class="delete-modal-wrapper">
            <h2>Warning!</h2>
            <div class="delete-modal-text">
              <p>Are you sure you want to delete this product?</p>
              <div class="modal-buttons">
                <button class="cancel" id="delete-close-button">Cancel</button>
                <button class="delete" id="delete-delete-button">Delete</button>
              </div>
            </div>
          </div>
        </dialog>
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