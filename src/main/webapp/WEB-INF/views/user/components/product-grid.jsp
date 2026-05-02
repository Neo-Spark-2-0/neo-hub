<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Results count -->
<div class="flex items-center justify-between mb-5">
    <p class="text-sm text-gray-500">
        <strong class="text-accent">${totalProducts}</strong>
        product<c:if test="${totalProducts != 1}">s</c:if> found
    </p>
    <c:if test="${totalPages > 0}">
        <p class="text-xs text-gray-400">Page ${currentPage} of ${totalPages}</p>
    </c:if>
</div>

<!-- Empty state -->
<c:if test="${empty products}">
    <div class="flex flex-col items-center justify-center py-20 text-center">
        <div class="w-16 h-16 rounded-full bg-gray-100 flex items-center justify-center mb-4">
            <i class="fa-solid fa-box-open text-2xl text-gray-300"></i>
        </div>
        <h3 class="text-base font-semibold text-accent mb-1">No products found</h3>
        <p class="text-sm text-gray-400 max-w-xs mb-5">
            Try different keywords, a different category, or clear the filters.
        </p>
        <a href="${pageContext.request.contextPath}/products"
           class="text-sm font-semibold text-white bg-accent px-6 py-2.5 rounded-xl hover:opacity-90 transition">
            Clear Filters
        </a>
    </div>
</c:if>

<!-- Product Grid -->
<c:if test="${not empty products}">
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-5">
        <c:forEach var="product" items="${products}">
            <div class="bg-primary border border-gray-200 rounded-2xl overflow-hidden hover:shadow-md hover:border-gray-300 transition-all flex flex-col group">

                <!-- Image -->
                <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                   class="block relative w-full aspect-square overflow-hidden bg-secondary flex-shrink-0">

                    <%--
                        Image fallback chain:
                        1. Try uploads path
                        2. onerror falls back to /products/product-fallback.jpg
                    --%>
                    <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                         alt="<c:out value='${product.name}'/>"
                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/products/product-fallback.jpg'">

                    <c:if test="${product.stock == 0}">
                        <span class="absolute top-3 left-3 bg-red-500 text-white text-xs font-semibold px-2.5 py-1 rounded-full">
                            Out of Stock
                        </span>
                    </c:if>

                    <!-- Low stock badge (1-5, only if in stock) -->
                    <c:if test="${product.stock > 0 && product.stock <= 5}">
                        <span class="absolute top-3 left-3 bg-yellow-500 text-white text-xs font-semibold px-2.5 py-1 rounded-full">
                            Only ${product.stock} left!
                        </span>
                    </c:if>

                    <!-- Sale badge -->
                    <c:if test="${product.discountPrice > 0}">
                        <span class="absolute top-3 right-3 bg-accent text-white text-xs font-semibold px-2.5 py-1 rounded-full">
                            SALE
                        </span>
                    </c:if>
                </a>

                <!-- Info -->
                <div class="p-4 flex flex-col gap-1 flex-1">

                    <p class="text-xs font-semibold uppercase tracking-wider text-gray-400">
                        <c:out value="${product.categoryName}"/>
                    </p>

                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">
                        <h4 class="text-sm font-semibold text-accent leading-snug line-clamp-2 hover:underline">
                            <c:out value="${product.name}"/>
                        </h4>
                    </a>

                    <!-- Price -->
                    <div class="mt-1 flex items-baseline gap-2">
                        <c:choose>
                            <c:when test="${product.discountPrice > 0}">
                                <span class="text-base font-bold text-accent">
                                    Rs. <fmt:formatNumber value="${product.discountPrice}" pattern="#,##0"/>
                                </span>
                                <span class="text-xs text-gray-400 line-through">
                                    Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-base font-bold text-accent">
                                    Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Add to Cart area — HTMX swaps this div -->
                    <div class="mt-3" id="cartArea-${product.id}">
                        <c:choose>

                            <c:when test="${product.stock == 0}">
                                <button disabled
                                        class="w-full bg-gray-100 text-gray-400 text-xs font-semibold py-2.5 rounded-xl cursor-not-allowed">
                                    Out of Stock
                                </button>
                            </c:when>

            
                            <c:when test="${not empty sessionScope.user}">
                                <button
                                    hx-post="${pageContext.request.contextPath}/cart"
                                    hx-vals='{"action":"add","productId":"${product.id}","quantity":"1"}'
                                    hx-target="#cartArea-${product.id}"
                                    hx-swap="innerHTML"
                                    hx-on::after-request="onCartAdded(event)"
                                    class="w-full bg-accent text-white text-xs font-semibold py-2.5 rounded-xl hover:opacity-90 transition active:scale-95">
                                    <i class="fa-solid fa-cart-plus mr-1"></i> Add to Cart
                                </button>
                            </c:when>

                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login"
                                   class="block w-full text-center bg-accent text-white text-xs font-semibold py-2.5 rounded-xl hover:opacity-90 transition">
                                    <i class="fa-solid fa-cart-plus mr-1"></i> Login to Buy
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="flex items-center justify-center gap-2 mt-10 flex-wrap">

            <!-- Prev -->
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/products?page=${currentPage - 1}&keyword=${keyword}&categoryId=${categoryId}&sortBy=${sortBy}&minPrice=${minPrice}&maxPrice=${maxPrice}"
                       class="px-4 py-2 rounded-xl border border-gray-200 text-sm text-gray-600 hover:border-accent hover:text-accent transition">
                        &larr; Prev
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="px-4 py-2 rounded-xl border border-gray-100 text-sm text-gray-300 cursor-not-allowed">
                        &larr; Prev
                    </span>
                </c:otherwise>
            </c:choose>

            <!-- Page numbers — max 5 around current -->
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="px-4 py-2 rounded-xl bg-accent text-white text-sm font-semibold">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/products?page=${i}&keyword=${keyword}&categoryId=${categoryId}&sortBy=${sortBy}&minPrice=${minPrice}&maxPrice=${maxPrice}"
                               class="px-4 py-2 rounded-xl border border-gray-200 text-sm text-gray-600 hover:border-accent hover:text-accent transition">
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>

            <!-- Next -->
            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/products?page=${currentPage + 1}&keyword=${keyword}&categoryId=${categoryId}&sortBy=${sortBy}&minPrice=${minPrice}&maxPrice=${maxPrice}"
                       class="px-4 py-2 rounded-xl border border-gray-200 text-sm text-gray-600 hover:border-accent hover:text-accent transition">
                        Next &rarr;
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="px-4 py-2 rounded-xl border border-gray-100 text-sm text-gray-300 cursor-not-allowed">
                        Next &rarr;
                    </span>
                </c:otherwise>
            </c:choose>

        </div>
        <p class="text-center text-xs text-gray-400 mt-3">
            Page ${currentPage} of ${totalPages}
        </p>
    </c:if>

</c:if>
