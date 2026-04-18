<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order #${order.orderNumber}" />
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
                    <h2 class="text-2xl font-bold">Order #${order.orderNumber}</h2>
                    <span class="px-3 py-1 bg-info/10 text-info text-xs font-bold rounded-full uppercase">${order.orderStatus}</span>
                </div>
                
                <!-- Status Update Form -->
                <form action="orders" method="POST" class="flex gap-2">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <select name="orderStatus" class="bg-white border-none rounded-xl text-xs font-bold focus:ring-2 focus:ring-info shadow-sm">
                        <option value="PENDING" ${order.orderStatus eq 'PENDING' ? 'selected' : ''}>Pending</option>
                        <option value="PROCESSING" ${order.orderStatus eq 'PROCESSING' ? 'selected' : ''}>Processing</option>
                        <option value="SHIPPED" ${order.orderStatus eq 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                        <option value="DELIVERED" ${order.orderStatus eq 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                        <option value="CANCELLED" ${order.orderStatus eq 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
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
                                            <img src="${pageContext.request.contextPath}/${item.productImage}" class="w-10 h-10 rounded-lg border object-cover">
                                            <span class="text-sm font-bold text-accent">${item.productName}</span>
                                        </td>
                                        <td class="px-6 py-4 text-center text-sm">${item.quantity}</td>
                                        <td class="px-6 py-4 text-sm text-gray-400">Rs. ${item.price}</td>
                                        <td class="px-6 py-4 text-right text-sm font-bold">Rs. ${item.subtotal}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <div class="p-6 bg-slate-50 border-t border-secondary space-y-2">
                             <div class="flex justify-between text-xs text-gray-500"><span>Subtotal</span><span>Rs. ${order.subtotal}</span></div>
                             <div class="flex justify-between text-xs text-gray-500"><span>Shipping</span><span>Rs. ${order.shippingCharge}</span></div>
                             <c:if test="${order.discount > 0}"><div class="flex justify-between text-xs text-success"><span>Discount</span><span>- Rs. ${order.discount}</span></div></c:if>
                             <div class="flex justify-between text-lg font-bold text-accent pt-2 border-t border-gray-200"><span>Total Paid</span><span>Rs. ${order.totalAmount}</span></div>
                        </div>
                    </div>
                </div>

                <!-- Right: Customer Info -->
                <div class="space-y-6">
                    <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                        <h4 class="text-[10px] font-bold uppercase text-gray-400 mb-4 tracking-widest">Customer Info</h4>
                        <div class="flex items-center gap-4 mb-6">
                             <div class="w-12 h-12 bg-secondary rounded-full flex items-center justify-center font-bold text-accent text-lg">
                                 ${fn:substring(order.userName, 0, 1)}
                             </div>
                             <div>
                                 <p class="font-bold text-accent leading-none">${order.userName}</p>
                                 <p class="text-[10px] text-gray-400 mt-1 uppercase">User ID: #${order.userId}</p>
                             </div>
                        </div>
                        <div class="space-y-4">
                            <div><p class="text-[10px] text-gray-400 uppercase font-bold mb-1">Shipping Address</p><p class="text-xs font-medium text-accent leading-relaxed">${order.shippingAddress}</p></div>
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