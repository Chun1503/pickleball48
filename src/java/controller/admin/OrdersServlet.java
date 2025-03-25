package controller.admin;

import dao.OrderDAO;
import model.Order;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/order-history")
public class OrdersServlet extends HttpServlet {
    
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
        try {
            List<Order> orderList = orderDAO.getOrders();
            req.setAttribute("orderList", orderList);
            req.getRequestDispatcher("/admin/order_history.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
