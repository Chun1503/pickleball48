package controller.admin;

import dao.OrderPaymentDAO;
import model.Order;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/order-payment")
public class OrdersPaymentServlet extends HttpServlet {
    
    private OrderPaymentDAO orderPaymentDAO;

    @Override
    public void init() throws ServletException {
        try {
            orderPaymentDAO = new OrderPaymentDAO();
        } catch (SQLException e) {
            throw new ServletException("Lỗi kết nối database", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
        try {
            List<Order> orderList = orderPaymentDAO.getListOrderPayment();
            req.setAttribute("orderList", orderList);
            req.getRequestDispatcher("/admin/order_payment.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
