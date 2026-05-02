<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="Your Cart - NEO-HUB" />
        <jsp:param name="metaDescription" value="Review items in your shopping cart before checkout." />
        <jsp:param name="metaKeywords" value="cart, shopping, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="cart" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">
        <h1 class="text-2xl md:text-3xl font-bold text-accent mb-8">Shopping Cart</h1>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="bg-white rounded-2xl border border-gray-200 p-12 text-center">
                    <i class="fa-solid fa-cart-shopping text-5xl text-gray-300 mb-4"></i>
                    <p class="text-gray-500 mb-4">Your cart is empty.</p>
                    <a href="${pageContext.request.contextPath}/products"
                       class="inline-block bg-accent text-white px-6 py-3 rounded-xl hover:opacity-90 transition">
                        Continue Shopping
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Cart items table (spans 2 cols) -->
                    <div class="lg:col-span-2 bg-white rounded-2xl border border-gray-200 overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-sm">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th class="text-left py-4 px-5 font-semibold text-gray-600">Product</th>
                                        <th class="text-left py-4 px-5 font-semibold text-gray-600">Price</th>
                                        <th class="text-left py-4 px-5 font-semibold text-gray-600">Quantity</th>
                                        <th class="text-left py-4 px-5 font-semibold text-gray-600">Total</th>
                                        <th class="text-left py-4 px-5 font-semibold text-gray-600"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr class="border-b border-gray-100">
                                            <td class="py-4 px-5">
                                                <div class="flex items-center gap-3">
                                                    <img src="${pageContext.request.contextPath}${not empty item.productImage ? '/uploads/'.concat(item.productImage) : '/static/images/product-fallback.jpg'}"
                                                         alt="${item.productName}"
                                                         class="w-12 h-12 object-cover rounded-lg bg-gray-100">
                                                    <span class="font-medium text-gray-800">${item.productName}</span>
                                                </div>
                                            </td>
                                            <td class="py-4 px-5">
                                                <c:choose>
                                                    <c:when test="${item.productDiscountPrice > 0}">
                                                        <span class="text-accent font-semibold">Rs. <fmt:formatNumber value="${item.productDiscountPrice}" pattern="#,##0"/></span>
                                                        <br><span class="text-xs text-gray-400 line-through">Rs. <fmt:formatNumber value="${item.productPrice}" pattern="#,##0"/></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-accent font-semibold">Rs. <fmt:formatNumber value="${item.productPrice}" pattern="#,##0"/></span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="py-4 px-5">
                                                <form action="${pageContext.request.contextPath}/cart" method="post" class="flex items-center gap-1">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="productId" value="${item.productId}">
                                                    <input type="number" name="quantity" value="${item.quantity}"
                                                           min="1" max="${item.productStock}"
                                                           class="w-16 px-2 py-1 border border-gray-300 rounded-lg text-center focus:outline-none focus:border-accent"
                                                           onchange="this.form.submit()">
                                                </form>
                                            </td>
                                            <td class="py-4 px-5 font-semibold text-accent">
                                                Rs. <fmt:formatNumber value="${(item.productDiscountPrice > 0 ? item.productDiscountPrice : item.productPrice) * item.quantity}" pattern="#,##0"/>
                                            </td>
                                            <td class="py-4 px-5">
                                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="productId" value="${item.productId}">
                                                    <button type="submit" class="text-red-500 hover:text-red-700 transition">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Order summary (sidebar) -->
                    <div class="bg-white rounded-2xl border border-gray-200 p-6 h-fit sticky top-4">
                        <h2 class="text-lg font-bold text-accent mb-4">Order Summary</h2>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">Subtotal</span>
                                <span class="font-medium">Rs. <fmt:formatNumber value="${grandTotal}" pattern="#,##0"/></span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-500">Shipping</span>
                                <span class="font-medium">Rs. 100</span>
                            </div>
                            <div class="border-t border-gray-200 pt-3 mt-2">
                                <div class="flex justify-between text-base font-bold">
                                    <span>Total</span>
                                    <span class="text-accent">Rs. <fmt:formatNumber value="${grandTotal + 100}" pattern="#,##0"/></span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-6 space-y-3">
                            <a href="${pageContext.request.contextPath}/checkout"
                               class="block w-full text-center bg-accent text-white py-3 rounded-xl font-semibold hover:opacity-90 transition">
                                Proceed to Checkout
                            </a>
                            <a href="${pageContext.request.contextPath}/products"
                               class="block w-full text-center border border-gray-300 text-gray-600 py-3 rounded-xl font-medium hover:bg-gray-50 transition">
                                Continue Shopping
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>