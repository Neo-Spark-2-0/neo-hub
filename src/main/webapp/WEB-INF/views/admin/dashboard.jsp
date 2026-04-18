<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<!-- Include Head Template -->
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">

    <!-- Sidebar Inclusion -->
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <!-- Main Content Container -->
    <div class="sm:ml-64 min-h-screen flex flex-col">
        
        <!-- Header Inclusion -->
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Dashboard" />
        </jsp:include>

        <main class="p-6 md:p-10">
            
            <!-- STATS SECTION -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
                
                <!-- Revenue Card -->
                <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100 transition hover:shadow-md">
                    <div class="flex items-center justify-between mb-4">
                        <div class="p-3 bg-success/10 text-success rounded-xl">
                            <i class="fa-solid fa-money-bill-trend-up text-lg"></i>
                        </div>
                        <span class="text-[10px] font-bold text-success bg-success/10 px-2 py-1 rounded-lg">+12.5%</span>
                    </div>
                    <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Revenue</p>
                    <h3 class="text-2xl font-bold mt-1">Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></h3>
                </div>

                <!-- Orders Card -->
                <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100 transition hover:shadow-md">
                    <div class="flex items-center justify-between mb-4">
                        <div class="p-3 bg-info/10 text-info rounded-xl">
                            <i class="fa-solid fa-cart-shopping text-lg"></i>
                        </div>
                    </div>
                    <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Orders</p>
                    <h3 class="text-2xl font-bold mt-1">${totalOrders}</h3>
                </div>

                <!-- Products Card -->
                <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100 transition hover:shadow-md">
                    <div class="flex items-center justify-between mb-4">
                        <div class="p-3 bg-warning/10 text-warning rounded-xl">
                            <i class="fa-solid fa-box text-lg"></i>
                        </div>
                    </div>
                    <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Products</p>
                    <h3 class="text-2xl font-bold mt-1">${totalProducts}</h3>
                </div>

                <!-- Users Card -->
                <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100 transition hover:shadow-md">
                    <div class="flex items-center justify-between mb-4">
                        <div class="p-3 bg-accent/10 text-accent rounded-xl">
                            <i class="fa-solid fa-users text-lg"></i>
                        </div>
                    </div>
                    <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Active Users</p>
                    <h3 class="text-2xl font-bold mt-1">${totalUsers}</h3>
                </div>
            </div>

            <!-- GRID: STATUS TRACKER + RECENT ORDERS -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                
                <!-- Status Tracker Column -->
                <div class="lg:col-span-1 space-y-6">
                    <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                        <h4 class="text-sm font-bold mb-6 flex items-center gap-2">
                            <i class="fa-solid fa-bullseye text-info"></i> Order Fulfillment
                        </h4>
                        <div class="space-y-4">
                            <div class="flex items-center justify-between p-3 bg-secondary rounded-xl">
                                <span class="text-xs font-bold text-warning uppercase">Pending</span>
                                <span class="text-sm font-bold">${pendingOrders}</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-secondary rounded-xl">
                                <span class="text-xs font-bold text-info uppercase">Processing</span>
                                <span class="text-sm font-bold">${processingOrders}</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-secondary rounded-xl">
                                <span class="text-xs font-bold text-success uppercase">Delivered</span>
                                <span class="text-sm font-bold">${deliveredOrders}</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-secondary rounded-xl">
                                <span class="text-xs font-bold text-danger uppercase">Cancelled</span>
                                <span class="text-sm font-bold">${cancelledOrders}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Orders Table Column -->
                <div class="lg:col-span-2">
                    <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <div class="px-6 py-5 border-b border-secondary flex justify-between items-center bg-white">
                            <h3 class="font-bold text-sm uppercase tracking-wide">Recent Transactions</h3>
                            <a href="${pageContext.request.contextPath}/admin/orders" 
                               class="text-xs font-bold text-info hover:underline">View All Orders</a>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left">
                                <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400 tracking-wider">
                                    <tr>
                                        <th class="px-6 py-4">Order ID</th>
                                        <th class="px-6 py-4">Customer</th>
                                        <th class="px-6 py-4">Amount</th>
                                        <th class="px-6 py-4">Status</th>
                                        <th class="px-6 py-4">Date</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-secondary text-sm">
                                    <c:forEach var="order" items="${recentOrders}">
                                        <tr class="hover:bg-secondary/50 transition-colors">
                                            <td class="px-6 py-4 font-bold text-accent">#${order.orderNumber}</td>
                                            <td class="px-6 py-4 text-gray-600">${order.userName}</td>
                                            <td class="px-6 py-4 font-bold text-accent">Rs. ${order.totalAmount}</td>
                                            <td class="px-6 py-4">
                                                <span class="px-2 py-1 text-[10px] font-bold rounded-lg uppercase
                                                    ${order.orderStatus eq 'DELIVERED' ? 'bg-success/10 text-success' : 
                                                      order.orderStatus eq 'CANCELLED' ? 'bg-danger/10 text-danger' : 'bg-gray-100 text-gray-500'}">
                                                    ${order.orderStatus}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 text-xs text-gray-400">
                                                <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    </div>
    
    <!--  handle any redirect notifications (Flash Messages) -->
    <script>
        window.onload = function() {
            <c:if test="${not empty successMsg}">
                showToast("${successMsg}", "success");
            </c:if>
            <c:if test="${not empty errorMsg}">
                showToast("${errorMsg}", "error");
            </c:if>
        };
    </script>

</body>
</html>