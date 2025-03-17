/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller_admin;

import dao.PickleBallFieldDAO;
import dao.PickleBallFieldScheduleDAO;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.PickleBallField;
import model.PickleBallFieldSchedule;

/**
 *
 * @author Minh Trung
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "UpdatesanbongServlet", urlPatterns = {"/admin/updatesanbong"})
public class UpdatesanbongServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdatesanbongServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatesanbongServlet at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("pickleBallFieldId");
        int id = Integer.parseInt(id_raw);
        PickleBallFieldDAO ffD = new PickleBallFieldDAO();
        PickleBallField ff = ffD.getPickleBallFieldByID(id);
        request.setAttribute("pickleBallField", ff);
        request.getRequestDispatcher("updatesanbong.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        int idPickleBallField = Integer.parseInt(request.getParameter("fieldID"));
        String pickleBallName = request.getParameter("fieldName");
        int typeofPickleBall = Integer.parseInt(request.getParameter("fieldType"));
        int price = Integer.parseInt(request.getParameter("fieldPrice"));
        Part file = request.getPart("fieldImage");
        String imageFileName = file.getSubmittedFileName();
        String uploadPath = "D:/1_SWD392/SWD192/FBK74/web/img_nhat/" + imageFileName;
        try {
            FileOutputStream fos = new FileOutputStream(uploadPath);
            InputStream is = file.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();

           PickleBallFieldDAO ffD = new PickleBallFieldDAO();
            if (data != null) {
                PickleBallField ff = new PickleBallField(idPickleBallField, pickleBallName, typeofPickleBall, price, imageFileName, 0);

                ffD.updatePickleBallField(ff);
            } else {
                PickleBallField ff = new PickleBallField(idPickleBallField, pickleBallName, typeofPickleBall, price, ffD.getPickleBallFieldByID(idPickleBallField).getImage(), 0);
                ffD.updatePickleBallField(ff);
            }
        } catch (Exception e) {
        }

        //Xử lý chèn lịch sân
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        String[] selectedTimes = request.getParameterValues("selectedTimes");
        if (selectedTimes != null) {
            List<String> selectedTimesList = new ArrayList<>(Arrays.asList(selectedTimes));
            PickleBallFieldScheduleDAO ffsD = new PickleBallFieldScheduleDAO();
            ffsD.changeStatusWithIDPickleBallField(1, idPickleBallField);
            //ListFFS1 chứa các giờ trong db status = 1
            List<PickleBallFieldSchedule> listFFS1 = ffsD.getPickleBallFieldScheduleByIDPickleBallFieldWithStatus1(idPickleBallField);
            //xử lý xóa các đối tượng trùng time đã chọn
            //Xử lý lấy các time không còn được chọn và xóa chúng
            Iterator<String> timeIterator = selectedTimesList.iterator();
            while (timeIterator.hasNext()) {
                String timeSelected = timeIterator.next();
                String[] timesplit = timeSelected.split("-");
                timesplit[0] = timesplit[0].trim();
                Date parsedTime;
                try {
                    parsedTime = timeFormat.parse(timesplit[0]);
                    Time selectedTime = new Time(parsedTime.getTime());
                    for (PickleBallFieldSchedule pickleBallFieldSchedule : listFFS1) {
                        if (selectedTime.equals(pickleBallFieldSchedule.getStartTime())) {
                            timeIterator.remove();
                            ffsD.changeStatusWithIDPickleBallFieldSchedule(0, pickleBallFieldSchedule.getIDPickleBallFieldSchedule());
                        }
                    }
                } catch (ParseException ex) {
                    Logger.getLogger(UpdatesanbongServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            for (String string : selectedTimesList) {
                String[] timesplit = string.split("-");
                timesplit[0] = timesplit[0].trim();
                timesplit[1] = timesplit[1].trim();
                ffsD.insertPickleBallFieldSchedule(timesplit[0], timesplit[1], idPickleBallField, 0);
            }
        }
        response.sendRedirect("danhsachsanbong");
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
