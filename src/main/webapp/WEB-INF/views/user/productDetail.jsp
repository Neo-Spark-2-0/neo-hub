<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="${product.name} - NEO-HUB" />
        <jsp:param name="metaDescription" value="${product.description}" />
        <jsp:param name="metaKeywords" value="IoT, ${product.categoryName}, ${product.name}" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">

        <!-- back button  -->
        <nav class="flex items-center gap-2 text-xs text-gray-500 mb-6">
            <a href="${pageContext.request.contextPath}/home" class="hover:text-accent">Home</a>
            <i class="fa-solid fa-chevron-right text-[10px]"></i>
            <a href="${pageContext.request.contextPath}/products" class="hover:text-accent">Products</a>
            <i class="fa-solid fa-chevron-right text-[10px]"></i>
            <span class="text-accent font-medium"><c:out value="${product.name}"/></span>
        </nav>


        <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
            <div class="bg-white rounded-2xl border border-gray-200 p-4 flex items-center justify-center">
                <c:choose>
                    <c:when test="${not empty product.image}">
                        <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                             alt="${product.name}"
                             class="w-full max-h-[400px] object-contain rounded-xl">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                             alt="No image"
                             class="w-full max-h-[400px] object-fit rounded-xl">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="flex flex-col gap-4">
                <span class="text-xs font-semibold uppercase tracking-wider text-accent">
                    <c:out value="${product.categoryName}"/>
                </span>
                <h1 class="text-2xl md:text-3xl font-bold text-accent"><c:out value="${product.name}"/></h1>

                <c:if test="${not empty product.brand}">
                    <p class="text-sm text-gray-500">Brand: <strong class="text-accent"><c:out value="${product.brand}"/></strong></p>
                </c:if>

                <!-- price details -->
                <div class="flex items-center gap-3">
                    <c:choose>
                        <c:when test="${product.discountPrice > 0}">
                            <span class="text-2xl font-bold text-accent">Rs. <fmt:formatNumber value="${product.discountPrice}" pattern="#,##0"/></span>
                            <span class="text-sm text-gray-400 line-through">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/></span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-2xl font-bold text-accent">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0"/></span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Stock details -->
                <div>
                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            <span class="inline-block bg-green-100 text-green-700 text-xs font-semibold px-3 py-1 rounded-full">
                                <i class="fa-solid fa-check-circle mr-1"></i> In Stock
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="inline-block bg-red-100 text-red-700 text-xs font-semibold px-3 py-1 rounded-full">
                                <i class="fa-solid fa-times-circle mr-1"></i> Out of Stock
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- desc -->
                <p class="text-gray-600 text-sm leading-relaxed border-t border-gray-100 pt-4"><c:out value="${product.description}"/></p>

                <!-- Cart -->
            <div id="cartArea-${product.id}">
                <c:if test="${product.stock > 0}">
                    <button
                        hx-post="${pageContext.request.contextPath}/cart"
                        hx-vals='{"action":"add","productId":"${product.id}","quantity":"1"}'
                        hx-target="#cartArea-${product.id}"
                        hx-swap="innerHTML"
                        class="bg-accent text-white px-6 py-3 rounded-xl font-semibold hover:opacity-90 transition w-full md:w-auto">
                        <i class="fa-solid fa-cart-plus mr-1"></i> Add to Cart
                    </button>
                </c:if>
            </div>

                <!-- SKU -->
                <c:if test="${not empty product.stockKeepingUnit}">
                    <p class="text-xs text-gray-400 mt-4">SKU: <c:out value="${product.stockKeepingUnit}"/></p>
                </c:if>
            </div>
        </div>

        <!-- related products -->
        <c:if test="${not empty relatedProducts}">
            <section class="mt-16">
                <h2 class="text-xl font-bold text-accent mb-6">Related Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
                    <c:forEach var="related" items="${relatedProducts}">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${related.id}"
                           class="bg-primary border border-gray-200 rounded-2xl overflow-hidden hover:shadow-lg transition group">
                            <div class="aspect-square bg-white flex items-center justify-center p-4">
                                <c:choose>
                                    <c:when test="${not empty related.image}">
                                        <img src="${pageContext.request.contextPath}/uploads/${related.image}"
                                             alt="${related.name}"
                                             class="max-h-full object-contain group-hover:scale-105 transition">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                                             alt="No image"
                                             class="max-h-full object-contain">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="p-3">
                                <p class="text-xs text-gray-400"><c:out value="${related.categoryName}"/></p>
                                <h3 class="text-sm font-semibold text-accent line-clamp-2"><c:out value="${related.name}"/></h3>
                                <c:choose>
                                    <c:when test="${related.discountPrice > 0}">
                                        <span class="text-sm font-bold text-accent">Rs. <fmt:formatNumber value="${related.discountPrice}" pattern="#,##0"/></span>
                                        <span class="text-xs text-gray-400 line-through ml-1">Rs. <fmt:formatNumber value="${related.price}" pattern="#,##0"/></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-sm font-bold text-accent">Rs. <fmt:formatNumber value="${related.price}" pattern="#,##0"/></span>
                                    </c:otherwise>
                                </c:choose>
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