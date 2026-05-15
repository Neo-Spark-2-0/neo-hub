<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="My Orders - NEO-HUB" />
        <jsp:param name="metaDescription" value="View your order history and track your purchases." />
        <jsp:param name="metaKeywords" value="orders, history, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">
        <h1 class="text-2xl md:text-3xl font-bold text-accent mb-8">My Orders</h1>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="bg-white rounded-2xl border border-gray-200 p-12 text-center">
                    <i class="fa-solid fa-receipt text-5xl text-gray-300 mb-4"></i>
                    <p class="text-gray-500 mb-4">You have no orders yet.</p>
                    <a href="${pageContext.request.contextPath}/products"
                       class="inline-block bg-accent text-white px-6 py-3 rounded-xl hover:opacity-90 transition">
                        Start Shopping
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Order ID</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Date</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Total</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Payment</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Status</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr class="border-b border-gray-100 hover:bg-gray-50 transition">
                                        <td class="py-4 px-5 font-medium text-accent">#${order.id}</td>
                                        <td class="py-4 px-5 text-gray-600">
                                            <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td class="py-4 px-5 font-semibold text-accent">
                                            Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                                        </td>
                                        <td class="py-4 px-5">
                                            <c:choose>
                                                <c:when test="${order.paymentMethod == 'Khalti'}">
                                                    <span class="inline-flex items-center gap-1 text-red-600">
                                                        <i class="fa-solid fa-paper-plane text-[#DC0019]"></i>Khalti
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center gap-1 text-green-600">
                                                        <i class="fa-solid fa-money-bill-wave"></i> COD
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="py-4 px-5">
                                            <c:choose>
                                                <c:when test="${order.orderStatus == 'Delivered'}">
                                                    <span class="inline-block px-2 py-1 text-xs font-semibold bg-green-100 text-green-700 rounded-full">Delivered</span>
                                                </c:when>
                                                <c:when test="${order.orderStatus == 'Cancelled'}">
                                                    <span class="inline-block px-2 py-1 text-xs font-semibold bg-red-100 text-red-700 rounded-full">Cancelled</span>
                                                </c:when>
                                                <c:when test="${order.orderStatus == 'Shipped'}">
                                                    <span class="inline-block px-2 py-1 text-xs font-semibold bg-blue-100 text-blue-700 rounded-full">Shipped</span>
                                                </c:when>
                                                <c:when test="${order.orderStatus == 'Processing'}">
                                                    <span class="inline-block px-2 py-1 text-xs font-semibold bg-yellow-100 text-yellow-700 rounded-full">Processing</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-block px-2 py-1 text-xs font-semibold bg-gray-100 text-gray-700 rounded-full">${order.orderStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="py-4 px-5">
                                            <a href="${pageContext.request.contextPath}/order-history?action=view&id=${order.id}"
                                               class="text-accent hover:text-accent/70 text-sm font-medium transition">
                                                View Details →
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>