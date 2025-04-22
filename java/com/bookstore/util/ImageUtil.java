package com.bookstore.util;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.http.Part;

public class ImageUtil {

    public String getImageNameFromPart(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "unknown.png";
    }

    public String saveToDisk(Part part, String absoluteUploadDir) {
        File uploadFolder = new File(absoluteUploadDir);
        if (!uploadFolder.exists() && !uploadFolder.mkdirs()) {
            System.err.println("Failed to create upload folder.");
            return null;
        }

        try {
            String originalName = getImageNameFromPart(part);
            String uniqueName = System.currentTimeMillis() + "_" + originalName;
            String fullPath = absoluteUploadDir + File.separator + uniqueName;
            part.write(fullPath);
            return uniqueName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}

