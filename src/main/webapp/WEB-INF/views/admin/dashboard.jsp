<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | NEO-HUB</title>
    <!-- Include your imports -->
    <jsp:include page="../common/import.jsp"/>
</head>

<body class="bg-gray-100 font-poppins">

<!-- ===== LAYOUT ===== -->
<div class="flex">

    <!-- ===== SIDEBAR ===== -->
    <aside class="w-64 bg-dark text-white min-h-screen fixed">

        <div class="p-5 border-b border-gray-700">
            <h2 class="text-xl font-bold text-primary">
                <i class="fa fa-microchip mr-2"></i>NEO-HUB
            </h2>
            <p class="text-xs text-gray-400">Admin Panel</p>
        </div>

        <nav class="mt-4 text-sm">

            <p class="px-5 text-gray-400 text-xs mb-2">MAIN</p>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="flex items-center gap-3 px-5 py-3 bg-primary/10 text-primary border-l-4 border-primary">
                <i class="fa fa-chart-line"></i> Dashboard
            </a>

            <p class="px-5 text-gray-400 text-xs mt-4 mb-2">MANAGEMENT</p>

            <a href="${pageContext.request.contextPath}/admin/users"
               class="flex items-center gap-3 px-5 py-3 hover:bg-white/5">
                <i class="fa fa-users"></i> Users
            </a>

            <a href="${pageContext.request.contextPath}/admin/products"
               class="flex items-center gap-3 px-5 py-3 hover:bg-white/5">
                <i class="fa fa-box"></i> Products
            </a>

            <a href="${pageContext.request.contextPath}/admin/categories"
               class="flex items-center gap-3 px-5 py-3 hover:bg-white/5">
                <i class="fa fa-tags"></i> Categories
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders"
               class="flex items-center gap-3 px-5 py-3 hover:bg-white/5">
                <i class="fa fa-shopping-cart"></i> Orders
            </a>

            <p class="px-5 text-gray-400 text-xs mt-4 mb-2">ACCOUNT</p>

            <a href="${pageContext.request.contextPath}/logout"
               class="flex items-center gap-3 px-5 py-3 hover:bg-red-500/20 text-red-400">
                <i class="fa fa-sign-out-alt"></i> Logout
            </a>

        </nav>
    </aside>

    <!-- ===== MAIN CONTENT ===== -->
    <main class="ml-64 w-full">

        <!-- TOP BAR -->
        <div class="bg-white shadow px-6 py-4 flex justify-between items-center">

            <div>
                <h2 class="text-lg font-semibold text-dark">Dashboard</h2>
                <p class="text-sm text-gray-500">
                    Welcome back, ${sessionScope.user.fullName}
                </p>
            </div>

            <div class="flex items-center gap-3">
                <img src="${pageContext.request.contextPath}/uploads/profiles/${sessionScope.user.profileImage}"
                     class="w-10 h-10 rounded-full border object-cover"/>
                <span class="text-sm font-medium">${sessionScope.user.fullName}</span>
            </div>

        </div>

        <!-- CONTENT -->
        <div class="p-6 space-y-6">

            <!-- ===== STATS ===== -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">

                <!-- Users -->
                <div class="bg-white p-5 rounded-xl shadow flex items-center gap-4">
                    <div class="bg-blue-500 text-white p-3 rounded-lg">
                        <i class="fa fa-users"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold">${totalUsers}</h3>
                        <p class="text-sm text-gray-500">Users</p>
                    </div>
                </div>

                <!-- Products -->
                <div class="bg-white p-5 rounded-xl shadow flex items-center gap-4">
                    <div class="bg-green-500 text-white p-3 rounded-lg">
                        <i class="fa fa-box"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold">${totalProducts}</h3>
                        <p class="text-sm text-gray-500">Products</p>
                    </div>
                </div>

                <!-- Orders -->
                <div class="bg-white p-5 rounded-xl shadow flex items-center gap-4">
                    <div class="bg-yellow-500 text-white p-3 rounded-lg">
                        <i class="fa fa-shopping-cart"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold">${totalOrders}</h3>
                        <p class="text-sm text-gray-500">Orders</p>
                    </div>
                </div>

                <!-- Revenue -->
                <div class="bg-white p-5 rounded-xl shadow flex items-center gap-4">
                    <div class="bg-cyan-500 text-white p-3 rounded-lg">
                        <i class="fa fa-dollar-sign"></i>
                    </div>
                    <div>
                        <h3 class="text-xl font-bold">
                            Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>
                        </h3>
                        <p class="text-sm text-gray-500">Revenue</p>
                    </div>
                </div>

            </div>

            <!-- ===== ORDER STATUS ===== -->
            <div class="grid grid-cols-2 md:grid-cols-5 gap-4">

                <div class="bg-white p-4 rounded-lg shadow text-center border-t-4 border-yellow-400">
                    <h3 class="text-xl font-bold text-yellow-500">${pendingOrders}</h3>
                    <p class="text-sm text-gray-500">Pending</p>
                </div>

                <div class="bg-white p-4 rounded-lg shadow text-center border-t-4 border-blue-400">
                    <h3 class="text-xl font-bold text-blue-500">${processingOrders}</h3>
                    <p class="text-sm text-gray-500">Processing</p>
                </div>

                <div class="bg-white p-4 rounded-lg shadow text-center border-t-4 border-indigo-500">
                    <h3 class="text-xl font-bold text-indigo-500">${shippedOrders}</h3>
                    <p class="text-sm text-gray-500">Shipped</p>
                </div>

                <div class="bg-white p-4 rounded-lg shadow text-center border-t-4 border-green-500">
                    <h3 class="text-xl font-bold text-green-500">${deliveredOrders}</h3>
                    <p class="text-sm text-gray-500">Delivered</p>
                </div>

                <div class="bg-white p-4 rounded-lg shadow text-center border-t-4 border-red-500">
                    <h3 class="text-xl font-bold text-red-500">${cancelledOrders}</h3>
                    <p class="text-sm text-gray-500">Cancelled</p>
                </div>

            </div>

            <!-- ===== RECENT ORDERS ===== -->
            <div class="bg-white rounded-xl shadow">
                <div class="flex justify-between items-center p-4 border-b">
                    <h3 class="font-semibold">Recent Orders</h3>
                    <a href="${pageContext.request.contextPath}/admin/orders"
                       class="text-primary text-sm">View All</a>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-gray-100 text-gray-600">
                        <tr>
                            <th class="p-3 text-left">Order</th>
                            <th class="p-3">Customer</th>
                            <th class="p-3">Amount</th>
                            <th class="p-3">Status</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="order" items="${recentOrders}">
                            <tr class="border-t hover:bg-gray-50">
                                <td class="p-3">${order.orderNumber}</td>
                                <td class="p-3">${order.userName}</td>
                                <td class="p-3">Rs. ${order.totalAmount}</td>
                                <td class="p-3">
                                    <span class="px-2 py-1 text-xs rounded-full bg-gray-200">
                                        ${order.orderStatus}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </main>
</div>

</body>
</html>