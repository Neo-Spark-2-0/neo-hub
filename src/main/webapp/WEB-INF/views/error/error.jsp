<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
//    getting status code
    Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
    if (statusCode == null) {
        statusCode = 500;
    }

    Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");
    String errorMessage = "";
    if (throwable != null) {
        errorMessage = throwable.getMessage();
    }

    request.setAttribute("errorCode", statusCode);
    request.setAttribute("errorMessage", errorMessage);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="${errorCode} - Error" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary min-h-screen flex flex-col">

    <jsp:include page="/WEB-INF/templates/user/header.jsp" />

    <main class="flex-1 flex items-center justify-center px-4 py-16">
        <div class="text-center max-w-md mx-auto">
            
            <!-- error icon -->
            <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <i class="fa-solid fa-circle-exclamation text-red-600 text-5xl"></i>
            </div>

            <h1 class="text-7xl font-bold text-accent mb-3">${errorCode}</h1>
            
<%--            showing errror message based on code --%>
            <p class="text-gray-600 mb-6">
                <c:choose>
                    <c:when test="${errorCode == 400}">Bad Request</c:when>
                    <c:when test="${errorCode == 401}">Unauthorized - Please login</c:when>
                    <c:when test="${errorCode == 403}">Forbidden - Access Denied</c:when>
                    <c:when test="${errorCode == 404}">Page Not Found</c:when>
                    <c:when test="${errorCode == 500}">Internal Server Error</c:when>
                    <c:when test="${errorCode == 502}">Bad Gateway</c:when>
                    <c:when test="${errorCode == 503}">Service Unavailable</c:when>
                    <c:otherwise>Something went wrong</c:otherwise>
                </c:choose>
            </p>
            
            <!-- message -->
            <p class="text-sm text-gray-400 mb-8">
                <c:choose>
                    <c:when test="${errorCode == 401}">Please sign in to continue.</c:when>
                    <c:when test="${errorCode == 404}">The page you're looking for doesn't exist.</c:when>
                    <c:when test="${errorCode == 500}">An unexpected error occurred. Please try again later.</c:when>
                    <c:otherwise>Sorry, something went wrong. Please try again.</c:otherwise>
                </c:choose>
            </p>
            
<%-- buttons --%>
            <div class="flex flex-col sm:flex-row gap-3 justify-center">
                <button onclick="history.back()" class="bg-accent text-white px-6 py-2.5 rounded-xl hover:opacity-90 transition">
                    <i class="fa-solid fa-arrow-left mr-2"></i> Go Back
                </button>
                <a href="${pageContext.request.contextPath}/home" 
                class="border border-gray-300 text-gray-600 px-6 py-2.5 rounded-xl hover:bg-gray-50 transition">
                    <i class="fa-solid fa-house mr-2"></i> Home
                </a>
            </div>
            
            <!-- error message -->
            <c:if test="${not empty errorMessage}">
                <div class="mt-8 p-4 bg-red-50 border border-red-200 rounded-xl text-left">
                    <p class="text-xs text-red-600 font-mono">${errorMessage}</p>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>