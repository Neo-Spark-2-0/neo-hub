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
<body class="font-poppins bg-secondary min-h-screen flex items-center justify-center">

<div class="w-full max-w-md bg-primary rounded-2xl border border-gray-200 p-8 mx-4">

    <div class="mb-6">
        <h1 class="text-2xl font-semibold text-accent">NEO-HUB</h1>
        <p class="text-gray-400 text-sm mt-1">Sign in to your account</p>
    </div>

    <%-- Success Messages --%>
    <c:if test="${param.registered eq 'true'}">
        <div class="bg-green-50 border border-green-200 text-green-700 text-xs px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-check mr-2"></i>
            Registration successful! Please login.
        </div>
    </c:if>

    <c:if test="${param.logout eq 'true'}">
        <div class="bg-green-50 border border-green-200 text-green-700 text-xs px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-check mr-2"></i>
            You have been logged out successfully.
        </div>
    </c:if>

    <%-- Error Message --%>
    <c:if test="${not empty requestScope.error}">
        <div class="bg-red-50 border border-red-200 text-red-600 text-xs px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-exclamation mr-2"></i>
            <c:out value="${requestScope.error}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post" class="flex flex-col gap-4">

        <%-- Email --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Email address</label>
            <input
                type="email"
                name="email"
                placeholder="john@example.com"
                value="<c:out value='${param.email}'/>"
                required
                class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
            />
        </div>

        <%-- Password --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Password</label>
            <div class="relative">
                <input
                    type="password"
                    name="password"
                    id="password"
                    placeholder="Enter your password"
                    required
                    class="w-full px-3 py-2 pr-10 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
                />
                <span class="absolute inset-y-0 right-3 flex items-center cursor-pointer text-gray-400"
                      onclick="togglePassword()">
                    <i id="eyeIcon" class="fa fa-eye text-xs"></i>
                </span>
            </div>
        </div>

        <%-- Submit --%>
        <button
            type="submit"
            class="w-full bg-gray-900 text-white text-sm font-medium py-2.5 rounded-lg hover:opacity-80 transition mt-2">
            Sign in
        </button>

    </form>

    <div class="w-full h-[0.5px] bg-gray-200 my-5"></div>

    <p class="text-center text-xs text-gray-500">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register"
           class="text-gray-800 font-medium hover:underline">
            Create one →
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
