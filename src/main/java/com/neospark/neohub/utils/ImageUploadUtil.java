package com.neospark.neohub.utils;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.http.Part;


public class ImageUploadUtil {


    private static final String BASE_UPLOAD_DIR =
            System.getProperty("user.home") + File.separator + "neohub-uploads";

    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp"};

    public static String uploadImage(Part part, String folder) throws IOException {

        if (part == null || part.getSize() == 0) {
            return null;
        }

        String originalName = getSubmittedFileName(part);
        if (originalName == null || originalName.isEmpty()) {
            return null;
        }

        String extension = getExtension(originalName).toLowerCase();
        if (!isAllowedExtension(extension)) {
            System.out.println("ImageUploadUtil: rejected extension " + extension);
            return null;
        }

        // Create upload directory if it doesn't exist
        String uploadPath = BASE_UPLOAD_DIR + File.separator + folder;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String uniqueName = UUID.randomUUID().toString() + extension;

        part.write(uploadPath + File.separator + uniqueName);

        return folder + "/" + uniqueName;
    }

    public static void deleteImage(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return;
        }

        if (imagePath.startsWith("static/") || imagePath.startsWith("default")) {
            return;
        }
        File file = new File(BASE_UPLOAD_DIR + File.separator + imagePath.replace("/", File.separator));
        if (file.exists()) {
            file.delete();
        }
    }

    private static boolean isAllowedExtension(String extension) {
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (allowed.equals(extension)) return true;
        }
        return false;
    }

    private static String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private static String getExtension(String filename) {
        int dot = filename.lastIndexOf('.');
        return (dot >= 0) ? filename.substring(dot) : ".jpg";
    }
}