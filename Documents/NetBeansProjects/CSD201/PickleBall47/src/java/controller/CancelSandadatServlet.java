/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.RegisteredPickleBallFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Minh Trung
 */
@WebServlet(name = "CancelSandadatServlet", urlPatterns = {"/cancelsandadat"})
public class CancelSandadatServlet extends HttpServlet {

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
            out.println("<title>Servlet CancelSandadatServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelSandadatServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String IDrff_raw = request.getParameter("IDrff");
        int IDrff = Integer.parseInt(IDrff_raw);
        RegisteredPickleBallFieldDAO rFFD = new RegisteredPickleBallFieldDAO();
        LocalTime startTime = rFFD.getRegisteredPickleBallFieldByID(IDrff).getPickleBallFieldSchedule().getStartTime().toLocalTime();
        LocalTime now = LocalTime.now();

        int differenceMinutes = (int) startTime.until(now, java.time.temporal.ChronoUnit.MINUTES);
        int differenceHours = differenceMinutes / -60; // Số giờ chênh lệch
        // Lấy ngày hiện tại
        LocalDate currentDate = LocalDate.now();

        // Chuyển đổi thành java.sql.Date
        Date sqlDate = Date.valueOf(currentDate);
        //nếu >=1 thì cho phép hủy sân và hoàn cọc set status = 4, còn không thì mất cọc status = 6
        if (differenceHours >= 1 && sqlDate.equals(rFFD.getRegisteredPickleBallFieldByID(IDrff).getDate())) {
            rFFD.changeStatusWithIDRegisteredPickleBallField(4, IDrff);
        } else if (!sqlDate.equals(rFFD.getRegisteredPickleBallFieldByID(IDrff).getDate())) {
            rFFD.changeStatusWithIDRegisteredPickleBallField(4, IDrff);
        } else {
            rFFD.changeStatusWithIDRegisteredPickleBallField(6, IDrff);
        }
        response.sendRedirect("sandadat");
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
