/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;
import model.Order_Details;

/**
 *
 * @author hoang
 */
@WebServlet(name = "VNPayReturnServlet", urlPatterns = {"/vnpayreturn"})
public class VNPayReturnServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VNPayReturnServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VNPayReturnServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO pDao = new ProductDAO();
        OrderDAO oDao = new OrderDAO();
        HttpSession session = request.getSession();
        String orderId = (String) session.getAttribute("orderId");
        String transactionStatus = request.getParameter("vnp_TransactionStatus");

        if (transactionStatus.equalsIgnoreCase("00")) {
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            List<CartItem> ciList = new ArrayList<>();

            for (CartItem item : cart.values()) {
                pDao.updateQuantity(item.getId(), item.getStock_quantity() - item.getQuantity());
                ciList.add(item);
            }

            oDao.updateOrderStatus(Integer.parseInt(orderId), "completed");
            oDao.updatePaymentStatus(Integer.parseInt(orderId), "completed");

            session.removeAttribute("cart");
            session.removeAttribute("cartSize");

            request.setAttribute("message", "Cảm ơn bạn đã đặt hàng. Chúng tôi sẽ sớm xác nhận đơn hàng của bạn.");
            request.setAttribute("orderstatus", "Chúc mừng, bạn đã đặt hàng thành công!");
            request.setAttribute("ciList", ciList);
            request.getRequestDispatcher("successpay.jsp").forward(request, response);
        } else {

            oDao.updateOrderStatus(Integer.parseInt(orderId), "cancelled");
            oDao.updatePaymentStatus(Integer.parseInt(orderId), "cancelled");

            session.removeAttribute("cart");
            session.removeAttribute("cartSize");
            request.setAttribute("message", "Ui bạn huỷ đơn hàng mất rồi, nếu có sai sót gì mong bạn feedback lại cho tụi mình nhé!");
            request.setAttribute("orderstatus", "Bạn đã huỷ đơn hàng!");
            request.getRequestDispatcher("successpay.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
