package com.bookstore.filter;

import com.bookstore.dao.UserDAO;
import com.bookstore.util.CookiesUtil;
import com.bookstore.util.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest rq, ServletResponse rs, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) rq;
        HttpServletResponse res = (HttpServletResponse) rs;
        String uri = req.getRequestURI();
        String context = req.getContextPath();

        // 0) Try remember‑me cookie
        CookiesUtil.refreshSessionFromCookie(req, new UserDAO());

        // 1) Static assets
        if (uri.startsWith(context + "/resources/") 
                || uri.endsWith(".css") 
                || uri.endsWith(".js") 
                || uri.endsWith(".png") 
                || uri.endsWith(".jpg")) {
            chain.doFilter(rq, rs);
            return;
        }

        // 2) PUBLIC: login, register, home, userprofile
        if (uri.endsWith("/login")
                || uri.endsWith("/register")
                || uri.endsWith("/")       // context root
                || uri.endsWith("/home")
                || uri.endsWith("/userprofile")
        ) {
            chain.doFilter(rq, rs);
            return;
        }

        // 3) Other public paths (about, contact, bookdetails, catalogue)
        if (uri.endsWith("/about")     
                || uri.endsWith("/contact")  
                || uri.endsWith("/bookdetails") // Allow public access to book details
                || uri.endsWith("/catalogue")) {
            chain.doFilter(rq, rs);
            return;
        }

        // 4) All others require login
        if (!SessionUtil.isUserLoggedIn(req)) {
            res.sendRedirect(context + "/?showLogin=true");
            return;
        }

        // 5) Role‑based: only admin → /admin/*
        boolean isAdmin = SessionUtil.isUserAdmin(req);
        if (uri.startsWith(context + "/admin")) {
            if (isAdmin) {
                chain.doFilter(rq, rs);
            } else {
                res.sendRedirect(context + "/home");
            }
            return;
        }

        // 6) Everything else (cart, checkout, etc.)
        chain.doFilter(rq, rs);
    }
    // init() + destroy() no‑ops…
}