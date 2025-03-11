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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.CartItem;
import model.Order_Details;
import model.Order_Payments;
import model.Orders;
import model.Products;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        ProductDAO pdao = new ProductDAO();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        boolean isOutStock = false;

        if (cart != null) {
            for (CartItem item : cart.values()) {
                Products p = new Products();
                p = pdao.getProductById(item.getId());
                item.setStock_quantity(p.getStock_quantity());

                if (item.getQuantity() > p.getStock_quantity()) {
                    item.setQuantity(p.getStock_quantity());
                }
                
                if(item.getStock_quantity() < 1){
                    isOutStock = true;
                }
                
                if(p.getStock_quantity() < 0){
                    isOutStock = true;
                }
            }
        }

        if (isOutStock) {
            request.setAttribute("message", "Có sản phẩm hết hàng trong giỏ hàng!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else {
            response.sendRedirect("checkout.jsp");
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
        HttpSession session = request.getSession();
        OrderDAO oDao = new OrderDAO();
        Account acc = (Account) session.getAttribute("account");

        String paymentMethod = request.getParameter("paymentMethod");
        double cartTotal = Double.parseDouble(request.getParameter("cartTotal"));

        Orders o = new Orders(1, acc.getIDAccount(), cartTotal, "default", Timestamp.valueOf(LocalDateTime.now()));
        int orderId = oDao.addOrder(o);

        if (orderId > -1) {
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            List<Order_Details> odList = new ArrayList<>();

            for (CartItem item : cart.values()) {
                double priceDetail = item.getPrice() * item.getQuantity();
                Order_Details temp = new Order_Details(1, orderId, item.getId(), item.getQuantity(), priceDetail);
                odList.add(temp);
            }

            oDao.addOrderDetail(odList);

            Order_Payments op = new Order_Payments(1, acc.getIDAccount(), orderId, cartTotal, paymentMethod, "default", Timestamp.valueOf(LocalDateTime.now()));
            oDao.addPayment(op);

            response.sendRedirect("vnpayajax?cartTotal=" + cartTotal + "&order_id=" + orderId);

        } else {

        }

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
