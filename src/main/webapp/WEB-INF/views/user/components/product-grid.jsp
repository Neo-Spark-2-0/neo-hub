<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- page and product details top -->
<div class="flex items-center justify-between mb-5">
    <p class="text-sm text-gray-500">
        <strong class="text-accent">${totalProducts}</strong>
        product<c:if test="${totalProducts != 1}">s</c:if> found
    </p>
    <c:if test="${totalPages > 0}">
        <p class="text-xs text-gray-400">Page ${currentPage} of ${totalPages}</p>
    </c:if>
</div>

<!-- when no products are found -->
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

<!-- products -->
<c:if test="${not empty products}">
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-5">
    <c:forEach var="product" items="${products}">
            <div class="bg-primary border border-gray-200 rounded-2xl overflow-hidden hover:shadow-md hover:border-gray-300 transition-all flex flex-col group">

               <!-- image  -->
            <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                   class="block relative w-full aspect-square overflow-hidden bg-secondary">


                <c:choose>
                    <c:when test="${not empty product.image}">
                        <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                            alt="<c:out value='${product.name}'/>"
                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                            alt="No image available"
                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
                    </c:otherwise>
                </c:choose>


                    
            <c:if test="${product.stock == 0}">
            <span class="absolute top-3 left-3 bg-red-600 text-white text-xs font-semibold px-2.5 py-1 rounded-full">
                Out of Stock
            </span>
            </c:if>

                    <!-- low stock badge -->
                <c:if test="${product.stock > 0 && product.stock <= 5}">
                    <span class="absolute top-3 left-3 bg-yellow-500 text-white text-xs font-semibold px-2.5 py-1 rounded-full">
                            Only ${product.stock} left!
                    </span>
                </c:if>

                <!-- sale  -->
                <c:if test="${product.discountPrice > 0}">
                        <span class="absolute top-3 right-3 bg-accent text-white text-xs font-semibold px-2.5 py-1 rounded-full">
                            SALE
                        </span>
                </c:if>
            </a>

                <!-- other information -->
                <div class="p-4 flex flex-col gap-1 flex-1">

                    <p class="text-xs font-semibold uppercase tracking-wider text-gray-400">
                        <c:out value="${product.categoryName}"/>
                    </p>

                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">
                        <h4 class="text-sm font-semibold text-accent hover:underline">
                            <c:out value="${product.name}"/>
                        </h4>
                    </a>

                    <!-- pricing -->
                    <div class="mt-1 flex gap-2">
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

                    <!-- add to cart  -->
                    <div class="mt-3" id="cartArea-${product.id}">
                        <c:set var="cartQty" value="${cartMap[product.id]}" />
                        <c:choose>
                            <%-- items already added to cart --%>
                            <c:when test="${not empty sessionScope.user && cartQty != null && cartQty > 0}">
                                <div class="flex items-center justify-between gap-1 border border-accent rounded-xl px-2 py-1">
                                    <button 
                                        hx-post="${pageContext.request.contextPath}/cart"
                                        hx-vals='{"action":"update","productId":"${product.id}","quantity":"${cartQty - 1}"}'
                                        hx-target="#cartArea-${product.id}"
                                        hx-swap="innerHTML"
                                        class="w-7 h-7 rounded-lg bg-gray-100 text-accent font-bold text-base hover:bg-gray-200 transition flex items-center justify-center">
                                        −
                                    </button>
                                    <span class="text-xs font-bold text-accent px-1">${cartQty} in cart</span>
                                    <button 
                                        hx-post="${pageContext.request.contextPath}/cart"
                                        hx-vals='{"action":"update","productId":"${product.id}","quantity":"${cartQty + 1}"}'
                                        hx-target="#cartArea-${product.id}"
                                        hx-swap="innerHTML"
                                        ${cartQty >= product.stock ? 'disabled' : ''}
                                        class="w-7 h-7 rounded-lg bg-accent text-white font-bold text-base hover:opacity-90 transition flex items-center justify-center${cartQty >= product.stock ? ' opacity-40 cursor-not-allowed' : ''}">
                                        +
                                    </button>
                                </div>
                            </c:when>

                            <%-- item not in cart --%>
                            <c:when test="${product.stock > 0}">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <button 
                                            hx-post="${pageContext.request.contextPath}/cart"
                                            hx-vals='{"action":"add","productId":"${product.id}","quantity":"1"}'
                                            hx-target="#cartArea-${product.id}"
                                            hx-swap="innerHTML"
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
                            </c:when>

                            <%-- no stock --%>
                            <c:otherwise>
                                <button disabled 
                                        class="w-full bg-gray-100 text-gray-400 text-xs font-semibold py-2.5 rounded-xl cursor-not-allowed">
                                    Out of Stock
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </c:forEach>
    </div>

    <!-- pagination -->
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
