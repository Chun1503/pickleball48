package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Products;
import model.CartItem;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/addtocart"})
public class AddToCartServlet extends HttpServlet {

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
            out.println("<title>Servlet AddToCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath() + "</h1>");
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

        if (session.getAttribute("account") == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"failed\", \"message\": \"You must login!\"}");
        } else {
            ProductDAO pdao = new ProductDAO();
            String productId = request.getParameter("id");
            String quantityraw = request.getParameter("quantity");

            if (productId == null) {
                response.sendRedirect("index.jsp");
            } else {

                int pid = Integer.parseInt(productId);
                int quantity = Integer.parseInt(quantityraw);
                Products p = pdao.getProductById(pid);

                // Use a Map<Integer, CartItem> instead of List<Map<String, Object>>
                Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

                if (cart == null) {
                    cart = new HashMap<>();
                }

                if (cart.containsKey(pid)) {
                    // If product already exists in cart, update quantity
                    CartItem existingItem = cart.get(pid);
                    int updatedQuantity = existingItem.getQuantity() + quantity;

                    if (updatedQuantity > p.getStock_quantity()) {
                        updatedQuantity = p.getStock_quantity();
                    }

                    existingItem.setQuantity(updatedQuantity);
                } else {
                    // Add new product to cart
                    CartItem newItem = new CartItem(pid, p.getName(), p.getPrice(), quantity, p.getImage(), p.getStock_quantity());
                    cart.put(pid, newItem);
                }

                // Update cart in session
                session.setAttribute("cart", cart);

                // Calculate total items in cart
                int cartSize = 0;
                for (CartItem item : cart.values()) {
                    cartSize += item.getQuantity();
                }
                session.setAttribute("cartSize", cartSize);

                response.setContentType("application/json");
                response.getWriter().write("{\"status\": \"success\", \"message\": \"Added to cart!\"}");
            }
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
