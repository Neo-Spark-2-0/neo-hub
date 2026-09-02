<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="NEO-HUB | Electronic Components &amp; IoT Products" />
    <jsp:param name="metaDescription" value="Browse sensors, microcontrollers, IoT development kits, and accessories at NEO-HUB Nepal." />
    <jsp:param name="metaKeywords" value="IoT, Arduino, ESP32, sensors, robotics, electronics, Nepal, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">

<jsp:include page="/WEB-INF/templates/user/header.jsp">
    <jsp:param name="activePage" value="products" />
</jsp:include>

<main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-6">

    <!-- Breadcrumb & Header -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
        <div>
            <div class="flex items-center gap-2 text-xs font-semibold text-slate-500 mb-1">
                <a href="${pageContext.request.contextPath}/" class="hover:text-slate-900 transition">Home</a>
                <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                <span class="text-slate-900 font-bold">Catalog</span>
            </div>
            <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
                IoT &amp; Electronics Catalog
            </h1>
        </div>
        <div class="flex items-center gap-2">
            <span class="text-xs font-semibold text-slate-500">Live inventory from Kathmandu warehouse</span>
        </div>
    </div>

    <div class="flex flex-col lg:flex-row gap-8 items-start">

        <!-- Filter Sidebar -->
        <aside class="w-full lg:w-72 flex-shrink-0 lg:sticky lg:top-20">
            <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-sm space-y-6">

                <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                    <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
                        <i class="fa-solid fa-sliders text-brand-600"></i>
                        Filter Products
                    </h3>
                    <a href="${pageContext.request.contextPath}/products"
                       class="text-[11px] font-bold text-slate-400 hover:text-danger transition">
                        Reset All
                    </a>
                </div>

                <form id="filterForm"
                      action="${pageContext.request.contextPath}/products"
                      method="get"
                      class="space-y-5">

                    <input type="hidden" name="page" value="1">

                    <!-- Search Input -->
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase tracking-wider mb-2 block">
                            Search Keywords
                        </label>
                        <div class="relative">
                            <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                            <input
                                type="text"
                                name="keyword"
                                id="searchInput"
                                value="<c:out value='${keyword}'/>"
                                placeholder="e.g. Arduino, DHT22..."
                                class="w-full bg-slate-50 border border-slate-200 rounded-xl pl-9 pr-3 py-2.5 text-xs font-medium text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition"
                                hx-get="${pageContext.request.contextPath}/products"
                                hx-trigger="keyup changed delay:400ms"
                                hx-target="#product-section"
                                hx-swap="innerHTML"
                                hx-include="#filterForm"
                                hx-vals='{"partial":"true"}'
                            />
                        </div>
                    </div>

                    <!-- Category Filter -->
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase tracking-wider mb-2 block">
                            Categories
                        </label>

                        <div class="flex flex-col gap-1.5 max-h-52 overflow-y-auto pr-1">
                            <label class="flex items-center gap-2.5 px-2.5 py-1.5 rounded-xl hover:bg-slate-50 cursor-pointer transition text-xs font-medium text-slate-700">
                                <input type="radio" name="categoryId" value="0"
                                       ${categoryId == 0 ? 'checked' : ''}
                                       class="text-brand-600 focus:ring-brand-500 rounded"
                                       hx-get="${pageContext.request.contextPath}/products"
                                       hx-trigger="change"
                                       hx-target="#product-section"
                                       hx-swap="innerHTML"
                                       hx-include="#filterForm"
                                       hx-vals='{"partial":"true"}'>
                                <span>All Categories</span>
                            </label>

                            <c:forEach var="cat" items="${categories}">
                                <label class="flex items-center gap-2.5 px-2.5 py-1.5 rounded-xl hover:bg-slate-50 cursor-pointer transition text-xs font-medium text-slate-700">
                                    <input type="radio" name="categoryId" value="${cat.id}"
                                           ${categoryId == cat.id ? 'checked' : ''}
                                           class="text-brand-600 focus:ring-brand-500 rounded"
                                           hx-get="${pageContext.request.contextPath}/products"
                                           hx-trigger="change"
                                           hx-target="#product-section"
                                           hx-swap="innerHTML"
                                           hx-include="#filterForm"
                                           hx-vals='{"partial":"true"}'>
                                    <span><c:out value="${cat.name}"/></span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Price Range -->
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase tracking-wider mb-2 block">
                            Price (NPR)
                        </label>
                        <div class="flex gap-2 items-center">
                            <input type="number" name="minPrice" value="${minPrice}"
                                   placeholder="Min" min="0"
                                   class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-xs font-medium text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition"
                                   hx-get="${pageContext.request.contextPath}/products"
                                   hx-trigger="change"
                                   hx-target="#product-section"
                                   hx-swap="innerHTML"
                                   hx-include="#filterForm"
                                   hx-vals='{"partial":"true"}'>
                            <span class="text-slate-400 text-xs font-bold">–</span>
                            <input type="number" name="maxPrice" value="${maxPrice}"
                                   placeholder="Max" min="0"
                                   class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-xs font-medium text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition"
                                   hx-get="${pageContext.request.contextPath}/products"
                                   hx-trigger="keyup changed delay:400ms"
                                   hx-target="#product-section"
                                   hx-swap="innerHTML"
                                   hx-include="#filterForm"
                                   hx-vals='{"partial":"true"}'>
                        </div>
                    </div>

                    <!-- Sort Selection -->
                    <div>
                        <label class="text-[11px] font-bold text-slate-600 uppercase tracking-wider mb-2 block">
                            Sort Order
                        </label>
                        <select name="sortBy"
                                class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3 py-2.5 text-xs font-medium text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition cursor-pointer"
                                hx-get="${pageContext.request.contextPath}/products"
                                hx-trigger="change"
                                hx-target="#product-section"
                                hx-swap="innerHTML"
                                hx-include="#filterForm"
                                hx-vals='{"partial":"true"}'>
                            <option value="newest" ${sortBy eq 'newest' || empty sortBy ? 'selected' : ''}>Newest First</option>
                            <option value="price_asc" ${sortBy eq 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_desc" ${sortBy eq 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                            <option value="name_asc" ${sortBy eq 'name_asc' ? 'selected' : ''}>Name: A to Z</option>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit"
                            class="w-full bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold py-3 rounded-2xl transition-all shadow-sm flex items-center justify-center gap-2">
                        <i class="fa-solid fa-filter text-[10px]"></i>
                        Apply Filters
                    </button>
                </form>

            </div>
        </aside>

        <!-- Product Grid Section -->
        <div class="flex-1 min-w-0">
            <div id="product-section">
                <jsp:include page="/WEB-INF/views/user/components/product-grid.jsp" />
            </div>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/templates/user/footer.jsp" />

<script>
    <c:if test="${not empty error}">
        showToast("<c:out value='${error}'/>", "error");
    </c:if>
    <c:if test="${not empty success}">
        showToast("<c:out value='${success}'/>", "success");
    </c:if>
</script>

</body>
</html>

