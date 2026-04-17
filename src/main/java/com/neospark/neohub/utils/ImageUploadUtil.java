package com.neospark.neohub.utils;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class ImageUploadUtil {
    // private static final long   MAX_SIZE   = 2 * 1024 * 1024; // 2 MB
    // private static final String UPLOAD_DIR = "uploads/profiles";

    // public static String uploadProfileImage(Part filePart, String appRealPath) throws IOException {
    //     if (filePart == null || filePart.getSize() == 0) return null;

    //     if (filePart.getSize() > MAX_SIZE) {
    //         throw new IOException("File size exceeds 2MB limit.");
    //     }

    //     String contentType = filePart.getContentType();
    //     if (!contentType.startsWith("image/")) {
    //         throw new IOException("Only image files are allowed.");
    //     }

    //     String originalName = filePart.getSubmittedFileName();
    //     String extension    = originalName.substring(originalName.lastIndexOf('.'));
    //     String fileName     = UUID.randomUUID() + extension;

    //     File uploadDir = new File(appRealPath + File.separator + UPLOAD_DIR);
    //     if (!uploadDir.exists()) uploadDir.mkdirs();

    //     filePart.write(uploadDir.getAbsolutePath() + File.separator + fileName);

    //     return UPLOAD_DIR + "/" + fileName; // relative path stored in DB
    // }
}