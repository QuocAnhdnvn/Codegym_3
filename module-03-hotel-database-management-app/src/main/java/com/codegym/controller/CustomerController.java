package com.codegym.controller;

import com.codegym.model.dto.CustomerDto;
import com.codegym.model.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "customerServlet",
            urlPatterns = { "/tables", "/customers", "/customer/detail", "/customer/add",
                            "/customer/edit", "/customer/remove", "/customer/search" })
public class CustomerController extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private CustomerService customerService = null;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "/tables":
            case "/customers":
                HttpSession listSession = req.getSession(false);
                boolean loggedIn = listSession != null && listSession.getAttribute("username") != null;
                if (loggedIn) {
                    req.setAttribute("customers", customerService.findAll());
                } else {
                    req.setAttribute("authError", "Please log in to view customer information.");
                }
                req.getRequestDispatcher("/WEB-INF/view/customer/index.jsp").forward(req, resp);
                break;
            case "/customer/detail":
                int detailId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("customer", customerService.find(detailId));
                req.getRequestDispatcher("/WEB-INF/view/customer/detail.jsp").forward(req, resp);
                break;
            case "/customer/add":
                HttpSession addSession = req.getSession(false);
                boolean addAllowed = addSession != null && Boolean.TRUE.equals(addSession.getAttribute("canEdit"));
                if (addAllowed) {
                    req.getRequestDispatcher("/WEB-INF/view/customer/add.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/customers");
                }
                break;
            case "/customer/edit":
                HttpSession editSession = req.getSession(false);
                boolean editAllowed = editSession != null && Boolean.TRUE.equals(editSession.getAttribute("canEdit"));
                if (editAllowed) {
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("customer", customerService.find(editId));
                    req.getRequestDispatcher("/WEB-INF/view/customer/edit.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/customers");
                }
                break;
            case "/customer/remove":
                HttpSession removeSession = req.getSession(false);
                boolean removeAllowed = removeSession != null && Boolean.TRUE.equals(removeSession.getAttribute("canEdit"));
                if (removeAllowed) {
                    int removeId = Integer.parseInt(req.getParameter("id"));
                    customerService.remove(removeId);
                }
                resp.sendRedirect(req.getContextPath() + "/customers");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        HttpSession session = req.getSession(false);
        boolean canEdit = session != null && Boolean.TRUE.equals(session.getAttribute("canEdit"));

        String name = req.getParameter("name");
        String position = req.getParameter("position");
        String office = req.getParameter("office");
        Integer age = Integer.parseInt(req.getParameter("age"));

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateInString = req.getParameter("startDate");
        Date startDate;
        try {
            startDate = formatter.parse(dateInString);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        Double salary = Double.parseDouble(req.getParameter("salary"));

        switch (action) {
            case "/customer/add":
                if (canEdit) {
                    CustomerDto newCustomer = new CustomerDto(name, position, office, age, startDate, salary);
                    customerService.add(newCustomer);
                }
                resp.sendRedirect(req.getContextPath() + "/customers");
                break;
            case "/customer/edit":
                if (canEdit) {
                    int id = Integer.parseInt(req.getParameter("id"));
                    CustomerDto editingCustomer = customerService.find(id);
                    editingCustomer.setName(name);
                    editingCustomer.setPosition(position);
                    editingCustomer.setOffice(office);
                    editingCustomer.setAge(age);
                    editingCustomer.setStartDate(startDate);
                    editingCustomer.setSalary(salary);
                    customerService.edit(editingCustomer);
                }
                resp.sendRedirect(req.getContextPath() + "/customers");
                break;
            case "/customer/search":
                String searchingName = req.getParameter("searchingName");
                req.setAttribute("customers", customerService.search(searchingName));
                req.getRequestDispatcher("/WEB-INF/view/customer/search.jsp").forward(req, resp);
                break;
        }
    }
}

