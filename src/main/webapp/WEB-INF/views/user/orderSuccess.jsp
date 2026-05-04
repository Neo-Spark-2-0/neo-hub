<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="Order Placed - NEO-HUB" />
        <jsp:param name="metaDescription" value="Your order has been placed successfully!" />
        <jsp:param name="metaKeywords" value="order success, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="home" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">
        <div class="max-w-2xl mx-auto">
            <!-- Success Card -->
            <div class="bg-white rounded-2xl border border-gray-200 p-8 text-center">
                <!-- Success Icon -->
                <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <i class="fa-solid fa-check text-green-600 text-3xl"></i>
                </div>
                
                <h1 class="text-2xl md:text-3xl font-bold text-accent mb-2">Order Placed Successfully!</h1>
                <p class="text-gray-500 mb-6">Thank you for your purchase. Your order has been received.</p>

                <!-- Order Info Box -->
                <div class="bg-gray-50 rounded-xl p-6 mb-6 text-left">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Order ID</p>
                            <p class="text-lg font-bold text-accent">#${order.id}</p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Payment Method</p>
                            <p class="text-lg font-semibold">
                                <c:choose>
                                    <c:when test="${order.paymentMethod == 'Khalti'}">
                                        <span class="text-purple-600"><i class="fa-solid fa-wallet mr-1"></i> Khalti Wallet</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-green-600"><i class="fa-solid fa-money-bill-wave mr-1"></i> Cash on Delivery</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Order Status</p>
                            <p class="text-lg font-semibold">
                                <c:choose>
                                    <c:when test="${order.orderStatus == 'Pending'}">
                                        <span class="text-yellow-600"><i class="fa-solid fa-clock mr-1"></i> Pending</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 'Confirmed'}">
                                        <span class="text-green-600"><i class="fa-solid fa-circle-check mr-1"></i> Confirmed</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-blue-600">${order.orderStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Delivery Address</p>
                            <p class="text-sm text-gray-600">${order.userAddress}</p>
                        </div>
                    </div>
                </div>

                <!-- Order Items Table -->
                <div class="border-t border-gray-200 pt-6 mb-6">
                    <h3 class="text-lg font-semibold text-accent mb-4 text-left">Order Items</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="text-left py-3 px-4 font-semibold text-gray-600">Product</th>
                                    <th class="text-center py-3 px-4 font-semibold text-gray-600">Quantity</th>
                                    <th class="text-right py-3 px-4 font-semibold text-gray-600">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.orderItems}">
                                    <tr class="border-b border-gray-100">
                                        <td class="py-3 px-4 text-left font-medium text-accent">${item.productName}</td>
                                        <td class="py-3 px-4 text-center">${item.quantity}</td>
                                        <td class="py-3 px-4 text-right">Rs. <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,##0"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-gray-50">
                                <tr class="border-t border-gray-200">
                                    <td colspan="2" class="py-3 px-4 text-right font-bold text-accent">Total Paid:</td>
                                    <td class="py-3 px-4 text-right font-bold text-accent">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/order-history" 
                       class="inline-flex items-center justify-center gap-2 bg-accent text-white px-6 py-3 rounded-xl font-semibold hover:opacity-90 transition">
                        <i class="fa-solid fa-receipt"></i> View My Orders
                    </a>
                    <a href="${pageContext.request.contextPath}/products" 
                       class="inline-flex items-center justify-center gap-2 border border-gray-300 text-gray-600 px-6 py-3 rounded-xl font-semibold hover:bg-gray-50 transition">
                        <i class="fa-solid fa-cart-shopping"></i> Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>