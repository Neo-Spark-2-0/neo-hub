package com.neospark.neohub.controller.common;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * The type Image retrival servlet.
 */
@WebServlet("/uploads/*")
public class ImageRetrivalServlet extends HttpServlet {
    private static final String BASE_UPLOAD_DIR =
            System.getProperty("user.home") + File.separator + "neohub-uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String pathInfo = request.getPathInfo();


        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String relativePath = pathInfo.substring(1);


        File file = new File(BASE_UPLOAD_DIR, relativePath);


        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }


        try {
            Path uploadRoot = Paths.get(BASE_UPLOAD_DIR).toRealPath();
            Path targetFile = file.toPath().toRealPath();

            if (!targetFile.startsWith(uploadRoot)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = Files.probeContentType(file.toPath());
        if (contentType != null) {
            response.setContentType(contentType);
        }

        response.setContentLengthLong(file.length());

        try (OutputStream out = response.getOutputStream()) {
            Files.copy(file.toPath(), out);
        }
    }
}
