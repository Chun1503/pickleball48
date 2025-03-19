/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Products;

@WebServlet(name = "ProductList", urlPatterns = {"/productlist"})
public class ProductListServlet extends HttpServlet {

    private static final int ITEM_PER_PAGE = 10;

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
            out.println("<title>Servlet ProductList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductList at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(true);
        ProductDAO pdao = new ProductDAO();

        try {

            String pageRaw = request.getParameter("page");
            String searchTerm = request.getParameter("search");
            String priceTerm = request.getParameter("price");

            if (searchTerm == null) {
                searchTerm = "";
            }

            double price = 0;
            if (priceTerm != null && !priceTerm.isEmpty()) {
                price = Double.parseDouble(priceTerm);
            }

            int page = (pageRaw == null || pageRaw.isEmpty()) ? 1 : Integer.parseInt(pageRaw);
            int offset = (page - 1) * ITEM_PER_PAGE;

            List<Products> pList = pdao.getAllProduct(ITEM_PER_PAGE, offset, searchTerm, price);
            int totalProduct = pdao.getAllProduct(0, 0, searchTerm, price).size();

            int itemFrom = totalProduct == 0 ? 0 : offset + 1;
            int itemTo = Math.min(offset + ITEM_PER_PAGE, totalProduct);

            int totalPage = (int) Math.ceil((double) totalProduct / ITEM_PER_PAGE);

            request.setAttribute("totalItems", totalProduct);
            request.setAttribute("page", page);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("itemFrom", itemFrom);
            request.setAttribute("itemTo", itemTo);
            request.setAttribute("pList", pList);
        } catch (Exception e) {
            System.out.println(e);
        }

        request.getRequestDispatcher("productlist.jsp").forward(request, response);
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
