/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.RegisteredPickleBallFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.RegisteredPickleBallField;

/**
 *
 * @author Minh Trung
 */
@WebServlet(name = "UpdateSandadatServlet", urlPatterns = {"/updatesandadat"})
public class UpdateSandadatServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateSandadatServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSandadatServlet at " + request.getContextPath() + "</h1>");
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
        String IDrff_raw = request.getParameter("IDrff");
        int IDrff = Integer.parseInt(IDrff_raw);
        RegisteredPickleBallFieldDAO rffd = new RegisteredPickleBallFieldDAO();
        RegisteredPickleBallField rff = rffd.getRegisteredPickleBallFieldByID(IDrff);
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String date = sdf.format(rff.getDate());
        request.setAttribute("rff", rff);
        request.setAttribute("date", date);
        request.getRequestDispatcher("updatesandadat.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String id_raw = request.getParameter("id");
        String bookerName = request.getParameter("bookerName");
        String phone = request.getParameter("phone");
        String note = request.getParameter("note");
        int id = Integer.parseInt(id_raw);       
        RegisteredPickleBallFieldDAO rffd = new RegisteredPickleBallFieldDAO();
        RegisteredPickleBallField rff = rffd.getRegisteredPickleBallFieldByID(id);
        rffd.updateRegisteredPickleBallField(bookerName,phone,note, id);
        response.sendRedirect("sandadat");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
