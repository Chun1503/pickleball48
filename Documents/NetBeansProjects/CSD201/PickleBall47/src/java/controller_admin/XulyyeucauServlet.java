/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller_admin;

import com.google.gson.Gson;
import dao.BillDAO;
import dao.RegisteredPickleBallFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "XulyyeucauServlet", urlPatterns = {"/admin/xulyyeucau"})
public class XulyyeucauServlet extends HttpServlet {

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
            out.println("<title>Servlet XulyyeucauServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet XulyyeucauServlet at " + request.getContextPath() + "</h1>");
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
        Gson json = new Gson();       
        BillDAO billDAO = new BillDAO();
        RegisteredPickleBallFieldDAO rffDAO = new RegisteredPickleBallFieldDAO();
        String idBill_raw = request.getParameter("idBill");
        int idBill = Integer.parseInt(idBill_raw);
        int status = Integer.parseInt(request.getParameter("status"));
        String requestStatus = request.getParameter("requestStatus");
        if(requestStatus.equals("duyet")){
            if(status==5) {
                RegisteredPickleBallField rff = billDAO.getBillByID(idBill).getRegisteredPickleBallField();
                String test = json.toJson(rff);
                out.print(test);
            }
            else{
                String test = json.toJson("Xác nhận đơn duyệt");
                out.print(test);
            }
        }else{
            if(status==5){
                RegisteredPickleBallField rff = billDAO.getBillByID(idBill).getRegisteredPickleBallField();
                String test = json.toJson(rff);
                out.print(test);
            } else{
                String test = json.toJson("Từ chối đơn duyệt");
                out.print(test);
            }
        }
        out.flush();
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson json = new Gson();       
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("account");
        String idBill_raw = request.getParameter("idBill");
        String status_raw = request.getParameter("status");
        int idBill = Integer.parseInt(idBill_raw);
        int status = Integer.parseInt(status_raw);
        BillDAO billD = new BillDAO();
        RegisteredPickleBallFieldDAO rFFD = new RegisteredPickleBallFieldDAO();
        RegisteredPickleBallField rFF = billD.getBillByID(idBill).getRegisteredPickleBallField();
        double price = rFF.getPickleBallFieldSchedule().getPickleBallField().getPrice();
         billD.updateTotalPrice(idBill, price);
        int idrFF = rFF.getIDRegisteredPickleBallField();
        rFFD.changeStatusWithIDRegisteredPickleBallField(status, idrFF);
        billD.updateIDAccount2(idBill,user.getIDAccount());
        String test = json.toJson("thanh cong");
        out.print(test);
        out.flush();
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