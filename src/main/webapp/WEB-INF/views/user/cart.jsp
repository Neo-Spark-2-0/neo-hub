<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Shopping Cart | NEO-HUB" />
    <jsp:param name="metaDescription" value="Review your selected IoT components and electronics before checkout." />
    <jsp:param name="metaKeywords" value="cart, IoT, electronics, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="cart" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-8">
        
        <!-- Header & Breadcrumb -->
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
            <div>
                <div class="flex items-center gap-2 text-xs font-semibold text-slate-500 mb-1">
                    <a href="${pageContext.request.contextPath}/" class="hover:text-slate-900 transition">Home</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                    <span class="text-slate-900 font-bold">Shopping Cart</span>
                </div>
                <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
                    Your Shopping Cart
                </h1>
            </div>
            <c:if test="${not empty cartItems}">
                <a href="${pageContext.request.contextPath}/products"
                   class="text-xs font-bold text-slate-600 hover:text-slate-900 transition flex items-center gap-1.5">
                    <i class="fa-solid fa-arrow-left text-[10px]"></i> Continue Shopping
                </a>
            </c:if>
        </div>

        <c:choose>
            <%-- Empty Cart State --%>
            <c:when test="${empty cartItems}">
                <div class="bg-white rounded-3xl border border-slate-200/80 p-12 sm:p-16 text-center max-w-lg mx-auto shadow-card space-y-5">
                    <div class="w-20 h-20 rounded-3xl bg-slate-100 text-slate-400 flex items-center justify-center mx-auto text-3xl">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </div>
                    <div class="space-y-1">
                        <h2 class="text-xl font-extrabold text-slate-900">Your Cart is Currently Empty</h2>
                        <p class="text-xs sm:text-sm text-slate-500 font-medium">Looks like you haven't added any IoT components or project kits yet.</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/products"
                           class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white text-xs sm:text-sm font-bold px-8 py-3.5 rounded-2xl transition-all shadow-md hover:shadow-lg">
                            <i class="fa-solid fa-layer-group text-brand-400"></i>
                            Browse IoT Catalog
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- Cart Items List & Summary --%>
            <c:otherwise>
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
                    
                    <!-- Left: Items Table / List -->
                    <div class="lg:col-span-8 bg-white rounded-3xl border border-slate-200/80 overflow-hidden shadow-card">
                        <div class="p-6 border-b border-slate-100 flex items-center justify-between">
                            <h2 class="text-sm font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
                                <i class="fa-solid fa-boxes-stacked text-brand-600"></i>
                                Cart Items (${cartItems.size()})
                            </h2>
                            <span class="text-xs text-slate-400 font-semibold">Price per unit</span>
                        </div>

                        <div class="divide-y divide-slate-100">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="p-5 sm:p-6 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 hover:bg-slate-50/50 transition">
                                    
                                    <!-- Item Info -->
                                    <div class="flex items-center gap-4 flex-1 min-w-0">
                                        <div class="w-16 h-16 rounded-2xl bg-slate-100 border border-slate-100 flex items-center justify-center flex-shrink-0 overflow-hidden">
                                            <img src="${pageContext.request.contextPath}${not empty item.productImage ? '/uploads/'.concat(item.productImage) : '/static/images/product-fallback.jpg'}"
                                                 alt="${item.productName}"
                                                 class="w-full h-full object-cover">
                                        </div>
                                        <div class="min-w-0">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${item.productId}"
                                               class="text-xs sm:text-sm font-bold text-slate-900 hover:text-brand-600 transition truncate block">
                                                ${item.productName}
                                            </a>
                                            <div class="mt-1 flex items-center gap-2 text-xs">
                                                <c:choose>
                                                    <c:when test="${item.productDiscountPrice > 0}">
                                                        <span class="font-extrabold text-slate-900">
                                                            Rs. <fmt:formatNumber value="${item.productDiscountPrice}" pattern="#,##0"/>
                                                        </span>
                                                        <span class="text-[11px] text-slate-400 line-through font-medium">
                                                            Rs. <fmt:formatNumber value="${item.productPrice}" pattern="#,##0"/>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="font-extrabold text-slate-900">
                                                            Rs. <fmt:formatNumber value="${item.productPrice}" pattern="#,##0"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Controls: Stepper, Subtotal & Delete -->
                                    <div class="flex items-center justify-between sm:justify-end gap-6 w-full sm:w-auto pt-3 sm:pt-0 border-t sm:border-t-0 border-slate-100">
                                        
                                        <!-- Quantity Stepper Form -->
                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="flex items-center gap-1.5 bg-slate-100 p-1 rounded-xl">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <input type="number" name="quantity" value="${item.quantity}"
                                                   min="1" max="${item.productStock}"
                                                   class="w-14 bg-white border border-slate-200 rounded-lg text-center font-bold text-xs py-1 focus:outline-none focus:ring-1 focus:ring-brand-500"
                                                   onchange="this.form.submit()">
                                        </form>

                                        <!-- Item Total -->
                                        <div class="text-right min-w-[90px]">
                                            <span class="text-sm font-black text-slate-900">
                                                Rs. <fmt:formatNumber value="${(item.productDiscountPrice > 0 ? item.productDiscountPrice : item.productPrice) * item.quantity}" pattern="#,##0"/>
                                            </span>
                                        </div>

                                        <!-- Remove Button -->
                                        <form action="${pageContext.request.contextPath}/cart" method="post">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <button type="submit"
                                                    class="w-8 h-8 rounded-xl bg-slate-100 hover:bg-red-50 text-slate-400 hover:text-danger flex items-center justify-center transition text-xs"
                                                    title="Remove item">
                                                <i class="fa-regular fa-trash-can"></i>
                                            </button>
                                        </form>
                                    </div>

                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Right: Order Summary Card -->
                    <div class="lg:col-span-4 bg-white rounded-3xl border border-slate-200/80 p-6 sm:p-7 shadow-card space-y-6">
                        <h2 class="text-sm font-extrabold text-slate-900 uppercase tracking-wider pb-3 border-b border-slate-100">
                            Order Summary
                        </h2>

                        <div class="space-y-3.5 text-xs font-medium text-slate-600">
                            <div class="flex justify-between items-center">
                                <span>Subtotal</span>
                                <span class="font-bold text-slate-900 text-sm">
                                    Rs. <fmt:formatNumber value="${grandTotal}" pattern="#,##0"/>
                                </span>
                            </div>

                            <div class="flex justify-between items-center">
                                <span class="flex items-center gap-1.5">
                                    Estimated Shipping
                                    <i class="fa-solid fa-circle-info text-slate-300 text-[10px]" title="Flat delivery fee across Nepal"></i>
                                </span>
                                <span class="font-bold text-slate-900">Rs. 100</span>
                            </div>

                            <div class="pt-4 border-t border-slate-100">
                                <div class="flex justify-between items-center text-sm font-extrabold text-slate-900">
                                    <span>Estimated Total</span>
                                    <span class="text-base text-slate-900">
                                        Rs. <fmt:formatNumber value="${grandTotal + 100}" pattern="#,##0"/>
                                    </span>
                                </div>
                                <p class="text-[10px] text-slate-400 mt-1 font-semibold">Taxes included. Discounts applied at checkout.</p>
                            </div>
                        </div>

                        <!-- CTA Actions -->
                        <div class="space-y-3 pt-2">
                            <a href="${pageContext.request.contextPath}/checkout"
                               class="w-full bg-slate-900 hover:bg-slate-800 text-white py-3.5 rounded-2xl font-bold text-xs sm:text-sm transition-all shadow-md hover:shadow-lg flex items-center justify-center gap-2">
                                <i class="fa-solid fa-lock text-brand-400 text-xs"></i>
                                Proceed to Checkout
                            </a>
                            <a href="${pageContext.request.contextPath}/products"
                               class="w-full block text-center border border-slate-200 text-slate-700 py-3 rounded-2xl text-xs font-bold hover:bg-slate-50 transition">
                                Continue Shopping
                            </a>
                        </div>

                        <!-- Payment Trust Info -->
                        <div class="pt-4 border-t border-slate-100 flex items-center justify-center gap-4 text-slate-400 text-xs font-medium">
                            <span class="flex items-center gap-1"><i class="fa-solid fa-shield-check text-brand-600"></i> SSL Encrypted</span>
                            <span>•</span>
                            <span class="flex items-center gap-1"><i class="fa-solid fa-truck-fast text-blue-600"></i> Fast Dispatch</span>
                        </div>
                    </div>

                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />

    <script>
    window.addEventListener('load', () => {
        const params = new URLSearchParams(window.location.search);

        if (params.has('success')) {
            const successType = params.get('success');
            let message = 'Cart updated successfully!';
            if (successType === 'removed') {
                message = 'Item removed from cart.';
            }
            showToast(message, 'success');
        }

        if (params.has('error')) {
            const messages = {
                empty: 'Quantity cannot be empty.',
                invalid: 'Please enter a valid number.',
                stock: 'Quantity exceeds available stock.',
                product: 'Product no longer exists.',
                notfound: 'Product no longer exists.'
            };
            const error = params.get('error');
            showToast(messages[error] || 'An error occurred.', 'error');
        }

        // Clean query params from URL bar
        if (params.toString()) {
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    });
    </script>
</body>
</html>