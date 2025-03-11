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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.Order_Details;
import model.Orders;
import model.Products;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/orderhistory", "/orderdetail"})
public class OrderHistoryServlet extends HttpServlet {

    protected static final int ITEM_PER_PAGE = 10;

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
            out.println("<title>Servlet OrderHistoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderHistoryServlet at " + request.getContextPath() + "</h1>");
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
        String servletPath = request.getServletPath();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc != null) {
            switch (servletPath) {
                case "/orderhistory": {
                    getOrderHistory(request, response, acc, session);
                    break;
                }
                case "/orderdetail": {
                    getOrderDetail(request, response, acc, session);
                    break;
                }
            }
        } else {
            request.setAttribute("errorMessage", "You must login first!");
            request.getRequestDispatcher("sign-in.jsp").forward(request, response);
        }
    }

    protected void getOrderHistory(HttpServletRequest req, HttpServletResponse resp, Account acc, HttpSession session) throws ServletException, IOException {
        try {
            OrderDAO odao = new OrderDAO();

            String pageRaw = req.getParameter("page");
            String dateRaw = req.getParameter("dateFilter");
            String statusRaw = req.getParameter("statusFilter");

            int page = (pageRaw == null || pageRaw.isEmpty()) ? 1 : Integer.parseInt(pageRaw);

            Date date = null;
            if (dateRaw != null && !dateRaw.isEmpty()) {
                try {
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    date = formatter.parse(dateRaw);
                } catch (ParseException e) {
                    Logger.getLogger(OrderHistoryServlet.class.getName()).log(Level.WARNING, "Error parsing date: " + dateRaw, e);
                }
            }

            String status = "";
            if (statusRaw != null && !statusRaw.isEmpty()) {
                status = statusRaw;
            }

            int offset = (page - 1) * ITEM_PER_PAGE;

            List<Orders> oList = odao.getListOrderByUserId(acc.getIDAccount(), date, status, ITEM_PER_PAGE, offset);
            int totalOrders = odao.getListOrderByUserId(acc.getIDAccount(), date, status, Integer.MAX_VALUE, 0).size();

            int itemFrom = offset + 1;
            int itemTo = Math.min(offset + ITEM_PER_PAGE, totalOrders);

            int totalPage = (int) Math.ceil((double) totalOrders / ITEM_PER_PAGE);

            req.setAttribute("oList", oList);
            req.setAttribute("page", page);
            req.setAttribute("totalItems", totalOrders);
            req.setAttribute("totalPage", totalPage);
            req.setAttribute("itemFrom", itemFrom);
            req.setAttribute("itemTo", itemTo);
            req.getRequestDispatcher("orderhistory.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    protected void getOrderDetail(HttpServletRequest req, HttpServletResponse resp, Account acc, HttpSession session) throws ServletException, IOException {
        OrderDAO odao = new OrderDAO();
        ProductDAO pdao = new ProductDAO();

        int oid = Integer.parseInt(req.getParameter("oid"));

        Orders o = odao.getOrderById(oid);

        if (o.getUser_id() != acc.getIDAccount()) {
            req.setAttribute("errorMessage", "Suspect, You cannot view Order History not yours!");
            session.invalidate();
            req.getRequestDispatcher("sign-in.jsp").forward(req, resp);
            return;
        }

        List<Integer> pidList = odao.getListProductIdByOrderId(oid);
        List<Products> pList = pdao.getListProductsByListProductId(pidList);
        List<Order_Details> odList = odao.getListOrderDetailsByOrderId(oid);

        req.setAttribute("odList", odList);
        req.setAttribute("plist", pList);
        req.setAttribute("o", o);
        req.getRequestDispatcher("orderdetail.jsp").forward(req, resp);
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
