<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="NEO-HUB | Products" />
    <jsp:param name="metaDescription" value="Browse IoT components, kits and modules at NEO-HUB." />
    <jsp:param name="metaKeywords" value="IoT, Arduino, sensors, electronics, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-secondary">

<jsp:include page="/WEB-INF/templates/user/header.jsp">
    <jsp:param name="activePage" value="products" />
</jsp:include>

<main class="w-[90vw] mx-auto py-10 pb-28">

    <!-- <div class="mb-6">
        <p class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1">Browse</p>
        <h1 class="text-2xl md:text-3xl font-bold text-accent">Products</h1>

        <c:if test="${categoryId > 0 || not empty keyword}">
            <div class="flex items-center gap-2 mt-2 flex-wrap">
                <span class="text-sm text-gray-500">Showing:</span>
                <c:if test="${categoryId > 0}">
                    <c:forEach var="cat" items="${categories}">
                        <c:if test="${cat.id == categoryId}">
                            <span class="inline-flex items-center gap-1 bg-accent/10 text-accent text-xs font-semibold px-3 py-1 rounded-full">
                                <i class="fa-solid fa-layer-group text-xs"></i>
                                <c:out value="${cat.name}"/>
                            </span>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${not empty keyword}">
                    <span class="inline-flex items-center gap-1 bg-accent/10 text-accent text-xs font-semibold px-3 py-1 rounded-full">
                        <i class="fa-solid fa-magnifying-glass text-xs"></i>
                        "<c:out value="${keyword}"/>"
                    </span>
                </c:if>
                <a href="${pageContext.request.contextPath}/products"
                   class="text-xs text-gray-400 hover:text-red-500 transition underline">Clear</a>
            </div>
        </c:if>
    </div> -->

    <div class="flex flex-col lg:flex-row gap-8">

        
        <aside class="w-full lg:w-60">
            <div class="bg-primary border border-gray-200 rounded-2xl p-5">

                <h3 class="text-sm font-bold text-accent mb-4">Filters</h3>

                <%--
                    FIX: All HTMX calls add partial=true param so servlet
                    knows to return only the grid, not full page.
                    hx-push-url="false" on auto-triggers (keyup, change) stops
                    browser tab from showing "loading..." on every keystroke.
                    Only Apply button uses hx-push-url="true" to update URL.
                --%>
                <form id="filterForm"
                      action="${pageContext.request.contextPath}/products"
                      method="get">

                    <input type="hidden" name="page" value="1">

                    <!-- Search — auto triggers partial load, no URL push -->
                    <div class="mb-4">
                        <label class="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2 block">Search</label>
                        <input
                            type="text"
                            name="keyword"
                            id="searchInput"
                            value="<c:out value='${keyword}'/>"
                            placeholder="Search products..."
                            class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm focus:outline-none focus:border-accent"
                            hx-get="${pageContext.request.contextPath}/products"
                            hx-trigger="keyup changed delay:500ms"
                            hx-target="#product-section"
                            hx-swap="innerHTML"
                            hx-include="#filterForm"
                            hx-vals='{"partial":"true"}'
                            hx-push-url="false"
                        />
                    </div>


                    <!-- category filter  -->
                    <div class="mb-4">
                        <label class="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2 block">Category</label>
                        <div class="flex flex-col gap-2 max-h-48 overflow-y-auto pr-1">
                            <label class="flex items-center gap-2 cursor-pointer">
                                <input type="radio" name="categoryId" value="0"
                                       ${categoryId == 0 ? 'checked' : ''}
                                       hx-get="${pageContext.request.contextPath}/products"
                                       hx-trigger="change"
                                       hx-target="#product-section"
                                       hx-swap="innerHTML"
                                       hx-include="#filterForm"
                                       hx-vals='{"partial":"true"}'
                                       hx-push-url="false">
                                <span class="text-sm text-gray-600">All Categories</span>
                            </label>

                            <c:forEach var="cat" items="${categories}">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="radio" name="categoryId" value="${cat.id}"
                                           ${categoryId == cat.id ? 'checked' : ''}
                                           hx-get="${pageContext.request.contextPath}/products"
                                           hx-trigger="change"
                                           hx-target="#product-section"
                                           hx-swap="innerHTML"
                                           hx-include="#filterForm"
                                           hx-vals='{"partial":"true"}'
                                           hx-push-url="false">
                                    <span class="text-sm text-gray-600"><c:out value="${cat.name}"/></span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- price range filter -->
                    <div class="mb-4">
                        <label class="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2 block">Price (Rs.)</label>
                        <div class="flex gap-2 items-center">
                            <input type="number" name="minPrice" value="${minPrice}"
                                   placeholder="Min" min="0"
                                   class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm focus:outline-none focus:border-accent">
                            <span class="text-gray-400 text-xs">–</span>
                            <input type="number" name="maxPrice" value="${maxPrice}"
                                   placeholder="Max" min="0"
                                   class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm focus:outline-none focus:border-accent">
                        </div>
                    </div>

                    <!-- sort  -->
                    <div class="mb-5">
                        <label class="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2 block">Sort By</label>
                        <select name="sortBy"
                                class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm focus:outline-none focus:border-accent"
                                hx-get="${pageContext.request.contextPath}/products"
                                hx-trigger="change"
                                hx-target="#product-section"
                                hx-swap="innerHTML"
                                hx-include="#filterForm"
                                hx-vals='{"partial":"true"}'
                                hx-push-url="false">

                            <option value="newest" ${sortBy eq 'newest' || empty sortBy ? 'selected' : ''}>Newest First</option>
                            <option value="price_asc" ${sortBy eq 'price_asc'  ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_desc" ${sortBy eq 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                            <option value="name_asc"   ${sortBy eq 'name_asc'   ? 'selected' : ''}>Name A–Z</option>
                        </select>
                    </div>

                    <!-- submit button which reloads whole page -->
                    <button type="submit"
                            class="w-full bg-accent text-white text-sm font-semibold py-2.5 rounded-xl hover:opacity-90 transition">
                        Apply Filters
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/products"
                   class="mt-3 w-full block text-center text-sm text-gray-400 hover:text-red-500 py-2 border border-gray-200 rounded-xl transition">
                    Clear All
                </a>
            </div>
        </aside>


        <!-- product grid  -->
        <div class="flex-1 min-w-0">
            <div id="product-section">
                <jsp:include page="/WEB-INF/views/user/components/product-grid.jsp" />
            </div>
        </div>

    </div>
</main>

<!-- Sticky Cart Bar — hidden until item added -->
<!-- <div id="cartBar"
     class="fixed bottom-0 left-0 right-0 bg-primary border-t border-gray-200 shadow-lg z-50 px-4 py-3"
     style="display:none">
    <div class="max-w-5xl mx-auto flex items-center justify-between gap-4">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-xl bg-accent flex items-center justify-center flex-shrink-0">
                <i class="fa-solid fa-cart-shopping text-white text-sm"></i>
            </div>
            <div>
                <p class="text-xs text-gray-500">Items added this session</p>
                <p class="text-sm font-bold text-accent" id="cartSummaryText">0 items</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/cart"
           class="bg-accent text-white text-sm font-semibold px-6 py-2.5 rounded-xl hover:opacity-90 transition whitespace-nowrap">
            View Cart &amp; Checkout <i class="fa-solid fa-arrow-right ml-1 text-xs"></i>
        </a>
    </div>
</div> -->

<jsp:include page="/WEB-INF/templates/user/footer.jsp" />

<script>
var cartItemCount = 0;

function onCartAdded(event) {
    if (event.detail.successful) {
        cartItemCount++;
        document.getElementById('cartBar').style.display = 'block';
        document.getElementById('cartSummaryText').textContent =
            cartItemCount + ' item' + (cartItemCount !== 1 ? 's' : '') + ' added';
        showToast('Added to cart!', 'success');
    } else {
        showToast('Could not add to cart. Please try again.', 'error');
    }
}

<c:if test="${not empty error}">
    showToast("<c:out value='${error}'/>", "error");
</c:if>
<c:if test="${not empty success}">
    showToast("<c:out value='${success}'/>", "success");
</c:if>
</script>

</body>
</html>
