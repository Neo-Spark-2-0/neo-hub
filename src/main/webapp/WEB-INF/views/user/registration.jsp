<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - NEO-HUB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Create your NEO-HUB account">
    <meta name="keywords" content="NEO-HUB, registration, sign up, create account">
    <meta name="author" content="NEO-HUB Team">
    <link rel="icon" href="${pageContext.request.contextPath}/static/images/favicon.png" type="image/x-icon">
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body class="font-poppins bg-secondary min-h-screen flex items-center justify-center">


<div class="w-full max-w-md bg-primary rounded-2xl border border-gray-200 p-8 mx-4 my-8">

    <div class="mb-6">
        <h1 class="text-2xl font-semibold text-accent">NEO-HUB</h1>
        <p class="text-gray-400 text-sm mt-1">Create your account</p>
    </div>

    <form action="${pageContext.request.contextPath}/register" method="post" class="flex flex-col gap-4">

        <%-- Name --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Full name</label>
            <input
                type="text"
                name="fullName"
                placeholder="Ram Shrestha"
                value="<c:out value='${param.fullName}'/>"
                required
                class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
            />
        </div>

        <%-- Email --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Email address</label>
            <input
                type="email"
                name="email"
                placeholder="ram@neohub.com"
                value="<c:out value='${param.email}'/>"
                required
                class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
            />
        </div>

        <%-- Phone  number --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Phone</label>
            <input
                type="text"
                name="phone"
                placeholder="98XXXXXXXX"
                value="<c:out value='${param.phone}'/>"
                required
                class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
            />
        </div>

        <%-- Password --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Password</label>
                <input
                    type="password"
                    name="password"
                    id="password"
                    placeholder="Eg: P@ssw0rd!"
                    required
                    class="w-full px-3 py-2 pr-10 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
                />
        </div>

        <%-- Confirm Password --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Confirm password</label>
                <input
                    type="password"
                    name="confirmPassword"
                    id="confirmPassword"
                    placeholder="Repeat your password"
                    required
                    class="w-full px-3 py-2 pr-10 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
                />
            <p id="matchWarning" class="text-red-500 text-xs mt-1 hidden">
                Passwords do not match.
            </p>
        </div>

        <%-- Submit button --%>
        <button
            type="submit"
            class="w-full bg-gray-900 text-white text-sm font-medium py-3 rounded-lg hover:opacity-80 transition mt-2">
            Create account
        </button>

    </form>

    <div class="w-full h-[0.5px] bg-gray-200 my-5"></div>

    <p class="text-center text-xs text-gray-500">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login"
           class="text-gray-800 font-medium hover:underline">
            Sign in →
        </a>
    </p>

</div>

<script>
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const warning = document.getElementById('matchWarning');
    confirmPasswordInput.addEventListener('input', ()=> {
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;
        warning.classList.toggle('hidden', password === confirmPassword);
    });



    // errpr
    <c:if test="${not empty error}">
        showToast("<c:out value='${error}' />", "error");
    </c:if>

    // success
    <c:if test="${not empty success}">
        showToast("<c:out value='${success}' />", "success");
    </c:if>


</script>

</body>
</html>
