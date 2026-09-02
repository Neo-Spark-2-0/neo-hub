<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
</jsp:include>

<body class="bg-slate-50 font-poppins text-slate-900 antialiased">

<jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
    <jsp:param name="activePage" value="dashboard" />
</jsp:include>

<div class="sm:ml-64 min-h-screen flex flex-col">

    <jsp:include page="/WEB-INF/templates/admin/header.jsp">
        <jsp:param name="activePage" value="Dashboard" />
    </jsp:include>

    <main class="p-6 md:p-10 space-y-8">

        <%-- ── SNAPSHOT CARDS ─────────────────────────────────────────── --%>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">

            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80 space-y-3">
                <div class="flex items-center justify-between">
                    <div class="p-3 bg-emerald-50 text-emerald-600 rounded-2xl border border-emerald-100">
                        <i class="fa-solid fa-money-bill-trend-up text-lg"></i>
                    </div>
                    <span class="text-[10px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-100 px-2 py-1 rounded-xl uppercase tracking-wider">Revenue</span>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Total Revenue</p>
                    <h3 class="text-2xl font-black text-slate-900 mt-0.5">
                        Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>
                    </h3>
                </div>
            </div>

            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80 space-y-3">
                <div class="flex items-center justify-between">
                    <div class="p-3 bg-blue-50 text-blue-600 rounded-2xl border border-blue-100">
                        <i class="fa-solid fa-cart-shopping text-lg"></i>
                    </div>
                    <span class="text-[10px] font-bold text-blue-600 bg-blue-50 border border-blue-100 px-2 py-1 rounded-xl uppercase tracking-wider">Orders</span>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Total Orders</p>
                    <h3 class="text-2xl font-black text-slate-900 mt-0.5">${totalOrders}</h3>
                </div>
            </div>

            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80 space-y-3">
                <div class="flex items-center justify-between">
                    <div class="p-3 bg-amber-50 text-amber-600 rounded-2xl border border-amber-100">
                        <i class="fa-solid fa-box text-lg"></i>
                    </div>
                    <span class="text-[10px] font-bold text-amber-600 bg-amber-50 border border-amber-100 px-2 py-1 rounded-xl uppercase tracking-wider">Catalog</span>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Total Products</p>
                    <h3 class="text-2xl font-black text-slate-900 mt-0.5">${totalProducts}</h3>
                </div>
            </div>

            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80 space-y-3">
                <div class="flex items-center justify-between">
                    <div class="p-3 bg-purple-50 text-purple-600 rounded-2xl border border-purple-100">
                        <i class="fa-solid fa-users text-lg"></i>
                    </div>
                    <span class="text-[10px] font-bold text-purple-600 bg-purple-50 border border-purple-100 px-2 py-1 rounded-xl uppercase tracking-wider">Users</span>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Active Users</p>
                    <h3 class="text-2xl font-black text-slate-900 mt-0.5">${totalUsers}</h3>
                </div>
            </div>
        </div>

        <%-- ── ORDER FULFILLMENT STATUS ────────────────────────────────── --%>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div class="bg-white p-4 rounded-2xl border border-slate-200/80 flex items-center gap-4 shadow-sm">
                <div class="p-3 bg-amber-50 text-amber-600 rounded-2xl border border-amber-100 shrink-0">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Pending</p>
                    <p class="text-xl font-black text-slate-900">${pendingOrders}</p>
                </div>
            </div>
            <div class="bg-white p-4 rounded-2xl border border-slate-200/80 flex items-center gap-4 shadow-sm">
                <div class="p-3 bg-blue-50 text-blue-600 rounded-2xl border border-blue-100 shrink-0">
                    <i class="fa-solid fa-gears"></i>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Processing</p>
                    <p class="text-xl font-black text-slate-900">${processingOrders}</p>
                </div>
            </div>
            <div class="bg-white p-4 rounded-2xl border border-slate-200/80 flex items-center gap-4 shadow-sm">
                <div class="p-3 bg-emerald-50 text-emerald-600 rounded-2xl border border-emerald-100 shrink-0">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Delivered</p>
                    <p class="text-xl font-black text-slate-900">${deliveredOrders}</p>
                </div>
            </div>
            <div class="bg-white p-4 rounded-2xl border border-slate-200/80 flex items-center gap-4 shadow-sm">
                <div class="p-3 bg-red-50 text-red-600 rounded-2xl border border-red-100 shrink-0">
                    <i class="fa-solid fa-ban"></i>
                </div>
                <div>
                    <p class="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Cancelled</p>
                    <p class="text-xl font-black text-slate-900">${cancelledOrders}</p>
                </div>
            </div>
        </div>

        <%-- ── CHARTS ROW ───────────────────────────────────────────────── --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

            <%-- Revenue Trend (12 months) - 2/3 width --%>
            <div class="lg:col-span-2 bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-extrabold text-slate-900">Revenue Trend</h4>
                        <p class="text-[10px] text-slate-400 font-medium mt-0.5">Last 12 months</p>
                    </div>
                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl bg-blue-50 text-blue-600 text-[10px] font-bold border border-blue-100">
                        <i class="fa-solid fa-chart-line text-xs"></i> Line Chart
                    </span>
                </div>
                <canvas id="revenueChart" height="100"></canvas>
            </div>

            <%-- Order Status Doughnut -  1/3 width --%>
            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-extrabold text-slate-900">Order Breakdown</h4>
                        <p class="text-[10px] text-slate-400 font-medium mt-0.5">By status</p>
                    </div>
                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl bg-amber-50 text-amber-600 text-[10px] font-bold border border-amber-100">
                        <i class="fa-solid fa-chart-pie text-xs"></i> Doughnut
                    </span>
                </div>
                <canvas id="statusChart"></canvas>
            </div>
        </div>

        <%-- ── SECOND CHARTS ROW ───────────────────────────────────────── --%>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

            <%-- Top Selling Products --%>
            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-extrabold text-slate-900">Top Selling Products</h4>
                        <p class="text-[10px] text-slate-400 font-medium mt-0.5">By units sold</p>
                    </div>
                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl bg-purple-50 text-purple-600 text-[10px] font-bold border border-purple-100">
                        <i class="fa-solid fa-trophy text-xs"></i> Top 5
                    </span>
                </div>
                <canvas id="topProductsChart" height="160"></canvas>
            </div>

            <%-- Sales by Category --%>
            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-200/80">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h4 class="text-sm font-extrabold text-slate-900">Sales by Category</h4>
                        <p class="text-[10px] text-slate-400 font-medium mt-0.5">By units sold</p>
                    </div>
                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-xl bg-teal-50 text-teal-600 text-[10px] font-bold border border-teal-100">
                        <i class="fa-solid fa-layer-group text-xs"></i> Bar Chart
                    </span>
                </div>
                <canvas id="categoryChart" height="160"></canvas>
            </div>
        </div>

        <%-- ── LOW STOCK ALERT + RECENT ORDERS ────────────────────────── --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

            <%-- Low Stock Alert --%>
            <div class="bg-white rounded-3xl shadow-sm border border-slate-200/80 overflow-hidden">
                <div class="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
                    <h3 class="font-extrabold text-sm text-slate-900 flex items-center gap-2">
                        <i class="fa-solid fa-triangle-exclamation text-amber-500 text-xs"></i>
                        Low Stock Alert
                    </h3>
                    <a href="${pageContext.request.contextPath}/admin/products?status=low_stock"
                       class="text-[10px] font-bold text-brand-600 hover:underline uppercase tracking-wider">View All</a>
                </div>
                <div class="divide-y divide-slate-100">
                    <c:forEach var="p" items="${lowStockProducts}">
                        <div class="px-6 py-4 flex items-center justify-between">
                            <div>
                                <p class="text-xs font-extrabold text-slate-900 leading-tight">${p.name}</p>
                                <p class="text-[10px] text-slate-400 font-mono mt-0.5">${p.stockKeepingUnit}</p>
                            </div>
                            <span class="text-[10px] font-bold px-2.5 py-1 rounded-xl
                                ${p.stock == 0 ? 'bg-red-50 text-red-600 border border-red-100' : 'bg-amber-50 text-amber-600 border border-amber-100'}">
                                ${p.stock} left
                            </span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty lowStockProducts}">
                        <div class="px-6 py-10 text-center">
                            <i class="fa-solid fa-circle-check text-emerald-400 text-2xl mb-2 block"></i>
                            <p class="text-xs text-slate-400 font-medium">All products are well stocked</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <%-- Recent Orders --%>
            <div class="lg:col-span-2 bg-white rounded-3xl shadow-sm border border-slate-200/80 overflow-hidden">
                <div class="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
                    <h3 class="font-extrabold text-sm text-slate-900 uppercase tracking-wide">Recent Orders</h3>
                    <a href="${pageContext.request.contextPath}/admin/orders"
                       class="text-[10px] font-bold text-brand-600 hover:underline uppercase tracking-wider">View All</a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-[10px] uppercase font-extrabold text-slate-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">Order</th>
                                <th class="px-6 py-4">Customer</th>
                                <th class="px-6 py-4">Amount</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4">Date</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 text-xs font-medium">
                            <c:forEach var="order" items="${recentOrders}">
                                <tr class="hover:bg-slate-50/70 transition-colors">
                                    <td class="px-6 py-4 font-extrabold text-slate-900">#${order.id}</td>
                                    <td class="px-6 py-4 text-slate-600">${order.userFullName}</td>
                                    <td class="px-6 py-4 font-extrabold text-slate-900">
                                        Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="px-2.5 py-1 text-[10px] font-bold rounded-xl uppercase
                                            ${order.orderStatus eq 'Delivered'  ? 'bg-emerald-50 text-emerald-600 border border-emerald-100'  :
                                              order.orderStatus eq 'Cancelled'  ? 'bg-red-50 text-red-600 border border-red-100'   :
                                              order.orderStatus eq 'Processing' ? 'bg-blue-50 text-blue-600 border border-blue-100'     :
                                                                                  'bg-amber-50 text-amber-600 border border-amber-100'}">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-slate-400">
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

<!-- chart js  -->
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
                backgroundColor: [palette.yellow, palette.blue, palette.teal, palette.green, palette.red, palette.purple],
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