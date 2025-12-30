package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class UpdateAddressServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String address = request.getParameter("address");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String postalCode = request.getParameter("postal_code");

        int userId = ((com.equrban.models.User) session.getAttribute("user")).getUser_id();

        userDAO.updateAddress(userId, address, province, city, district, postalCode);


        // Update session user
        com.equrban.models.User user = (com.equrban.models.User) session.getAttribute("user");
        user.setAddress(address);
        user.setProvince(province);
        user.setCity(city);
        user.setDistrict(district);
        user.setPostalCode(postalCode);
        session.setAttribute("user", user);

        response.sendRedirect(request.getContextPath() + "/user/dashboard");
    }
}
