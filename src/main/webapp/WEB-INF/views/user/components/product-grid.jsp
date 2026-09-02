<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Results Header -->
<div class="flex items-center justify-between mb-6 bg-white p-4 rounded-2xl border border-slate-200/80 shadow-subtle">
    <div class="flex items-center gap-2">
        <span class="w-2 h-2 rounded-full bg-brand-500"></span>
        <p class="text-xs font-bold text-slate-700">
            Showing <strong class="text-slate-900 font-extrabold">${totalProducts}</strong> item<c:if test="${totalProducts != 1}">s</c:if>
        </p>
    </div>
    <c:if test="${totalPages > 0}">
        <span class="text-[11px] font-bold text-slate-400 bg-slate-100 px-3 py-1 rounded-full">
            Page ${currentPage} of ${totalPages}
        </span>
    </c:if>
</div>

<!-- Empty State -->
<c:if test="${empty products}">
    <div class="flex flex-col items-center justify-center py-20 px-4 text-center bg-white rounded-3xl border border-slate-200 shadow-subtle">
        <div class="w-16 h-16 rounded-2xl bg-slate-100 text-slate-400 flex items-center justify-center mb-4 text-2xl">
            <i class="fa-solid fa-box-open"></i>
        </div>
        <h3 class="text-base font-extrabold text-slate-900 mb-1">No products found</h3>
        <p class="text-xs text-slate-500 max-w-sm mb-6 font-medium">
            We couldn't find any electronics or components matching your filters. Try adjusting your search query or price range.
        </p>
        <a href="${pageContext.request.contextPath}/products"
           class="text-xs font-bold text-white bg-slate-900 px-6 py-2.5 rounded-xl hover:bg-slate-800 transition shadow-sm">
            Clear Filters &amp; Browse All
        </a>
    </div>
</c:if>

