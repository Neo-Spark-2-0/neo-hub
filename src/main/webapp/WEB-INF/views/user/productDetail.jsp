<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="${product.name} | NEO-HUB" />
    <jsp:param name="metaDescription" value="${product.description}" />
    <jsp:param name="metaKeywords" value="IoT, ${product.categoryName}, ${product.name}, electronics" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-12">

        <!-- Breadcrumb Navigation -->
        <nav class="flex items-center gap-2 text-xs font-semibold text-slate-500">
            <a href="${pageContext.request.contextPath}/" class="hover:text-slate-900 transition flex items-center gap-1.5">
                <i class="fa-solid fa-house text-[11px]"></i> Home
            </a>
            <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
            <a href="${pageContext.request.contextPath}/products" class="hover:text-slate-900 transition">Products</a>
            <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
            <a href="${pageContext.request.contextPath}/products?categoryId=${product.categoryId}" class="hover:text-slate-900 transition">
                <c:out value="${product.categoryName}"/>
            </a>
            <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
            <span class="text-slate-900 font-bold truncate max-w-xs"><c:out value="${product.name}"/></span>
        </nav>

        <!-- Product Hero Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 items-start">
            
            <!-- Left: Product Image Showcase -->
            <div class="lg:col-span-6 bg-white rounded-3xl border border-slate-200/80 p-6 shadow-card flex items-center justify-center relative overflow-hidden group">
                <div class="relative w-full aspect-square max-h-[460px] flex items-center justify-center">
                    <c:choose>
                        <c:when test="${not empty product.image}">
                            <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                                 alt="${product.name}"
                                 class="max-w-full max-h-full object-contain group-hover:scale-105 transition-transform duration-500">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                                 alt="No image"
                                 class="max-w-full max-h-full object-contain group-hover:scale-105 transition-transform duration-500">
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Badges -->
                <div class="absolute top-4 left-4 flex flex-col gap-2">
                    <c:if test="${product.discountPrice > 0}">
                        <span class="px-3 py-1 rounded-xl bg-danger text-white text-[10px] font-black uppercase tracking-wider shadow-sm">
                            SALE
                        </span>
                    </c:if>
                </div>
            </div>

            <!-- Right: Details & Purchase Card -->
            <div class="lg:col-span-6 flex flex-col gap-6 bg-white rounded-3xl border border-slate-200/80 p-6 sm:p-8 shadow-card">
                
                <div class="space-y-2">
                    <div class="flex items-center gap-2">
                        <span class="px-3 py-1 rounded-xl bg-slate-100 text-slate-700 text-[11px] font-bold uppercase tracking-wider">
                            <c:out value="${product.categoryName}"/>
                        </span>
                        <c:if test="${not empty product.brand}">
                            <span class="px-3 py-1 rounded-xl bg-brand-50 text-brand-700 border border-brand-100 text-[11px] font-bold">
                                <c:out value="${product.brand}"/>
                            </span>
                        </c:if>
                    </div>

                    <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight leading-snug">
                        <c:out value="${product.name}"/>
                    </h1>
                </div>

                <!-- Price & Stock Status -->
                <div class="flex flex-wrap items-center justify-between gap-4 p-4 rounded-2xl bg-slate-50 border border-slate-100">
                    <div class="flex items-baseline gap-3">
                        <c:choose>
                            <c:when test="${product.discountPrice > 0}">
                                <span class="text-2xl sm:text-3xl font-extrabold text-slate-900">
                                    Rs. <fmt:formatNumber value="${product.discountPrice}" pattern="#,##0"/>
                                </span>
                                <span class="text-sm text-slate-400 line-through font-semibold">
                                    Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-2xl sm:text-3xl font-extrabold text-slate-900">
                                    Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div>
                        <c:choose>
                            <c:when test="${product.stock > 0}">
                                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-brand-50 border border-brand-200 text-brand-700 text-xs font-bold shadow-subtle">
                                    <span class="w-2 h-2 rounded-full bg-brand-500 animate-pulse"></span>
                                    In Stock (${product.stock} units)
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-red-50 border border-red-200 text-red-600 text-xs font-bold">
                                    <i class="fa-solid fa-circle-xmark"></i>
                                    Out of Stock
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Description -->
                <div class="space-y-2">
                    <h3 class="text-xs font-bold uppercase tracking-wider text-slate-400">Description</h3>
                    <p class="text-xs sm:text-sm text-slate-600 leading-relaxed font-medium">
                        <c:out value="${product.description}"/>
                    </p>
                </div>

                <!-- Action / Cart Area -->
                <div class="pt-4 border-t border-slate-100" id="cartArea-${product.id}">
                    <c:set var="cartQty" value="${cartMap[product.id]}" />
                    <c:choose>
                        <%-- In cart: Stepper control --%>
                        <c:when test="${not empty sessionScope.user && cartQty != null && cartQty > 0}">
                            <div class="flex items-center justify-between gap-3 p-2 bg-slate-50 border border-slate-900 rounded-2xl max-w-sm">
                                <button 
                                    hx-post="${pageContext.request.contextPath}/cart"
                                    hx-vals='{"action":"update","productId":"${product.id}","quantity":"${cartQty - 1}"}'
                                    hx-target="#cartArea-${product.id}"
                                    hx-swap="innerHTML"
                                    class="w-10 h-10 rounded-xl bg-white text-slate-900 font-extrabold text-base hover:bg-slate-200 transition flex items-center justify-center shadow-subtle"
                                    aria-label="Decrease quantity">
                                    <i class="fa-solid fa-minus text-xs"></i>
                                </button>
                                <div class="text-center">
                                    <span class="text-sm font-extrabold text-slate-900">${cartQty} in Cart</span>
                                    <span class="text-[10px] text-slate-400 block font-semibold">Quantity</span>
                                </div>
                                <button 
                                    hx-post="${pageContext.request.contextPath}/cart"
                                    hx-vals='{"action":"update","productId":"${product.id}","quantity":"${cartQty + 1}"}'
                                    hx-target="#cartArea-${product.id}"
                                    hx-swap="innerHTML"
                                    ${cartQty >= product.stock ? 'disabled' : ''}
                                    class="w-10 h-10 rounded-xl bg-slate-900 text-white font-extrabold text-base hover:bg-slate-800 transition flex items-center justify-center shadow-subtle ${cartQty >= product.stock ? 'opacity-40 cursor-not-allowed' : ''}"
                                    aria-label="Increase quantity">
                                    <i class="fa-solid fa-plus text-xs"></i>
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
                                        class="w-full sm:w-auto px-8 py-3.5 bg-slate-900 hover:bg-slate-800 text-white rounded-2xl font-bold text-xs sm:text-sm transition-all shadow-md hover:shadow-lg flex items-center justify-center gap-2.5 active:scale-95">
                                        <i class="fa-solid fa-cart-plus text-brand-400"></i>
                                        Add to Cart
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login"
                                       class="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-3.5 bg-slate-900 hover:bg-slate-800 text-white rounded-2xl font-bold text-xs sm:text-sm transition-all shadow-md">
                                        <i class="fa-solid fa-arrow-right-to-bracket text-brand-400"></i>
                                        Login to Purchase
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>

                        <%-- Out of stock --%>
                        <c:otherwise>
                            <button disabled
                                    class="w-full sm:w-auto px-8 py-3.5 bg-slate-100 text-slate-400 rounded-2xl font-bold text-xs sm:text-sm cursor-not-allowed">
                                Currently Out of Stock
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Product Guarantees Grid -->
                <div class="grid grid-cols-2 gap-3 pt-4 border-t border-slate-100 text-xs text-slate-600 font-semibold">
                    <div class="flex items-center gap-2 p-2.5 rounded-xl bg-slate-50">
                        <i class="fa-solid fa-certificate text-brand-600"></i>
                        <span>100% Tested Genuine</span>
                    </div>
                    <div class="flex items-center gap-2 p-2.5 rounded-xl bg-slate-50">
                        <i class="fa-solid fa-box text-blue-600"></i>
                        <span>Anti-Static ESD Safe</span>
                    </div>
                    <div class="flex items-center gap-2 p-2.5 rounded-xl bg-slate-50">
                        <i class="fa-solid fa-truck text-purple-600"></i>
                        <span>Fast Nepal Delivery</span>
                    </div>
                    <div class="flex items-center gap-2 p-2.5 rounded-xl bg-slate-50">
                        <i class="fa-solid fa-shield-check text-amber-600"></i>
                        <span>7-Day Replacement</span>
                    </div>
                </div>

                <c:if test="${not empty product.stockKeepingUnit}">
                    <p class="text-[11px] text-slate-400 font-mono">SKU: <c:out value="${product.stockKeepingUnit}"/></p>
                </c:if>

            </div>
        </div>

        <!-- Related Products Section -->
        <c:if test="${not empty relatedProducts}">
            <section class="space-y-6 pt-10 border-t border-slate-200/80">
                <div class="flex items-center justify-between">
                    <div>
                        <span class="text-xs font-bold uppercase tracking-wider text-brand-600">Recommended</span>
                        <h2 class="text-xl sm:text-2xl font-extrabold text-slate-900 tracking-tight">Related Components &amp; Kits</h2>
                    </div>
                    <a href="${pageContext.request.contextPath}/products?categoryId=${product.categoryId}"
                       class="text-xs font-bold text-slate-600 hover:text-slate-900 transition flex items-center gap-1">
                        View more in category <i class="fa-solid fa-arrow-right text-[10px]"></i>
                    </a>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <c:forEach var="related" items="${relatedProducts}">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${related.id}"
                           class="glass-card rounded-3xl overflow-hidden hover-lift border border-slate-200/80 bg-white flex flex-col group justify-between">
                            <div>
                                <div class="relative w-full aspect-square bg-slate-100 overflow-hidden flex items-center justify-center p-4">
                                    <c:choose>
                                        <c:when test="${not empty related.image}">
                                            <img src="${pageContext.request.contextPath}/uploads/${related.image}"
                                                 alt="${related.name}"
                                                 class="max-w-full max-h-full object-contain group-hover:scale-105 transition-transform duration-500">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                                                 alt="No image"
                                                 class="max-w-full max-h-full object-contain">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="p-5 flex flex-col gap-1.5">
                                    <p class="text-[10px] font-bold uppercase tracking-wider text-slate-400"><c:out value="${related.categoryName}"/></p>
                                    <h3 class="text-sm font-bold text-slate-900 group-hover:text-brand-600 transition-colors line-clamp-2"><c:out value="${related.name}"/></h3>
                                </div>
                            </div>

                            <div class="p-5 pt-0 flex items-center justify-between border-t border-slate-100 pt-3 mt-3">
                                <div>
                                    <c:choose>
                                        <c:when test="${related.discountPrice > 0}">
                                            <span class="text-base font-extrabold text-slate-900">Rs. <fmt:formatNumber value="${related.discountPrice}" pattern="#,##0"/></span>
                                            <span class="text-xs text-slate-400 line-through font-medium ml-1">Rs. <fmt:formatNumber value="${related.price}" pattern="#,##0"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-base font-extrabold text-slate-900">Rs. <fmt:formatNumber value="${related.price}" pattern="#,##0"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <span class="w-8 h-8 rounded-xl bg-slate-100 text-slate-700 group-hover:bg-slate-900 group-hover:text-white flex items-center justify-center transition-colors text-xs">
                                    <i class="fa-solid fa-arrow-right"></i>
                                </span>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </section>
        </c:if>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>