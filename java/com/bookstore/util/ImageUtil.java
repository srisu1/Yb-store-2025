package com.bookstore.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import jakarta.servlet.http.Part;

public class ImageUtil {

    // Saving image to disk and returning the unique file name 
    public static String saveToDisk(Part part, String uploadPath) throws IOException {
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

        // Ensuring the upload directory exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (created) {
                System.out.println("Uploads directory created: " + uploadPath);
            } else {
                System.out.println("Failed to create uploads directory.");
            }
        }

        // Debugging: print upload path and file name
        System.out.println("Saving file to: " + Paths.get(uploadPath, uniqueFileName).toString());

        // Validating file extension (only allow images)
        if (!isValidImage(fileName)) {
            throw new IOException("Invalid file type. Only images are allowed.");
        }

        // Save the file to the disk
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, Paths.get(uploadPath, uniqueFileName), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File saved with name: " + uniqueFileName);
        } catch (IOException e) {
            System.err.println("Error while saving the file: " + e.getMessage());
            throw e;
        }

        // Returning the relative path (Note: No '/resources/uploads/' here)
        return uniqueFileName; // This will return only the file name
    }

    // Check if the file has a valid image extension (e.g., .jpg, .jpeg, .png, .gif)
    private static boolean isValidImage(String fileName) {
        String[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
        return Arrays.asList(allowedExtensions).contains(getFileExtension(fileName));
    }

    // Helper method to get the file extension
    private static String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex > 0) {
            return fileName.substring(dotIndex).toLowerCase();
        }
        return "";
    }
}
