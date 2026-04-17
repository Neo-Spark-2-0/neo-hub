<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>NEO-HUB - Verify Email</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="NEO-HUB - Verify Email">
    <meta name="keywords" content="NEO-HUB, Verify Email">
    <meta name="author" content="NEO-HUB Team">
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body class="font-poppins bg-secondary min-h-screen flex items-center justify-center">

<div class="w-full max-w-md bg-primary rounded-2xl border border-gray-200 p-8 mx-4">

    <div class="mb-6">
        <h1 class="text-2xl font-semibold text-accent">NEO-HUB</h1>
        <p class="text-gray-400 text-sm mt-1">Email verification</p>
    </div>

    <div class="w-full h-[0.5px] bg-gray-200 mb-6"></div>

    <c:choose>
        <c:when test="${verifyStatus eq 'success'}">
            <div class="bg-green-50 border border-green-200 rounded-xl p-5 flex flex-col gap-3">
                <div class="flex items-center gap-2">
                    <i class="fa fa-circle-check text-green-600 text-sm"></i>
                    <p class="text-sm font-medium text-green-700">Verification successful</p>
                </div>
                <p class="text-xs text-green-600">${message}</p>
            </div>
            <a href="${pageContext.request.contextPath}/login"
               class="mt-5 w-full block text-center bg-gray-900 text-white text-sm font-medium py-2.5 rounded-lg hover:opacity-80 transition">
                Go to login
            </a>
        </c:when>
        <c:otherwise>
            <div class="bg-red-50 border border-red-200 rounded-xl p-5 flex flex-col gap-3">
                <div class="flex items-center gap-2">
                    <i class="fa fa-circle-exclamation text-red-500 text-sm"></i>
                    <p class="text-sm font-medium text-red-600">Verification failed</p>
                </div>
                <p class="text-xs text-red-500">${message}</p>
            </div>
            <a href="${pageContext.request.contextPath}/register"
               class="mt-5 w-full block text-center bg-gray-900 text-white text-sm font-medium py-2.5 rounded-lg hover:opacity-80 transition">
                Back to register
            </a>
        </c:otherwise>
    </c:choose>

    <div class="w-full h-[0.5px] bg-gray-200 my-5"></div>

    <p class="text-center text-xs text-gray-500">
        Need help?
        <a href="${pageContext.request.contextPath}/login"
           class="text-gray-800 font-medium hover:underline">
            Sign in →
        </a>
    </p>

</div>

</body>
</html>
