<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - NEO-HUB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Create your NEO-HUB account to connect with the latest tech news, projects, and community. Join us today!">
    <meta name="keywords" content="NEO-HUB, registration, sign up, create account, tech community">
    <meta name="author" content="NEO-HUB Team">
    <link rel="icon" href="${pageContext.request.contextPath}/static/images/favicon.png" type="image/x-icon">
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body class="font-poppins bg-gray-100 min-h-screen flex items-center justify-center">

<div class="w-full max-w-md bg-white rounded-2xl shadow-lg p-8 my-8">

    <div class="text-center mb-6">
        <h1 class="text-3xl font-bold text-primary">NEO-HUB</h1>
        <p class="text-gray-500 text-sm mt-1">Create your account</p>
    </div>

    <%-- Error Message --%>
    <c:if test="${not empty requestScope.error}">
        <div class="bg-red-100 text-red-600 text-sm px-4 py-3 rounded-lg mb-4">
            <i class="fa fa-circle-exclamation mr-2"></i>
            <c:out value="${requestScope.error}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">

        <div class="mb-4">
            <label class="text-sm font-medium text-gray-700 mb-1">
                Full Name
            </label>
            <div class="relative">
                <span class="absolute inset-y-0 left-3 flex items-center text-gray-400">
                    <i class="fa fa-user"></i>
                </span>
                <input
                    type="text"
                    name="fullName"
                    placeholder="John Doe"
                    value="<c:out value='${param.fullName}'/>"
                    required
                    class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg text-sm
                           focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                />
            </div>
        </div>

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

        <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-1">
                Phone <span class="text-red-500">*</span>
            </label>
            <div class="relative">
                <span class="absolute inset-y-0 left-3 flex items-center text-gray-400">
                    <i class="fa fa-phone"></i>
                </span>
                <input
                    type="text"
                    name="phone"
                    placeholder="98XXXXXXXX"
                    value="<c:out value='${param.phone}'/>"
                    required
                    class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg text-sm
                           focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                />
            </div>
        </div>

        <div class="mb-4">
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
                    placeholder="Min. 6 characters"
                    required
                    class="w-full pl-10 pr-10 py-2.5 border border-gray-300 rounded-lg text-sm
                           focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                />
                <span class="absolute inset-y-0 right-3 flex items-center cursor-pointer text-gray-400"
                      onclick="togglePassword('password', this)">
                    <i class="fa fa-eye"></i>
                </span>
            </div>
        </div>

        <div class="mb-6">
            <label class="block text-sm font-medium text-gray-700 mb-1">
                Confirm Password <span class="text-red-500">*</span>
            </label>
            <div class="relative">
                <span class="absolute inset-y-0 left-3 flex items-center text-gray-400">
                    <i class="fa fa-lock"></i>
                </span>
                <input
                    type="password"
                    name="confirmPassword"
                    id="confirmPassword"
                    placeholder="Repeat your password"
                    required
                    class="w-full pl-10 pr-10 py-2.5 border border-gray-300 rounded-lg text-sm
                           focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                />
                <span class="absolute inset-y-0 right-3 flex items-center cursor-pointer text-gray-400"
                      onclick="togglePassword('confirmPassword', this)">
                    <i class="fa fa-eye"></i>
                </span>
            </div>
            <p id="matchWarning" class="text-red-500 text-xs mt-1 hidden">
                Passwords do not match.
            </p>
        </div>

        <button
            type="submit"
            class="w-full bg-primary hover:bg-blue-600 text-white font-semibold
                   py-2.5 rounded-lg transition duration-200 text-sm">
            <i class="fa fa-user-plus mr-2"></i> Create Account
        </button>

    </form>

    <p class="text-center text-sm text-gray-500 mt-6">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login"
           class="text-primary font-medium hover:underline">
            Login here
        </a>
    </p>

</div>

<script>
    function togglePassword(fieldId, icon) {
        const field = document.getElementById(fieldId);
        const isPassword = field.type === 'password';
        field.type = isPassword ? 'text' : 'password';
        icon.querySelector('i').className = isPassword ? 'fa fa-eye-slash' : 'fa fa-eye';
    }

    document.getElementById('confirmPassword').addEventListener('input', function () {
        const password        = document.getElementById('password').value;
        const confirmPassword = this.value;
        const warning         = document.getElementById('matchWarning');
        warning.classList.toggle('hidden', password === confirmPassword);
    });
</script>

</body>
</html>