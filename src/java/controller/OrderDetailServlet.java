package controller;

import model.Order;
import dao.OrderDAO;
import model.OrderDetail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/order-detail")
public class OrderDetailServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            orderDAO = new OrderDAO();
        } catch (SQLException e) {
            throw new ServletException("Lỗi kết nối database", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy orderId từ URL
            int orderId = Integer.parseInt(req.getParameter("orderId"));

            // Lấy thông tin đơn hàng từ database
            Order order = orderDAO.getOrderById(orderId);
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(orderId);

            // Gửi dữ liệu sang JSP
            req.setAttribute("order", order);
            req.setAttribute("orderDetails", orderDetails);
            req.getRequestDispatcher("/admin/order_detail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("/admin/order-history.jsp?error=invalid_order");
        }
    }
}
