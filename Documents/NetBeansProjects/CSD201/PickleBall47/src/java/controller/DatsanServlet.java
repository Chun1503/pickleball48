package controller;

import dao.PickleBallFieldScheduleDAO;
import dao.RegisteredPickleBallFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.PickleBallFieldSchedule;
import model.RegisteredPickleBallField;

@WebServlet(name = "DatsanServlet", urlPatterns = {"/datsan"})
public class DatsanServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        // Lấy thông tin người dùng từ session
        Account user = (Account) session.getAttribute("account");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy thông tin từ session
        Integer ffsID = (Integer) session.getAttribute("ffsID");
        String ngay = (String) session.getAttribute("ngay");

        if (ffsID == null || ngay == null) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        String bookerName = request.getParameter("bookerName");
        String phone = request.getParameter("phone");
        String note = request.getParameter("note");

        // Khởi tạo DAO
        RegisteredPickleBallFieldDAO rpbfd = new RegisteredPickleBallFieldDAO();
        PickleBallFieldScheduleDAO pbfsd = new PickleBallFieldScheduleDAO();

        // Định dạng ngày
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        java.sql.Date sqlDate;
        try {
            java.util.Date date = sdf.parse(ngay);
            sqlDate = new java.sql.Date(date.getTime());
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Ngày không hợp lệ!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin lịch sân
        PickleBallFieldSchedule schedule = pbfsd.getPickleBallFieldScheduleByID(ffsID);
        if (schedule == null) {
            request.setAttribute("errorMessage", "Không tìm thấy lịch sân!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Tạo đăng ký sân
        RegisteredPickleBallField rpbf = new RegisteredPickleBallField();
        rpbf.setAccount1(user);
        rpbf.setPickleBallFieldSchedule(schedule);
        rpbf.setDate(sqlDate);
        rpbf.setName(bookerName);
        rpbf.setPhoneNumber(phone);
        rpbf.setDeposit(100000);
        rpbf.setStatus(2);
        rpbf.setNote(note);

        try {
            rpbfd.insertRFF(rpbf);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi đặt sân: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Lấy ID đăng ký sân vừa tạo
        int rpbfID = rpbfd.getRegisteredPickleBallFieldWithLastIndex();
        if (rpbfID <= 0) {
            request.setAttribute("errorMessage", "Không lấy được ID đăng ký sân!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Xóa session không cần thiết
        session.removeAttribute("ffsID");
        session.removeAttribute("ngay");

        // Lưu ID vào session
        session.setAttribute("rpbfID", rpbfID);

        // Chuyển hướng đến trang thanh toán
        response.sendRedirect("vnpay_pay.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet đặt sân";
    }
}
