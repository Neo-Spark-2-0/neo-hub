<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>   
<table class="w-full text-xs text-left">
    <thead class="bg-slate-50 border-b border-slate-100 text-[11px] font-extrabold text-slate-400 uppercase tracking-wider">
        <tr>
            <th class="py-4 px-6">Order ID</th>
            <th class="py-4 px-6">Date Placed</th>
            <th class="py-4 px-6">Total Amount</th>
            <th class="py-4 px-6">Payment Channel</th>
            <th class="py-4 px-6">Status</th>
            <th class="py-4 px-6 text-right">Actions</th>
        </tr>
    </thead>
    <tbody class="divide-y divide-slate-100 font-medium text-slate-700">
        <c:forEach var="order" items="${orders}">
            <tr class="hover:bg-slate-50/60 transition group">
                <td class="py-4 px-6 font-extrabold text-slate-900">
                    <span class="font-mono">#${order.id}</span>
                </td>
                <td class="py-4 px-6 text-slate-500 font-semibold">
                    <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy"/>
                </td>
                <td class="py-4 px-6 font-extrabold text-slate-900">
                    Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                </td>
                <td class="py-4 px-6">
                    <c:choose>
                        <c:when test="${order.paymentMethod == 'Khalti'}">
                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-purple-50 text-purple-700 border border-purple-200 text-[11px] font-bold">
                                <i class="fa-solid fa-wallet text-purple-600"></i> Khalti
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-emerald-50 text-emerald-700 border border-emerald-200 text-[11px] font-bold">
                                <i class="fa-solid fa-hand-holding-dollar text-emerald-600"></i> COD
                            </span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="py-4 px-6">
                    <c:choose>
                        <c:when test="${order.orderStatus == 'Delivered'}">
                            <span class="inline-flex items-center gap-1 px-2.5 py-1 text-[11px] font-bold bg-brand-50 border border-brand-200 text-brand-700 rounded-lg">
                                <i class="fa-solid fa-circle-check"></i> Delivered
                            </span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'Cancelled'}">
                            <span class="inline-flex items-center gap-1 px-2.5 py-1 text-[11px] font-bold bg-red-50 border border-red-200 text-danger rounded-lg">
                                <i class="fa-solid fa-circle-xmark"></i> Cancelled
                            </span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'Shipped'}">
                            <span class="inline-flex items-center gap-1 px-2.5 py-1 text-[11px] font-bold bg-blue-50 border border-blue-200 text-blue-700 rounded-lg">
                                <i class="fa-solid fa-truck-fast"></i> Shipped
                            </span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'Processing'}">
                            <span class="inline-flex items-center gap-1 px-2.5 py-1 text-[11px] font-bold bg-amber-50 border border-amber-200 text-amber-700 rounded-lg">
                                <i class="fa-solid fa-arrows-rotate"></i> Processing
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="inline-flex items-center gap-1 px-2.5 py-1 text-[11px] font-bold bg-slate-100 text-slate-700 rounded-lg">
                                <i class="fa-solid fa-clock"></i> ${order.orderStatus}
                            </span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="py-4 px-6 text-right">
                    <a href="${pageContext.request.contextPath}/order-history?action=view&id=${order.id}"
                       class="inline-flex items-center gap-1 px-3 py-1.5 rounded-xl bg-slate-100 hover:bg-slate-900 hover:text-white text-slate-700 text-xs font-bold transition shadow-subtle">
                        <span>Details</span>
                        <i class="fa-solid fa-chevron-right text-[9px]"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>