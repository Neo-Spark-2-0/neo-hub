<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="My Orders | NEO-HUB" />
    <jsp:param name="metaDescription" value="Track and review your previous orders and purchases on NEO-HUB." />
    <jsp:param name="metaKeywords" value="orders, history, tracking, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-8 min-h-[60vh]">
        
        <!-- Header & Breadcrumb -->
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
            <div>
                <div class="flex items-center gap-2 text-xs font-semibold text-slate-500 mb-1">
                    <a href="${pageContext.request.contextPath}/" class="hover:text-slate-900 transition">Home</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                    <a href="${pageContext.request.contextPath}/profile" class="hover:text-slate-900 transition">My Account</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                    <span class="text-slate-900 font-bold">Orders</span>
                </div>
                <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
                    Order History &amp; Tracking
                </h1>
            </div>
            <a href="${pageContext.request.contextPath}/products"
               class="inline-flex items-center gap-2 px-5 py-2.5 rounded-2xl bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold transition shadow-sm">
                <i class="fa-solid fa-bag-shopping text-brand-400"></i>
                <span>Shop More Items</span>
            </a>
        </div>

        <!-- Filter Bar -->
        <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card">
            <div class="flex flex-wrap items-center justify-between gap-6">
                
                <div class="flex flex-wrap items-center gap-6">
                    <!-- Status Filter -->
                    <div class="space-y-1.5">
                        <label for="status" class="block text-xs font-extrabold text-slate-400 uppercase tracking-wider">
                            Order Status
                        </label>
                        <select name="status"
                                id="status"
                                hx-get="${pageContext.request.contextPath}/order-history"
                                hx-trigger="change"
                                hx-target="#order-table"
                                hx-swap="innerHTML"
                                hx-include="#status, [name='paymentMethod']:checked"
                                class="bg-slate-50 border border-slate-200 text-xs font-bold text-slate-900 rounded-2xl px-4 py-2.5 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 cursor-pointer">
                            <option value="all">All Orders</option>
                            <option value="delivered">Delivered</option>
                            <option value="cancelled">Cancelled</option>
                            <option value="shipped">Shipped</option>
                            <option value="processing">Processing</option>
                            <option value="confirmed">Confirmed</option>
                        </select>
                    </div>

                    <!-- Payment Method Filter -->
                    <div class="space-y-1.5">
                        <span class="block text-xs font-extrabold text-slate-400 uppercase tracking-wider">
                            Payment Channel
                        </span>
                        <div class="flex flex-wrap gap-2 text-xs font-bold">
                            <label class="px-3.5 py-2 rounded-xl border border-slate-200 bg-slate-50 hover:bg-white cursor-pointer transition has-[:checked]:bg-slate-900 has-[:checked]:text-white has-[:checked]:border-slate-900">
                                <input type="radio" name="paymentMethod" value="all" checked
                                       hx-get="${pageContext.request.contextPath}/order-history"
                                       hx-trigger="change"
                                       hx-target="#order-table"
                                       hx-swap="innerHTML"
                                       hx-include="#status, [name='paymentMethod']"
                                       class="hidden" />
                                All
                            </label>
                            <label class="px-3.5 py-2 rounded-xl border border-slate-200 bg-slate-50 hover:bg-white cursor-pointer transition flex items-center gap-1.5 has-[:checked]:bg-purple-900 has-[:checked]:text-white has-[:checked]:border-purple-900">
                                <input type="radio" name="paymentMethod" value="Khalti"
                                       hx-get="${pageContext.request.contextPath}/order-history"
                                       hx-trigger="change"
                                       hx-target="#order-table"
                                       hx-swap="innerHTML"
                                       hx-include="#status, [name='paymentMethod']"
                                       class="hidden" />
                                <i class="fa-solid fa-wallet text-purple-600"></i>
                                Khalti
                            </label>
                            <label class="px-3.5 py-2 rounded-xl border border-slate-200 bg-slate-50 hover:bg-white cursor-pointer transition flex items-center gap-1.5 has-[:checked]:bg-slate-900 has-[:checked]:text-white has-[:checked]:border-slate-900">
                                <input type="radio" name="paymentMethod" value="CashOnDelivery"
                                       hx-get="${pageContext.request.contextPath}/order-history"
                                       hx-trigger="change"
                                       hx-target="#order-table"
                                       hx-swap="innerHTML"
                                       hx-include="#status, [name='paymentMethod']"
                                       class="hidden" />
                                <i class="fa-solid fa-hand-holding-dollar text-emerald-600"></i>
                                COD
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Reset Button -->
                <a href="${pageContext.request.contextPath}/order-history"
                   class="inline-flex items-center gap-1.5 text-xs font-bold text-slate-500 hover:text-slate-900 border border-slate-200 bg-slate-50 hover:bg-white px-4 py-2.5 rounded-2xl transition shadow-subtle">
                    <i class="fa-solid fa-rotate-right text-[10px]"></i> Reset Filters
                </a>
            </div>
        </div>

        <!-- Orders Table / Empty State Container -->
        <div id="order-table">
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="bg-white rounded-3xl border border-slate-200/80 p-12 sm:p-16 text-center max-w-lg mx-auto shadow-card space-y-4">
                        <div class="w-20 h-20 rounded-3xl bg-slate-100 text-slate-400 flex items-center justify-center mx-auto text-3xl">
                            <i class="fa-solid fa-receipt"></i>
                        </div>
                        <div class="space-y-1">
                            <h2 class="text-xl font-extrabold text-slate-900">No Orders Found</h2>
                            <p class="text-xs sm:text-sm text-slate-500 font-medium">You have not placed any orders matching the current filter criteria.</p>
                        </div>
                        <div class="pt-2">
                            <a href="${pageContext.request.contextPath}/products"
                               class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white text-xs sm:text-sm font-bold px-8 py-3.5 rounded-2xl transition shadow-md">
                                <i class="fa-solid fa-layer-group text-brand-400"></i>
                                Browse Products
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="bg-white rounded-3xl border border-slate-200/80 overflow-hidden shadow-card">
                        <div class="overflow-x-auto">
                            <jsp:include page="/WEB-INF/views/user/components/order-history-list.jsp" />
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>

