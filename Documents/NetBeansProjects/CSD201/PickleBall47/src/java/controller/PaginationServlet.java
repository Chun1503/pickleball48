/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.PickleBallFieldSchedule;

/**
 *
 * @author Minh Trung
 */
@WebServlet(name = "PaginationServlet", urlPatterns = {"/pagination"})
public class PaginationServlet extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaginationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaginationServlet at " + request.getContextPath() + "</h1>");
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
        List<List<PickleBallFieldSchedule>> dataList = (List<List<PickleBallFieldSchedule>>) session.getAttribute("listffs");
        if (dataList == null) {
    dataList = new ArrayList<>(); // Khởi tạo danh sách rỗng nếu giá trị là null
}

        // Pagination logic
        int page = 1;
        int recordsPerPage = 7;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, dataList.size());

        List<List<PickleBallFieldSchedule>> currentPageData = new ArrayList<>();
        if (startIndex <= endIndex) {
            currentPageData = dataList.subList(startIndex, endIndex);
        }
        request.setAttribute("currentPageData", currentPageData);
        request.setAttribute("totalRecords", dataList.size());
        request.setAttribute("recordsPerPage", recordsPerPage);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("timsan.jsp").forward(request, response);

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