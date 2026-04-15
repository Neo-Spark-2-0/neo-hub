<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>LOGIN - NEO-HUB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Login to your NEO-HUB account">
    <meta name="keywords" content="NEO-HUB, Login, User Authentication">
    <meta name="author" content="NEO-HUB Team">
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body class="font-poppins bg-gray-100 min-h-screen flex items-center justify-center">

<div class="w-full max-w-md bg-white rounded-2xl shadow-lg p-8">

    <%-- Logo --%>
    <div class="text-center mb-6">
        <h1 class="text-3xl font-bold text-primary">NEO-HUB</h1>
        <p class="text-gray-500 text-sm mt-1">Login to your account</p>
    </div>

    <%-- Success Messages --%>
    <c:if test="${param.registered eq 'true'}">
        <div class="bg-green-100 text-green-600 text-sm px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-check mr-2"></i>
            Registration successful! Please login.
        </div>
    </c:if>

    <c:if test="${param.logout eq 'true'}">
        <div class="bg-green-100 text-green-600 text-sm px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-check mr-2"></i>
            You have been logged out successfully.
        </div>
    </c:if>

    <%-- Error Message --%>
    <c:if test="${not empty requestScope.error}">
        <div class="bg-red-100 text-red-600 text-sm px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-exclamation mr-2"></i>
            <c:out value="${requestScope.error}"/>
        </div>
    </c:if>

    <%-- Login Form --%>
    <form action="${pageContext.request.contextPath}/login" method="post">

        <%-- Email --%>
        <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-1">
                Email <span class="text-red-500">*</span>
            </label>
            <div class="relative">
                <span class="absolute inset-y-0 left-3 flex items-center text-gray-400">
                    <i class="fa fa-envelope"></i>
                </span>
                <input
                    type="email"
                    name="email"
                    placeholder="john@example.com"
                    value="<c:out value='${param.email}'/>"
                    required
                    class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg text-sm
                           focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                />
            </div>
        </div>

        <%-- Password --%>
        <div class="mb-6">
            <label class="block text-sm font-medium text-gray-700 mb-1">
                Password <span class="text-red-500">*</span>
            </label>
            <div class="relative">
                <span class="absolute inset-y-0 left-3 flex items-center text-gray-400">
                    <i class="fa fa-lock"></i>
                </span>
                <input
                    type="password"
                    name="password"
                    id="password"
                    placeholder="Enter your password"
                    required
                    class="w-full pl-10 pr-10 py-2.5 border border-gray-300 rounded-lg text-sm
                           focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                />
                <span class="absolute inset-y-0 right-3 flex items-center cursor-pointer text-gray-400"
                      onclick="togglePassword()">
                    <i id="eyeIcon" class="fa fa-eye"></i>
                </span>
            </div>
        </div>

        <%-- Submit --%>
        <button
            type="submit"
            class="w-full bg-primary hover:bg-blue-600 text-white font-semibold
                   py-2.5 rounded-lg transition duration-200 text-sm">
            <i class="fa fa-right-to-bracket mr-2"></i> Login
        </button>

    </form>

    <%-- Register Link --%>
    <p class="text-center text-sm text-gray-500 mt-6">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register"
           class="text-primary font-medium hover:underline">
            Register here
        </a>
    </p>

</div>

<script>
    function togglePassword() {
        const field   = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');
        const isPassword = field.type === 'password';
        field.type        = isPassword ? 'text' : 'password';
        eyeIcon.className = isPassword ? 'fa fa-eye-slash' : 'fa fa-eye';
    }
</script>

</body>
</html>