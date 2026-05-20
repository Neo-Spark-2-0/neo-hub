<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="Order Failed - NEO-HUB" />
        <jsp:param name="metaDescription" value="Your order could not be placed. Please try again." />
        <jsp:param name="metaKeywords" value="order failed, error, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="home" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">
        <div class="max-w-[100%] lg:max-w-[60vw] mx-auto">
            <div class="bg-white rounded-2xl border border-gray-200 p-8 text-center">

                <!--  Icon -->
                <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <i class="fa-solid fa-circle-exclamation text-red-600 text-3xl"></i>
                </div>
                
                <h1 class="text-2xl md:text-3xl font-bold text-accent mb-2">Order Failed</h1>
                <p class="text-gray-500 mb-2">We couldn’t process your order.</p>
                <p class="text-gray-400 text-sm mb-6">Please try again or contact support if the problem persists.</p>

                <!-- error message  -->
                <c:if test="${not empty errorMessage}">
                    <div class="bg-red-50 border border-red-200 rounded-xl p-3 mb-6 text-left">
                        <p class="text-red-600 text-sm"><i class="fa-solid fa-circle-info mr-1"></i> <c:out value="${errorMessage}"/></p>
                    </div>
                </c:if>

                <!-- button  -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/checkout" 
                       class="inline-flex items-center justify-center gap-2 bg-accent text-white px-6 py-3 rounded-xl font-semibold hover:opacity-90 transition">
                        <i class="fa-solid fa-rotate-right"></i> Try Again
                    </a>
                    <a href="${pageContext.request.contextPath}/cart" 
                       class="inline-flex items-center justify-center gap-2 border border-gray-300 text-gray-600 px-6 py-3 rounded-xl font-semibold hover:bg-gray-50 transition">
                        <i class="fa-solid fa-arrow-left"></i> Return to Cart
                    </a>
                </div>
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/products" 
                       class="text-sm text-gray-400 hover:text-accent transition">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>