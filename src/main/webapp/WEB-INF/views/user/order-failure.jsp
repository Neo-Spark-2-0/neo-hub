<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order Unsuccessful | NEO-HUB" />
    <jsp:param name="metaDescription" value="Your order could not be placed. Please try again." />
    <jsp:param name="metaKeywords" value="order failed, error, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[92vw] max-w-2xl mx-auto py-12 pb-28 space-y-8">
        <div class="bg-white rounded-3xl border border-slate-200/80 p-8 sm:p-12 text-center shadow-card space-y-6">

            <!-- Error Icon -->
            <div class="w-20 h-20 bg-red-50 text-danger border border-red-200 rounded-full flex items-center justify-center mx-auto text-3xl shadow-subtle">
                <i class="fa-solid fa-circle-exclamation"></i>
            </div>
            
            <div class="space-y-2">
                <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">Order Could Not Be Placed</h1>
                <p class="text-xs sm:text-sm text-slate-500 font-medium">
                    We were unable to complete your checkout process. Your payment has not been captured.
                </p>
            </div>

            <!-- Error message if present -->
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-50 border border-red-200/80 rounded-2xl p-4 text-left text-xs text-danger font-medium flex items-start gap-2.5">
                    <i class="fa-solid fa-triangle-exclamation text-sm flex-shrink-0 mt-0.5"></i>
                    <span><c:out value="${errorMessage}"/></span>
                </div>
            </c:if>

            <!-- Action buttons -->
            <div class="flex flex-col sm:flex-row items-center justify-center gap-3 pt-2">
                <a href="${pageContext.request.contextPath}/checkout" 
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm px-6 py-3.5 rounded-2xl transition shadow-md">
                    <i class="fa-solid fa-rotate-right text-brand-400"></i>
                    <span>Try Checkout Again</span>
                </a>
                <a href="${pageContext.request.contextPath}/cart" 
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold text-xs sm:text-sm px-6 py-3.5 rounded-2xl transition">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span>Review Shopping Cart</span>
                </a>
            </div>

            <div class="pt-4 border-t border-slate-100 text-xs text-slate-500 font-medium">
                Need immediate assistance?
                <a href="${pageContext.request.contextPath}/contact" class="text-brand-600 hover:text-brand-700 font-bold ml-1 transition">
                    Contact Customer Support →
                </a>
            </div>

        </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>