<!-- Product Cards Grid -->
<c:if test="${not empty products}">
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6">
        <c:forEach var="product" items="${products}">
            <div class="glass-card rounded-3xl overflow-hidden hover-lift border border-slate-200/80 bg-white flex flex-col group justify-between">

                <!-- Product Image & Badges -->
                <div>
                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                       class="block relative w-full aspect-square overflow-hidden bg-slate-100">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                                     alt="<c:out value='${product.name}'/>"
                                     class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                                     alt="No image available"
                                     class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                            </c:otherwise>
                        </c:choose>

                        <!-- Badges -->
                        <div class="absolute top-3 left-3 flex flex-col gap-1.5 z-10">
                            <c:if test="${product.stock == 0}">
                                <span class="bg-slate-900/90 backdrop-blur-sm text-white text-[10px] font-bold px-2.5 py-1 rounded-xl shadow-sm">
                                    Out of Stock
                                </span>
                            </c:if>
                            <c:if test="${product.stock > 0 && product.stock <= 5}">
                                <span class="bg-amber-500 text-white text-[10px] font-bold px-2.5 py-1 rounded-xl shadow-sm">
                                    Only ${product.stock} Left!
                                </span>
                            </c:if>
                        </div>

                        <c:if test="${product.discountPrice > 0}">
                            <span class="absolute top-3 right-3 bg-danger text-white text-[10px] font-black px-2.5 py-1 rounded-xl shadow-sm tracking-wider uppercase z-10">
                                SALE
                            </span>
                        </c:if>
                    </a>

                    <!-- Information & Meta -->
                    <div class="p-5 pb-0 flex flex-col gap-1.5">
                        <p class="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                            <c:out value="${product.categoryName}"/>
                        </p>

                        <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}" class="block group">
                            <h4 class="text-sm font-bold text-slate-900 group-hover:text-brand-600 transition-colors line-clamp-2">
                                <c:out value="${product.name}"/>
                            </h4>
                        </a>

                        <!-- Pricing -->
                        <div class="mt-2 flex items-center gap-2">
                            <c:choose>
                                <c:when test="${product.discountPrice > 0}">
                                    <span class="text-base font-extrabold text-slate-900">
                                        Rs. <fmt:formatNumber value="${product.discountPrice}" pattern="#,##0"/>
                                    </span>
                                    <span class="text-xs text-slate-400 line-through font-medium">
                                        Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-base font-extrabold text-slate-900">
                                        Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Add to Cart Action Area -->
                <div class="p-5 pt-4" id="cartArea-${product.id}">
                    <c:set var="cartQty" value="${cartMap[product.id]}" />
                    <c:choose>
                        <%-- Item in cart: Stepper control --%>
                        <c:when test="${not empty sessionScope.user && cartQty != null && cartQty > 0}">
                            <div class="flex items-center justify-between gap-1 border border-slate-900 rounded-2xl p-1 bg-slate-50">
                                <button 
                                    hx-post="${pageContext.request.contextPath}/cart"
                                    hx-vals='{"action":"update","productId":"${product.id}","quantity":"${cartQty - 1}"}'
                                    hx-target="#cartArea-${product.id}"
                                    hx-swap="innerHTML"
                                    class="w-8 h-8 rounded-xl bg-white text-slate-900 font-extrabold text-sm hover:bg-slate-200 transition flex items-center justify-center shadow-subtle"
                                    aria-label="Decrease quantity">
                                    <i class="fa-solid fa-minus text-[10px]"></i>
                                </button>
                                <span class="text-xs font-bold text-slate-900 px-2">${cartQty} in cart</span>
                                <button 
                                    hx-post="${pageContext.request.contextPath}/cart"
                                    hx-vals='{"action":"update","productId":"${product.id}","quantity":"${cartQty + 1}"}'
                                    hx-target="#cartArea-${product.id}"
                                    hx-swap="innerHTML"
                                    ${cartQty >= product.stock ? 'disabled' : ''}
                                    class="w-8 h-8 rounded-xl bg-slate-900 text-white font-extrabold text-sm hover:bg-slate-800 transition flex items-center justify-center shadow-subtle ${cartQty >= product.stock ? 'opacity-40 cursor-not-allowed' : ''}"
                                    aria-label="Increase quantity">
                                    <i class="fa-solid fa-plus text-[10px]"></i>
                                </button>
                            </div>
                        </c:when>

                        <%-- In stock: Add to Cart button --%>
                        <c:when test="${product.stock > 0}">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <button 
                                        hx-post="${pageContext.request.contextPath}/cart"
                                        hx-vals='{"action":"add","productId":"${product.id}","quantity":"1"}'
                                        hx-target="#cartArea-${product.id}"
                                        hx-swap="innerHTML"
                                        class="w-full bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold py-2.5 rounded-2xl transition-all shadow-sm flex items-center justify-center gap-2 active:scale-95">
                                        <i class="fa-solid fa-cart-plus text-xs text-brand-400"></i>
                                        Add to Cart
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login" 
                                       class="block w-full text-center bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold py-2.5 rounded-2xl transition-all shadow-sm">
                                        <i class="fa-solid fa-arrow-right-to-bracket text-xs mr-1 text-brand-400"></i>
                                        Login to Buy
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>

                        <%-- Out of stock --%>
                        <c:otherwise>
                            <button disabled 
                                    class="w-full bg-slate-100 text-slate-400 text-xs font-bold py-2.5 rounded-2xl cursor-not-allowed">
                                Out of Stock
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </c:forEach>
    </div>

    <!-- Pagination Controls -->
    <c:if test="${totalPages > 1}">
        <div class="flex items-center justify-center gap-2 mt-12 flex-wrap">

            <!-- Prev -->
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/products?page=${currentPage - 1}&keyword=${keyword}&categoryId=${categoryId}&sortBy=${sortBy}&minPrice=${minPrice}&maxPrice=${maxPrice}"
                       class="px-4 py-2 rounded-xl border border-slate-200 bg-white text-xs font-bold text-slate-700 hover:bg-slate-900 hover:text-white transition shadow-subtle">
                        &larr; Prev
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="px-4 py-2 rounded-xl border border-slate-100 bg-slate-50 text-xs font-bold text-slate-300 cursor-not-allowed">
                        &larr; Prev
                    </span>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="px-4 py-2 rounded-xl bg-slate-900 text-white text-xs font-black shadow-sm">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/products?page=${i}&keyword=${keyword}&categoryId=${categoryId}&sortBy=${sortBy}&minPrice=${minPrice}&maxPrice=${maxPrice}"
                               class="px-4 py-2 rounded-xl border border-slate-200 bg-white text-xs font-bold text-slate-700 hover:bg-slate-900 hover:text-white transition shadow-subtle">
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
                       class="px-4 py-2 rounded-xl border border-slate-200 bg-white text-xs font-bold text-slate-700 hover:bg-slate-900 hover:text-white transition shadow-subtle">
                        Next &rarr;
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="px-4 py-2 rounded-xl border border-slate-100 bg-slate-50 text-xs font-bold text-slate-300 cursor-not-allowed">
                        Next &rarr;
                    </span>
                </c:otherwise>
            </c:choose>

        </div>
    </c:if>
</c:if>

