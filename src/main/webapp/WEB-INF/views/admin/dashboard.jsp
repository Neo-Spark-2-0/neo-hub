<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">

<jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
    <jsp:param name="activePage" value="dashboard" />
</jsp:include>

<div class="sm:ml-64 min-h-screen flex flex-col">

    <jsp:include page="/WEB-INF/templates/admin/header.jsp">
        <jsp:param name="activePage" value="Dashboard" />
    </jsp:include>

    <main class="p-6 md:p-10 space-y-10">

        <%-- ── SNAPSHOT CARDS ─────────────────────────────────────────── --%>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">

            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-4">
                    <div class="p-3 bg-success/10 text-success rounded-xl">
                        <i class="fa-solid fa-money-bill-trend-up text-lg"></i>
                    </div>
                </div>
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Revenue</p>
                <h3 class="text-2xl font-bold mt-1">
                    Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>
                </h3>
            </div>

            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-4">
                    <div class="p-3 bg-info/10 text-info rounded-xl">
                        <i class="fa-solid fa-cart-shopping text-lg"></i>
                    </div>
                </div>
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Orders</p>
                <h3 class="text-2xl font-bold mt-1">${totalOrders}</h3>
            </div>

            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-4">
                    <div class="p-3 bg-warning/10 text-warning rounded-xl">
                        <i class="fa-solid fa-box text-lg"></i>
                    </div>
                </div>
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Products</p>
                <h3 class="text-2xl font-bold mt-1">${totalProducts}</h3>
            </div>

            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-4">
                    <div class="p-3 bg-accent/10 text-accent rounded-xl">
                        <i class="fa-solid fa-users text-lg"></i>
                    </div>
                </div>
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Active Users</p>
                <h3 class="text-2xl font-bold mt-1">${totalUsers}</h3>
            </div>
        </div>

        <%-- ── ORDER FULFILLMENT STATUS ────────────────────────────────── --%>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div class="bg-primary p-4 rounded-2xl border border-gray-100 flex items-center gap-4">
                <div class="p-3 bg-warning/10 text-warning rounded-xl shrink-0">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <p class="text-[10px] font-bold text-gray-400 uppercase">Pending</p>
                    <p class="text-xl font-bold">${pendingOrders}</p>
                </div>
            </div>
            <div class="bg-primary p-4 rounded-2xl border border-gray-100 flex items-center gap-4">
                <div class="p-3 bg-info/10 text-info rounded-xl shrink-0">
                    <i class="fa-solid fa-gears"></i>
                </div>
                <div>
                    <p class="text-[10px] font-bold text-gray-400 uppercase">Processing</p>
                    <p class="text-xl font-bold">${processingOrders}</p>
                </div>
            </div>
            <div class="bg-primary p-4 rounded-2xl border border-gray-100 flex items-center gap-4">
                <div class="p-3 bg-success/10 text-success rounded-xl shrink-0">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <p class="text-[10px] font-bold text-gray-400 uppercase">Delivered</p>
                    <p class="text-xl font-bold">${deliveredOrders}</p>
                </div>
            </div>
            <div class="bg-primary p-4 rounded-2xl border border-gray-100 flex items-center gap-4">
                <div class="p-3 bg-danger/10 text-danger rounded-xl shrink-0">
                    <i class="fa-solid fa-ban"></i>
                </div>
                <div>
                    <p class="text-[10px] font-bold text-gray-400 uppercase">Cancelled</p>
                    <p class="text-xl font-bold">${cancelledOrders}</p>
                </div>
            </div>
        </div>

        <%-- ── CHARTS ROW ───────────────────────────────────────────────── --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <%-- Revenue Trend (12 months) - takes 2/3 width --%>
            <div class="lg:col-span-2 bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-bold">Revenue Trend</h4>
                        <p class="text-[10px] text-gray-400 mt-0.5">Last 12 months</p>
                    </div>
                    <i class="fa-solid fa-chart-line text-info text-lg"></i>
                </div>
                <canvas id="revenueChart" height="100"></canvas>
            </div>

            <%-- Order Status Doughnut - takes 1/3 width --%>
            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-bold">Order Breakdown</h4>
                        <p class="text-[10px] text-gray-400 mt-0.5">By status</p>
                    </div>
                    <i class="fa-solid fa-chart-pie text-warning text-lg"></i>
                </div>
                <canvas id="statusChart"></canvas>
            </div>
        </div>

        <%-- ── SECOND CHARTS ROW ───────────────────────────────────────── --%>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

            <%-- Top Selling Products --%>
            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-bold">Top Selling Products</h4>
                        <p class="text-[10px] text-gray-400 mt-0.5">By units sold</p>
                    </div>
                    <i class="fa-solid fa-trophy text-warning text-lg"></i>
                </div>
                <canvas id="topProductsChart" height="160"></canvas>
            </div>

            <%-- Sales by Category --%>
            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-bold">Sales by Category</h4>
                        <p class="text-[10px] text-gray-400 mt-0.5">By units sold</p>
                    </div>
                    <i class="fa-solid fa-layer-group text-success text-lg"></i>
                </div>
                <canvas id="categoryChart" height="160"></canvas>
            </div>
        </div>

        <%-- ── LOW STOCK ALERT + RECENT ORDERS ────────────────────────── --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <%-- Low Stock Alert --%>
            <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="px-6 py-5 border-b border-secondary flex justify-between items-center">
                    <h3 class="font-bold text-sm flex items-center gap-2">
                        <i class="fa-solid fa-triangle-exclamation text-danger"></i> Low Stock
                    </h3>
                    <a href="${pageContext.request.contextPath}/admin/products?status=low_stock"
                       class="text-xs font-bold text-info hover:underline">View All</a>
                </div>
                <div class="divide-y divide-secondary">
                    <c:forEach var="p" items="${lowStockProducts}">
                        <div class="px-6 py-4 flex items-center justify-between">
                            <div>
                                <p class="text-sm font-bold leading-tight">${p.name}</p>
                                <p class="text-[10px] text-gray-400 font-mono mt-0.5">${p.stockKeepingUnit}</p>
                            </div>
                            <span class="text-xs font-bold px-2 py-1 rounded-lg
                                ${p.stock == 0 ? 'bg-danger/10 text-danger' : 'bg-warning/10 text-warning'}">
                                ${p.stock} left
                            </span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty lowStockProducts}">
                        <div class="px-6 py-8 text-center text-sm text-gray-400 italic">
                            All products well stocked
                        </div>
                    </c:if>
                </div>
            </div>

            <%-- Recent Orders --%>
            <div class="lg:col-span-2 bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="px-6 py-5 border-b border-secondary flex justify-between items-center">
                    <h3 class="font-bold text-sm uppercase tracking-wide">Recent Orders</h3>
                    <a href="${pageContext.request.contextPath}/admin/orders"
                       class="text-xs font-bold text-info hover:underline">View All</a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">Order</th>
                                <th class="px-6 py-4">Customer</th>
                                <th class="px-6 py-4">Amount</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4">Date</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-secondary text-sm">
                            <c:forEach var="order" items="${recentOrders}">
                                <tr class="hover:bg-secondary/50 transition-colors">
                                    <td class="px-6 py-4 font-bold">#${order.id}</td>
                                    <td class="px-6 py-4 text-gray-600">${order.userFullName}</td>
                                    <td class="px-6 py-4 font-bold">
                                        Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="px-2 py-1 text-[10px] font-bold rounded-lg uppercase
                                            ${order.orderStatus eq 'Delivered'  ? 'bg-success/10 text-success'  :
                                              order.orderStatus eq 'Cancelled'  ? 'bg-danger/10  text-danger'   :
                                              order.orderStatus eq 'Processing' ? 'bg-info/10    text-info'     :
                                                                                  'bg-warning/10 text-warning'}">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-xs text-gray-400">
                                        <fmt:formatDate value="${order.createdAt}" pattern="MMM dd, yyyy"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </main>

    <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
