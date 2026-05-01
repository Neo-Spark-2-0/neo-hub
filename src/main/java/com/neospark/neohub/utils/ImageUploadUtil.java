package com.neospark.neohub.utils;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.http.Part;


public class ImageUploadUtil {
    
    private static final String BASE_UPLOAD_DIR = System.getProperty("user.home") + File.separator + "neohub-uploads";

    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp"};

    public static String uploadImage(Part part, String folder) throws IOException {

        if (part == null || part.getSize() == 0) {
            return null;
        }

        String fileName = part.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        String extension = getExtension(fileName);
        if (!isAllowedExtension(extension)) {
            System.out.println("You cannot upload files with the extension " + extension);
            return null;
        }

        String uploadPath = BASE_UPLOAD_DIR + File.separator + folder;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String uniqueName = UUID.randomUUID().toString() + extension;

        try {
            part.write(uploadPath + File.separator + uniqueName);
            return folder + "/" + uniqueName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void deleteImage(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return;
        }
        if (imagePath.startsWith("static/")) {
            return;
        }
        File file = new File(BASE_UPLOAD_DIR + File.separator + imagePath.replace("/", File.separator));
        if (file.exists()) {
            file.delete();
        }
    }

    private static boolean isAllowedExtension(String extension) {
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (allowed.equals(extension)){
                return true;
            }
        }
        return false;
    }
    private static String getExtension(String filename) {
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex == -1) {
            return "";
        }
        return filename.substring(dotIndex).toLowerCase();
    }
}