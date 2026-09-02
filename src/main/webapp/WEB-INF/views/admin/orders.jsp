<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order Management | NEO-HUB Admin" />
</jsp:include>

<body class="bg-slate-50 font-poppins text-slate-900 antialiased">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Orders" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1 space-y-6">
            
            <!-- Page Header -->
            <div>
                <h2 class="text-2xl font-black text-slate-900">Order Management</h2>
                <p class="text-xs text-slate-400 font-medium mt-1">Review, track and update customer order statuses.</p>
            </div>

            <!-- Orders Table -->
            <div class="bg-white rounded-3xl shadow-sm border border-slate-200/80 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-[10px] uppercase font-extrabold text-slate-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">Order ID</th>
                                <th class="px-6 py-4">Customer</th>
                                <th class="px-6 py-4">Total</th>
                                <th class="px-6 py-4 text-center">Payment</th>
                                <th class="px-6 py-4 text-center">Order Status</th>
                                <th class="px-6 py-4 text-right">Details</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 text-xs font-medium">
                            <c:forEach var="o" items="${orderList}">
                                <tr class="hover:bg-slate-50/60 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="font-extrabold text-slate-900">#${o.id}</div>
                                        <div class="text-[10px] text-slate-400 font-medium mt-0.5">
                                            <fmt:formatDate value="${o.createdAt}" pattern="MMM dd, hh:mm a"/>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-slate-600 font-medium">${o.userFullName}</td>
                                    <td class="px-6 py-4 font-extrabold text-slate-900">Rs. ${o.totalAmount}</td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="px-2.5 py-1 rounded-xl text-[10px] font-bold uppercase
                                            ${o.paymentStatus eq 'Completed' ? 'bg-emerald-50 text-emerald-600 border border-emerald-100' : 'bg-amber-50 text-amber-600 border border-amber-100'}">
                                            ${o.paymentStatus}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="px-2.5 py-1 rounded-xl text-[10px] font-bold uppercase 
                                            ${o.orderStatus eq 'Delivered' ? 'bg-emerald-50 text-emerald-600 border border-emerald-100' : 
                                            o.orderStatus eq 'Cancelled' ? 'bg-red-50 text-red-600 border border-red-100' : 'bg-blue-50 text-blue-600 border border-blue-100'}">
                                            ${o.orderStatus}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <a href="orders?action=view&id=${o.id}" class="inline-flex items-center gap-1.5 text-brand-600 hover:text-brand-700 text-xs font-bold">
                                            View Details <i class="fa-solid fa-arrow-right text-[10px]"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orderList}">
                                <tr>
                                    <td colspan="6" class="px-6 py-20 text-center">
                                        <i class="fa-solid fa-cart-shopping text-slate-200 text-4xl mb-3 block"></i>
                                        <p class="text-slate-400 text-sm font-medium">No orders found.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>