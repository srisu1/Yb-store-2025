package com.bookstore.service;

import com.bookstore.config.DbConfig;
import com.bookstore.dao.AddressDAO;
import com.bookstore.dao.UserAddressPreferenceDAO;
import com.bookstore.dao.UserDAO;
import com.bookstore.model.Address;
import com.bookstore.model.User;
import com.bookstore.model.UserAddressPreference;
import com.bookstore.util.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.io.File;


@WebServlet("/updateProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize       = 1024 * 1024 * 5,  // 5MB
    maxRequestSize    = 1024 * 1024 * 10  // 10MB
)
public class ProfileUpdateServlet extends HttpServlet {
    private final UserDAO userDao       = new UserDAO();
    private final AddressDAO addressDAO = new AddressDAO();
    private final UserAddressPreferenceDAO prefDAO = new UserAddressPreferenceDAO();
    private final ImageUtil imageUtil   = new ImageUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/home?showLogin=true");
            return;
        }

        // Compute where on disk we'll store profile images
        String uploadDir = getServletContext().getRealPath("/resources/uploads");

        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false);
            
            boolean shouldCommit = false;
            // 1. Handle profile picture
            Part imgPart = request.getPart("profileImage");
            if (imgPart != null && imgPart.getSize() > 0) {
                String savedFileName = imageUtil.saveToDisk(imgPart, uploadDir);
                String newUrl = request.getContextPath() + "/resources/uploads/" + Paths.get(savedFileName).getFileName().toString();
                boolean picOk = userDao.updateProfilePictureUrl(user.getUserId(), newUrl, conn);
                if (!picOk) {
                    throw new RuntimeException("Failed to update profile picture URL");
                }
                user.setProfilePictureUrl(newUrl); // Update in-memory user
                shouldCommit = true;
            }

            // 2. Always update user info
            user.setFullName(request.getParameter("fullName"));
            user.setPhoneNumber(request.getParameter("phone"));
            user.setLanguagePreference(request.getParameter("languagePreference"));
            boolean infoOk = userDao.updateUser(user, conn);
            if (!infoOk) {
                throw new RuntimeException("Failed to update user info");
            }
            shouldCommit = true;

            // 3. Optionally insert address if filled
            String addrLine = request.getParameter("addressLine");
            if (addrLine != null && !addrLine.trim().isEmpty()) {
                Address addr = new Address(
                    0, user.getUserId(), addrLine,
                    request.getParameter("city"),
                    request.getParameter("state"),
                    request.getParameter("postalCode"),
                    request.getParameter("country"),
                    true
                );
                boolean saved = addressDAO.saveAddress(addr, conn);
                if (!saved) throw new RuntimeException("Failed to save new address");

                UserAddressPreference pref = new UserAddressPreference(
                    user.getUserId(), addr.getAddressId(), addr.getAddressId()
                );
                prefDAO.updatePreferences(pref, conn);
                shouldCommit = true;
            }

            //  4. COMMIT everything
            if (shouldCommit) conn.commit();

            //  5. Refresh session user always
            try (Connection fresh = DbConfig.getDbConnection()) {
                User updated = userDao.getUserByEmail(user.getEmail(), fresh);
                session.setAttribute("user", updated);
            }

            response.sendRedirect(request.getContextPath() + "/redirectToUserProfile");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Profile update failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/UserProfile.jsp")
                   .forward(request, response);
        }
}
}