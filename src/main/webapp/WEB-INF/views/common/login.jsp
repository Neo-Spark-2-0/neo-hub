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
<body class="font-poppins bg-secondary min-h-[100vh] flex items-center justify-center">

<div class="w-full max-w-md bg-primary rounded-2xl border border-gray-200 p-8 mx-4">

    <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-800">Welcome back!</h2>
        <p class="text-gray-400 text-sm mt-1">Sign in to your account</p>
    </div>


    <form action="${pageContext.request.contextPath}/login" method="post" class="flex flex-col gap-4">
 <!-- email input  -->
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Email address</label>
            <input
                type="email"
                name="email"
                placeholder="neohub@neospark.com"
                value="<c:out value='${param.email}'/>"
                required
                class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg transition focus:ring-2 focus:ring-gray-300 focus:outline-none"
            />
        </div>

        <%-- password input --%>
        <div>
            <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Password</label>
                <input
                    type="password"
                    name="password"
                    id="password"
                    placeholder="Enter your password"
                    required
                    class="w-full px-3 py-2 pr-10 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-300 transition"
                />
        </div>

        <%-- button which type is submit so form auto submits on clicking button --%>
        <button
            type="submit"
            class="w-full bg-accent text-white text-sm font-medium py-2.5 rounded-lg hover:opacity-80 transition mt-2">
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
    // error from login form or servlet
    <c:if test="${not empty error}">
        showToast("<c:out value='${error}' />", "error");
    </c:if>

    // flash message from servlet
    <c:if test="${not empty sessionScope.registerSuccessFlashMessage}">
        showToast("${sessionScope.registerSuccessFlashMessage}", "success");
        <%
            session.removeAttribute("registerSuccessFlashMessage");
        %>
    </c:if>
</script>
</body>
</html>
