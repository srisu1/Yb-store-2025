package com.bookstore.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.http.Part;
import java.io.File;


/**
 * Utility for saving uploaded images to disk under webapp.
 */
public class ImageUtil {

    /**
     * Get the original filename of the uploaded part.
     * Uses Part.getSubmittedFileName() for simplicity.
     */
    public String getImageNameFromPart(Part part) {
        String submitted = part.getSubmittedFileName();
        if (submitted == null || submitted.isBlank()) {
            return "unknown.png";
        }
        // Strip any path info (IE might include it)
        return Paths.get(submitted).getFileName().toString();
    }

    /**
     * Saves the uploaded Part to the given directory on disk.
     *
     * @param part      the multipart Part for the uploaded file
     * @param uploadDir the absolute disk path to /webapp/resources/uploads folder
     * @return the unique filename written 
     * @throws IOException if writing fails
     */
    public String saveToDisk(Part part, String uploadDir) throws IOException {
        // Ensure the upload directory exists
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists() && !uploadFolder.mkdirs()) {
            throw new IOException("Could not create upload directory: " + uploadDir);
        }

        // Build a unique filename: timestamp + original name
        String origName   = getImageNameFromPart(part);
        String uniqueName = System.currentTimeMillis() + "_" + origName;

        // Write the file to that location
        part.write(new File(uploadFolder, uniqueName).getAbsolutePath());

        return uniqueName;
    }
}

