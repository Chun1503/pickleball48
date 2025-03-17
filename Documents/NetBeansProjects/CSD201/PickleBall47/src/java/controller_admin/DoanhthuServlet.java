/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller_admin;

import dao.BillDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import model.Bill;

/**
 *
 * @author Minh Trung
 */
@WebServlet(name = "DoanhthuServlet", urlPatterns = {"/admin/doanhthu"})
public class DoanhthuServlet extends HttpServlet {

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
            out.println("<title>Servlet DoanhthuServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoanhthuServlet at " + request.getContextPath() + "</h1>");
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
    Account user = (Account) session.getAttribute("account");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    BillDAO billDAO = new BillDAO();
    List<Bill> listBill = new ArrayList<>();
    int totalDoanhthu = 0;

    if (user.getRole() == 3) { // Nếu là admin
        listBill = billDAO.getBills();
    } else { // Nếu là staff
        listBill = billDAO.getBillsByIDAccount2(user.getIDAccount());
    }

    for (Bill bill : listBill) {
        if (bill == null) {
            System.out.println("Bill is null");
            continue;
        }

        if (bill.getRegisteredPickleBallField() != null) {
            int status = bill.getRegisteredPickleBallField().getStatus();
            if (status == 2) {
                totalDoanhthu += bill.getRegisteredPickleBallField().getDeposit();
            } else if (status == 1) {
                totalDoanhthu += bill.getTotalPrice();
            }
        }
    }

    Collections.reverse(listBill);
    request.setAttribute("listBill", listBill);
    request.setAttribute("doanhThu", totalDoanhthu);
    request.getRequestDispatcher("doanhthu.jsp").forward(request, response);
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
    Account user = (Account) session.getAttribute("account");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    BillDAO billDAO = new BillDAO();
    List<Bill> listBill = new ArrayList<>();
    int totalDoanhthu = 0;

    // Lấy ngày từ request
    String ngayFrom = request.getParameter("ngayFrom");
    String ngayTo = request.getParameter("ngayTo");

    if (ngayFrom != null && ngayTo != null) {
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        LocalDate dateFrom = LocalDate.parse(ngayFrom, inputFormatter);
        String outputDateFrom = dateFrom.format(outputFormatter);
        LocalDate dateTo = LocalDate.parse(ngayTo, inputFormatter);
        String outputDateTo = dateTo.format(outputFormatter);

        if (user.getRole() == 3) { // Nếu là admin
            listBill = billDAO.getBillsByAdminFromdateTodate(outputDateFrom, outputDateTo);
        } else { // Nếu là staff
            listBill = billDAO.getBillsByIDAccount2FromdateTodate(user.getIDAccount(), outputDateFrom, outputDateTo);
        }
    } else {
        if (user.getRole() == 3) { // Nếu là admin
            listBill = billDAO.getBills();
        } else { // Nếu là staff
            listBill = billDAO.getBillsByIDAccount2(user.getIDAccount());
        }
    }

    for (Bill bill : listBill) {
        if (bill == null) {
            System.out.println("Bill is null");
            continue;
        }

        if (bill.getRegisteredPickleBallField() != null) {
            int status = bill.getRegisteredPickleBallField().getStatus();
            if (status == 2) {
                totalDoanhthu += bill.getRegisteredPickleBallField().getDeposit();
            } else if (status == 1) {
                totalDoanhthu += bill.getTotalPrice();
            }
        }
    }

    Collections.reverse(listBill);
    request.setAttribute("listBill", listBill);
    request.setAttribute("doanhThu", totalDoanhthu);
    request.getRequestDispatcher("doanhthu.jsp").forward(request, response);
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
