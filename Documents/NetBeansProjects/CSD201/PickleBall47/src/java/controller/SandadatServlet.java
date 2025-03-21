/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.RegisteredPickleBallFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.RegisteredPickleBallField;

/**
 *
 * @author Minh Trung
 */
@WebServlet(name = "SandadatServlet", urlPatterns = {"/sandadat"})
public class SandadatServlet extends HttpServlet {

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
            out.println("<title>Servlet SandadatServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SandadatServlet at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("account");
        if (user == null) {
            response.sendRedirect("login");
        } else
        {

            RegisteredPickleBallFieldDAO rFFD = new RegisteredPickleBallFieldDAO();
            List<RegisteredPickleBallField> listRFF = new ArrayList<>();
            listRFF = rFFD.getRegisteredPickleBallFieldByIDAccount1(user.getIDAccount());
            List<RegisteredPickleBallField> listRFFwithRFO = new ArrayList<>();
            for (RegisteredPickleBallField registeredPickleBallField : listRFFwithRFO) {
                listRFF.add(registeredPickleBallField);
            }
            Collections.reverse(listRFF);
            session.setAttribute("listRFF", listRFF);
            request.getRequestDispatcher("sandadat.jsp").forward(request, response);
        }
    }

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


