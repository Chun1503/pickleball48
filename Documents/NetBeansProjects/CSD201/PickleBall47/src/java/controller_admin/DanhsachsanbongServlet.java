/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller_admin;

import dao.PickleBallFieldDAO;
import dao.PickleBallFieldScheduleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.PickleBallField;
import model.PickleBallFieldSchedule;

/**
 *
 * @author Minh Trung
 */
@WebServlet(name = "Capnhatsanbong", urlPatterns = {"/admin/danhsachsanbong"})
public class DanhsachsanbongServlet extends HttpServlet {

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
            out.println("<title>Servlet Capnhatsanbong</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Capnhatsanbong at " + request.getContextPath() + "</h1>");
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
        PickleBallFieldDAO ffD = new PickleBallFieldDAO();
        PickleBallFieldScheduleDAO ffsD = new PickleBallFieldScheduleDAO();
        List<PickleBallField> listFF = new ArrayList<>();
        
        listFF = ffD.getPickleBallFields();
//        listffandffs lưu lại danh sách lịch sân với id từng sân
        List<List<PickleBallFieldSchedule>> listffandffs = new ArrayList<>();
        for (PickleBallField pickleBallField : listFF) {
            List<PickleBallFieldSchedule> listffs = ffsD.getPickleBallFieldScheduleByIDPickleBallFieldWithStatus(pickleBallField.getIDPickleBallField());
            if(listffs.size()==0){
               PickleBallFieldSchedule ffs = new PickleBallFieldSchedule(0, null, null, pickleBallField, 0);
                listffs.add(0, ffs);
            }
            listffandffs.add(listffs);
        }    
       request.setAttribute("listffandffs", listffandffs);
        request.getRequestDispatcher("danhsachsanbong.jsp").forward(request, response);
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