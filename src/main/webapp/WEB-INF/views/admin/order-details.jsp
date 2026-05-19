<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order #${order.id}" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Order Details" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="flex items-center justify-between mb-8">
                <div class="flex items-center gap-4">
                    <a href="orders" class="w-10 h-10 flex items-center justify-center bg-white rounded-xl shadow-sm"><i class="fa-solid fa-arrow-left text-xs"></i></a>
                    <h2 class="text-2xl font-bold">Order #${order.id}</h2>
                    <span class="px-3 py-1 bg-info/10 text-info text-xs font-bold rounded-full uppercase">${order.orderStatus}</span>
                </div>
                
                <!-- Status Update Form -->
                <form action="orders" method="POST" class="flex gap-4">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <select name="orderStatus" class="bg-white px-7 py-2 border-none rounded-xl text-xs font-bold focus:ring-2 focus:ring-info shadow-sm">
                        <option value="Pending" ${order.orderStatus eq 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Processing" ${order.orderStatus eq 'Processing' ? 'selected' : ''}>Processing</option>
                        <option value="Shipped" ${order.orderStatus eq 'Shipped' ? 'selected' : ''}>Shipped</option>
                        <option value="Delivered" ${order.orderStatus eq 'Delivered' ? 'selected' : ''}>Delivered</option>
                        <option value="Cancelled" ${order.orderStatus eq 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                    <button type="submit" class="bg-accent text-white px-4 py-2 rounded-xl text-xs font-bold shadow-sm hover:opacity-90 transition">Update</button>
                </form>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                
                <!-- Left: Items Table -->
                <div class="lg:col-span-2 space-y-6">
                    <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <table class="w-full text-left">
                            <thead class="bg-secondary text-[10px] font-bold uppercase text-gray-400">
                                <tr>
                                    <th class="px-6 py-4">Product</th>
                                    <th class="px-6 py-4 text-center">Qty</th>
                                    <th class="px-6 py-4">Price</th>
                                    <th class="px-6 py-4 text-right">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-secondary">
                                <c:forEach var="item" items="${order.orderItems}">
                                    <tr>
                                        <td class="px-6 py-4 flex items-center gap-3">
                                            <c:choose>
                                                <c:when test="${not empty item.productImage}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${item.productImage}" 
                                                        alt="${item.productName}" 
                                                        class="w-12 h-12 object-cover rounded-lg"/>
                                                </c:when>
                                                <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg" 
                                                        alt="${item.productName}" 
                                                        class="w-12 h-12 object-cover rounded-lg"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="text-sm font-bold text-accent">${item.productName}</span>
                                        </td>
                                        <td class="px-6 py-4 text-center text-sm">${item.quantity}</td>
                                        <td class="px-6 py-4 text-sm text-gray-400">Rs. ${item.unitPrice}</td>
                                        <td class="px-6 py-4 text-right text-sm font-bold">Rs. ${item.quantity * item.unitPrice}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>


                        <!--Summary section -->
                       <div class="p-6 bg-slate-50 border-t border-secondary space-y-2">
                        <div class="flex justify-between text-xs text-gray-500"><span>Subtotal</span><span>Rs. ${order.subTotalAmount}</span></div>
                        <div class="flex justify-between text-xs text-gray-500"><span>Shipping</span><span>Rs. ${order.shippingCharge}</span></div>
                        <c:if test="${order.discountAmount > 0}">
                            <div class="flex justify-between text-xs text-success"><span>Discount</span><span>- Rs. ${order.discountAmount}</span></div>
                        </c:if>
                        <div class="flex justify-between text-lg font-bold text-accent pt-2 border-t border-gray-200"><span>Total Paid</span><span>Rs. ${order.totalAmount}</span></div>
                    </div>
                    </div>
                </div>

                <!-- Customer Side Bar -->
                <div class="lg:col-span-1 space-y-6">
                    <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                        <h4 class="text-[10px] font-bold uppercase text-gray-400 mb-4 tracking-widest">Customer Info</h4>
                        <div class="flex items-center gap-4 mb-6">
                            <div class="w-12 h-12 bg-secondary rounded-full flex items-center justify-center font-bold text-accent text-lg">
                                ${fn:substring(order.userFullName, 0, 1)}
                            </div>
                            <div>
                                <p class="font-bold text-accent leading-none">${order.userFullName}</p>
                                <p class="text-[10px] text-gray-400 mt-1 uppercase">User ID: #${order.userId}</p>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <div><p class="text-[10px] text-gray-400 uppercase font-bold mb-1">Shipping Address</p><p class="text-xs font-medium text-accent leading-relaxed">${order.userAddress}</p></div>
                            <div><p class="text-[10px] text-gray-400 uppercase font-bold mb-1">Payment Method</p><span class="text-xs font-bold text-accent uppercase bg-gray-100 px-2 py-1 rounded-lg">${order.paymentMethod}</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>