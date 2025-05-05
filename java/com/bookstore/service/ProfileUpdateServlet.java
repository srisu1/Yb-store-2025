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

@WebServlet("/updateProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class ProfileUpdateServlet extends HttpServlet {
    private final UserDAO userDao = new UserDAO();
    private final AddressDAO addressDAO = new AddressDAO();
    private final UserAddressPreferenceDAO prefDAO = new UserAddressPreferenceDAO();
    private final ImageUtil imageUtil = new ImageUtil();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/home?showLogin=true");
            return;
        }

        String uploadDir = getServletContext().getRealPath("/resources/uploads");

        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false);
            boolean shouldCommit = false;

            // 1. Handle profile image
            Part imgPart = request.getPart("profileImage");
            if (imgPart != null && imgPart.getSize() > 0) {
                // Saving the image to the server
                String savedFileName = imageUtil.saveToDisk(imgPart, uploadDir);
                String newUrl = request.getContextPath() + "/resources/uploads/" + Paths.get(savedFileName).getFileName();
                
                // Update the image URL in the database
                if (!userDao.updateProfilePictureUrl(user.getUserId(), newUrl, conn)) {
                    throw new RuntimeException("Failed to update profile picture URL");
                }
                user.setProfilePictureUrl(newUrl); // Update the user object with the new image URL
                shouldCommit = true;
            }

            // 2. Update user info safely
            String fullName = request.getParameter("fullName");
            if (fullName != null) user.setFullName(fullName);

            String phone = request.getParameter("phone");
            if (phone != null) user.setPhoneNumber(phone);

            String lang = request.getParameter("languagePreference");
            if (lang != null) user.setLanguagePreference(lang);

            if (!userDao.updateUser(user, conn)) {
                throw new RuntimeException("Failed to update user info");
            }
            shouldCommit = true;

            // 3. Conditionally insert address
            String addrLine = request.getParameter("addressLine");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String postalCode = request.getParameter("postalCode");
            String country = request.getParameter("country");

            boolean addressProvided =
                    (addrLine != null && !addrLine.trim().isEmpty()) ||
                    (city != null && !city.trim().isEmpty()) ||
                    (state != null && !state.trim().isEmpty()) ||
                    (postalCode != null && !postalCode.trim().isEmpty()) ||
                    (country != null && !country.trim().isEmpty());

            if (addressProvided) {
                Address addr = new Address(
                        0, user.getUserId(), addrLine,
                        city, state, postalCode, country, true
                );
                if (!addressDAO.saveAddress(addr, conn)) {
                    throw new RuntimeException("Failed to save new address");
                }

                UserAddressPreference pref = new UserAddressPreference(
                        user.getUserId(), addr.getAddressId(), addr.getAddressId()
                );
                prefDAO.updatePreferences(pref, conn);
                shouldCommit = true;
            }

            // 4. Commit if anything changed
            if (shouldCommit) conn.commit();

            // 5. Refresh user session
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
