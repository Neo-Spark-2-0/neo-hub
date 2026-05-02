<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order Management" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Orders" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <table class="w-full text-left">
                    <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400 tracking-wider">
                        <tr>
                            <th class="px-6 py-4">Order ID</th>
                            <th class="px-6 py-4">Customer</th>
                            <th class="px-6 py-4">Total</th>
                            <th class="px-6 py-4 text-center">Payment</th>
                            <th class="px-6 py-4 text-center">Order Status</th>
                            <th class="px-6 py-4 text-right">Details</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-secondary text-sm">
                        <c:forEach var="o" items="${orderList}">
                            <tr class="hover:bg-secondary/30 transition-colors">
                                <td class="px-6 py-4">
                                   
                                    <div class="font-bold text-accent">#${o.id}</div>
                                    <div class="text-[10px] text-gray-400 font-medium">
                                       
                                        <fmt:formatDate value="${o.createdAt}" pattern="MMM dd, hh:mm a"/>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-gray-600 font-medium">${o.userFullName}</td>
                                <td class="px-6 py-4 font-bold text-accent">Rs. ${o.totalAmount}</td>
                                <td class="px-6 py-4 text-center">
                                    
                                    <span class="px-2 py-1 rounded-lg text-[10px] font-bold uppercase ${o.paymentStatus eq 'Completed' ? 'bg-success/10 text-success' : 'bg-warning/10 text-warning'}">
                                        ${o.paymentStatus}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-center">
                                   
                                    <span class="px-2 py-1 rounded-lg text-[10px] font-bold uppercase 
                                        ${o.orderStatus eq 'Delivered' ? 'bg-success text-white' : 
                                        o.orderStatus eq 'Cancelled' ? 'bg-danger text-white' : 'bg-info/10 text-info'}">
                                        ${o.orderStatus}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <a href="orders?action=view&id=${o.id}" class="text-info hover:underline text-xs font-bold">
                                        View Details <i class="fa-solid fa-arrow-right ml-1"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>