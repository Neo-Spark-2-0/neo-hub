<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>NEO-HUB - Verify Email</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="NEO-HUB - Verify Email">
    <meta name="keywords" content="NEO-HUB, Verify Email">
    <meta name="author" content="NEO-HUB Team">
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body>
    <div class="verify-container">
    <h2>Email Verification</h2>

    <c:choose>
        <c:when test="${verifyStatus eq 'success'}">
            <div class="alert alert-success">
                <p>${message}</p>
                <a href="${pageContext.request.contextPath}/login">Go to Login</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-error">
                <p>${message}</p>
                <a href="${pageContext.request.contextPath}/register">Back to Register</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