</div>

<%-- ── CHART DATA FROM SERVLET (written as JS variables) ─────────────── --%>
<script>
    <%-- Build JS arrays from Java lists passed by servlet --%>

    const revenueLabels = [
        <c:forEach var="row" items="${monthlyRevenue}" varStatus="s">
            "${row[0]}"<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
    const revenueData = [
        <c:forEach var="row" items="${monthlyRevenue}" varStatus="s">
            ${row[1]}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    const statusLabels = [
        <c:forEach var="row" items="${orderStatusData}" varStatus="s">
            "${row[0]}"<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
    const statusData = [
        <c:forEach var="row" items="${orderStatusData}" varStatus="s">
            ${row[1]}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    const topProductLabels = [
        <c:forEach var="row" items="${topProducts}" varStatus="s">
            "${row[0]}"<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
    const topProductData = [
        <c:forEach var="row" items="${topProducts}" varStatus="s">
            ${row[1]}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    const categoryLabels = [
        <c:forEach var="row" items="${salesByCategory}" varStatus="s">
            "${row[0]}"<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
    const categoryData = [
        <c:forEach var="row" items="${salesByCategory}" varStatus="s">
            ${row[1]}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];
</script>

<%-- ── CHART.JS ────────────────────────────────────────────────────────── --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    const palette = {
        blue:   '#3B82F6',
        green:  '#22C55E',
        yellow: '#F59E0B',
        red:    '#EF4444',
        purple: '#8B5CF6',
        teal:   '#14B8A6',
    };

    // ── 1. Revenue Line Chart ──────────────────────────────────────────
    new Chart(document.getElementById('revenueChart'), {
        type: 'line',
        data: {
            labels: revenueLabels,
            datasets: [{
                label: 'Revenue (Rs.)',
                data: revenueData,
                borderColor: palette.blue,
                backgroundColor: 'rgba(59,130,246,0.08)',
                borderWidth: 2,
                pointRadius: 4,
                pointBackgroundColor: palette.blue,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: ctx => ' Rs. ' + ctx.parsed.y.toLocaleString()
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0,0,0,0.04)' },
                    ticks: {
                        callback: v => 'Rs. ' + v.toLocaleString(),
                        font: { size: 10 }
                    }
                },
                x: {
                    grid: { display: false },
                    ticks: { font: { size: 10 } }
                }
            }
        }
    });

    // ── 2. Order Status Doughnut ───────────────────────────────────────
    new Chart(document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: statusLabels,
            datasets: [{
                data: statusData,
                backgroundColor: [palette.yellow, palette.blue, palette.teal, palette.green, palette.red],
                borderWidth: 2,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            cutout: '65%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { font: { size: 10 }, padding: 12 }
                }
            }
        }
    });

    // ── 3. Top Products Horizontal Bar ────────────────────────────────
    new Chart(document.getElementById('topProductsChart'), {
        type: 'bar',
        data: {
            labels: topProductLabels,
            datasets: [{
                label: 'Units Sold',
                data: topProductData,
                backgroundColor: palette.purple,
                borderRadius: 6
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            plugins: { legend: { display: false } },
            scales: {
                x: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0,0,0,0.04)' },
                    ticks: { font: { size: 10 } }
                },
                y: {
                    grid: { display: false },
                    ticks: { font: { size: 10 } }
                }
            }
        }
    });

    // ── 4. Sales by Category Bar ──────────────────────────────────────
    new Chart(document.getElementById('categoryChart'), {
        type: 'bar',
        data: {
            labels: categoryLabels,
            datasets: [{
                label: 'Units Sold',
                data: categoryData,
                backgroundColor: palette.teal,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0,0,0,0.04)' },
                    ticks: { font: { size: 10 } }
                },
                x: {
                    grid: { display: false },
                    ticks: { font: { size: 10 } }
                }
            }
        }
    });

    // ── Flash toasts ──────────────────────────────────────────────────
    window.addEventListener('DOMContentLoaded', function () {
        <c:if test="${not empty successMsg}">
            showToast('<c:out value="${successMsg}"/>', 'success');
        </c:if>
        <c:if test="${not empty errorMsg}">
            showToast('<c:out value="${errorMsg}"/>', 'error');
        </c:if>
    });
</script>

</body>
</html>