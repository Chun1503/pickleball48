
package controller.admin;

import java.io.File;
import dao.ProductDAO;
import model.Products;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.file.Paths;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.sql.Timestamp;


@WebServlet("/admin/products/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            productDAO = new ProductDAO();
        } catch (SQLException e) {
            throw new ServletException("Lỗi kết nối database", e);
        }
    }

    // Danh sách sản phẩm (GET /admin/products)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            try {
                List<Products> products = productDAO.getAllProducts();
                request.setAttribute("products", products);
                request.getRequestDispatcher("/admin/product-list.jsp").forward(request, response);
            } catch (Exception e) {
                throw new ServletException("Lỗi khi lấy danh sách sản phẩm", e);
            }
        } else {
            // Trả về chi tiết sản phẩm (GET /admin/products/{id})
            String[] parts = pathInfo.split("/");
            if (parts.length == 2) {
                try {
                    int productId = Integer.parseInt(parts[1]);
                    Products product = productDAO.getProductById(productId);
                    if (product != null) {
                        request.setAttribute("product", product);
                        request.getRequestDispatcher("/admin/product-detail.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
                } catch (Exception e) {
                    throw new ServletException("Lỗi khi lấy thông tin sản phẩm", e);
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL không hợp lệ");
            }
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String method = request.getParameter("_method");
            if (method != null && method.equalsIgnoreCase("PUT")) {
                doPut(request, response);
            } else {
                request.setCharacterEncoding("UTF-8");

                // Lấy dữ liệu text từ form
                String name = request.getParameter("name");
                String description = request.getParameter("desc");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("qty"));

                // Xử lý upload file
                Part filePart = request.getPart("image"); 
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads") + File.separator + fileName;

                // Lưu file ảnh
                File uploadDir = new File(getServletContext().getRealPath("/uploads"));
                if (!uploadDir.exists()) uploadDir.mkdir(); 
                filePart.write(uploadPath); 

                String imagePath = "uploads/" + fileName;

                Timestamp createdAt = new Timestamp(System.currentTimeMillis());

                Products product = new Products(0, name, description, price, quantity, createdAt, imagePath);
                productDAO.createProduct(product);

                response.sendRedirect(request.getContextPath() + "/admin/products");
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi khi thêm sản phẩm", e);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.split("/").length == 2) {
            try {
                int productId = Integer.parseInt(pathInfo.split("/")[1]);

                // Đọc dữ liệu từ request
                String name = request.getParameter("name");
                String description = request.getParameter("desc");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("qty"));

                // Kiểm tra nếu có file ảnh mới
                Part imagePart = request.getPart("image");
                String imageName = null;
                if (imagePart != null && imagePart.getSize() > 0) {
                    String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                    String uploadDir = getServletContext().getRealPath("/uploads");
                    File uploadFile = new File(uploadDir, fileName);
                    imagePart.write(uploadFile.getAbsolutePath());
                    imageName = fileName;
                } else {
                    // Nếu không có ảnh mới, giữ nguyên ảnh cũ
                    Products existingProduct = productDAO.getProductById(productId);
                    imageName = existingProduct.getImage();
                }

                // Cập nhật sản phẩm
                Timestamp createdAt = new Timestamp(System.currentTimeMillis());
                Products product = new Products(productId, name, description, price, quantity, createdAt, "uploads/" + imageName);
                boolean success = productDAO.updateProduct(product);
                response.sendRedirect(request.getContextPath() + "/admin/products");
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL không hợp lệ");
        }
    }

    // Xóa sản phẩm (DELETE /admin/products/{id})
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.split("/").length == 2) {
            try {
                int productId = Integer.parseInt(pathInfo.split("/")[1]);
                response.setStatus(productId);
                productDAO.deleteProduct(productId);
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi khi xóa sản phẩm");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "URL không hợp lệ");
        }
    }
}