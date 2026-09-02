<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Secure Checkout | NEO-HUB" />
    <jsp:param name="metaDescription" value="Complete your order securely on NEO-HUB." />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
<jsp:include page="/WEB-INF/templates/user/header.jsp" />

<main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-8">

    <!-- Progress Steps Header -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
        <div>
            <div class="flex items-center gap-2 text-xs font-semibold text-slate-500 mb-1">
                <a href="${pageContext.request.contextPath}/cart" class="hover:text-slate-900 transition">Cart</a>
                <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                <span class="text-slate-900 font-bold">Checkout</span>
            </div>
            <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
                Complete Your Order
            </h1>
        </div>

        <!-- 3-step indicator -->
        <div class="flex items-center gap-2 text-xs font-bold">
            <span class="flex items-center gap-1.5 text-brand-600">
                <span class="w-5 h-5 rounded-full bg-brand-100 text-brand-700 flex items-center justify-center text-[10px]">✓</span>
                Cart
            </span>
            <span class="w-4 h-px bg-slate-300"></span>
            <span class="flex items-center gap-1.5 text-slate-900">
                <span class="w-5 h-5 rounded-full bg-slate-900 text-white flex items-center justify-center text-[10px]">2</span>
                Payment
            </span>
            <span class="w-4 h-px bg-slate-300"></span>
            <span class="flex items-center gap-1.5 text-slate-400">
                <span class="w-5 h-5 rounded-full bg-slate-200 text-slate-500 flex items-center justify-center text-[10px]">3</span>
                Confirmed
            </span>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">

        <!-- Left Column: Address, Promo, Payment -->
        <div class="lg:col-span-8 flex flex-col gap-6">

            <!-- 1. Delivery Address Card -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-4">
                <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                    <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
                        <i class="fa-solid fa-location-dot text-brand-600"></i>
                        1. Delivery Destination
                    </h3>
                    <a href="${pageContext.request.contextPath}/profile"
                       class="text-xs font-bold text-brand-600 hover:text-brand-700 transition flex items-center gap-1">
                        <i class="fa-solid fa-pen-to-square text-[10px]"></i> Change Address
                    </a>
                </div>

                <c:choose>
                    <c:when test="${not empty user.street || not empty user.city || not empty user.district || not empty user.province}">
                        <div class="flex items-start gap-4 p-4 rounded-2xl bg-slate-50 border border-slate-100">
                            <div class="w-10 h-10 rounded-2xl bg-white border border-slate-200/80 text-slate-800 flex items-center justify-center flex-shrink-0 shadow-subtle text-sm">
                                <i class="fa-solid fa-house-chimney"></i>
                            </div>
                            <div class="text-xs space-y-1">
                                <div class="flex items-center gap-2">
                                    <p class="font-extrabold text-slate-900 text-sm">${user.fullName}</p>
                                    <span class="px-2 py-0.5 rounded-md bg-slate-200 text-slate-700 font-bold text-[10px]">Recipient</span>
                                </div>
                                <p class="text-slate-500 font-semibold"><i class="fa-solid fa-phone text-[10px] mr-1"></i> ${user.phone}</p>
                                <p class="text-slate-600 leading-relaxed font-medium">
                                    <c:if test="${not empty user.street}">${user.street}, </c:if>
                                    <c:if test="${not empty user.city}">${user.city}, </c:if>
                                    <c:if test="${not empty user.district}">${user.district}, </c:if>
                                    <c:if test="${not empty user.province}">${user.province}</c:if>
                                    <c:if test="${not empty user.landmark}">
                                        <span class="text-slate-400 block mt-0.5 font-normal"><i class="fa-solid fa-map-pin text-[10px] mr-1"></i> Landmark: ${user.landmark}</span>
                                    </c:if>
                                </p>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex items-center gap-3.5 p-4 rounded-2xl bg-amber-50 border border-amber-200/80 text-amber-800 text-xs">
                            <i class="fa-solid fa-triangle-exclamation text-base text-amber-600 flex-shrink-0"></i>
                            <div>
                                <p class="font-bold">No delivery address saved</p>
                                <p class="mt-0.5">
                                    Please <a href="${pageContext.request.contextPath}/profile" class="underline font-extrabold hover:text-amber-900">add your shipping address in your profile</a> to ensure swift dispatch.
                                </p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 2. Promo Code Card -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-4">
                <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2 border-b border-slate-100 pb-3">
                    <i class="fa-solid fa-ticket text-brand-600"></i>
                    2. Promo Code &amp; Coupons
                </h3>

                <form action="${pageContext.request.contextPath}/checkout" method="post" class="flex gap-2">
                    <div class="relative flex-1">
                        <i class="fa-solid fa-tag absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input type="text"
                               name="promoCode"
                               value="${sessionScope.appliedPromoCode != null ? sessionScope.appliedPromoCode.code : ''}"
                               placeholder="ENTER PROMO CODE"
                               class="w-full bg-slate-50 border border-slate-200 rounded-2xl pl-9 pr-4 py-2.5 text-xs font-bold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 uppercase tracking-wider transition ${sessionScope.appliedPromoCode != null ? 'opacity-60 cursor-not-allowed' : ''}"
                               ${sessionScope.appliedPromoCode != null ? 'disabled' : ''}>
                    </div>

                    <c:choose>
                        <c:when test="${sessionScope.appliedPromoCode != null}">
                            <a href="${pageContext.request.contextPath}/checkout?removePromo=true"
                               class="px-5 py-2.5 rounded-2xl border border-red-200 bg-red-50 text-danger text-xs font-bold hover:bg-red-100 transition whitespace-nowrap flex items-center gap-1.5">
                                <i class="fa-solid fa-xmark"></i> Remove
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button type="submit"
                                    class="px-6 py-2.5 bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold rounded-2xl transition whitespace-nowrap shadow-sm">
                                Apply Code
                            </button>
                        </c:otherwise>
                    </c:choose>
                </form>

                <c:if test="${sessionScope.appliedPromoCode != null}">
                    <div class="p-3 rounded-2xl bg-brand-50 border border-brand-200 text-brand-800 text-xs font-bold flex items-center justify-between">
                        <span class="flex items-center gap-1.5">
                            <i class="fa-solid fa-circle-check text-brand-600"></i>
                            Coupon "${sessionScope.appliedPromoCode.code}" applied!
                        </span>
                        <span class="px-2 py-0.5 rounded-md bg-brand-200 text-brand-900 text-[10px] font-black">
                            ${sessionScope.appliedPromoCode.discountPercent}% OFF
                        </span>
                    </div>
                </c:if>
            </div>

            <!-- 3. Payment Method Card -->
            <div class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-5">
                <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2 border-b border-slate-100 pb-3">
                    <i class="fa-solid fa-credit-card text-brand-600"></i>
                    3. Choose Payment Method
                </h3>

                <form action="${pageContext.request.contextPath}/place-order" method="post" id="orderForm" class="space-y-4">

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        
                        <!-- Cash on Delivery Option -->
                        <label class="relative flex flex-col p-4 rounded-2xl border-2 border-slate-200 hover:border-slate-900 cursor-pointer transition-all bg-white group has-[:checked]:border-slate-900 has-[:checked]:bg-slate-50/70" id="codLabel">
                            <div class="flex items-center justify-between mb-3">
                                <div class="w-10 h-10 rounded-xl bg-brand-50 text-brand-600 flex items-center justify-center text-base border border-brand-100">
                                    <i class="fa-solid fa-hand-holding-dollar"></i>
                                </div>
                                <input type="radio" name="paymentMethod" value="CashOnDelivery" id="codRadio" checked class="w-4 h-4 text-slate-900 focus:ring-slate-900">
                            </div>
                            <p class="text-xs font-extrabold text-slate-900">Cash on Delivery</p>
                            <p class="text-[11px] text-slate-500 font-medium mt-0.5">Pay in cash when order is delivered</p>
                        </label>

                        <!-- Khalti Digital Wallet Option -->
                        <label class="relative flex flex-col p-4 rounded-2xl border-2 border-slate-200 hover:border-purple-600 cursor-pointer transition-all bg-white group has-[:checked]:border-purple-600 has-[:checked]:bg-purple-50/40" id="khaltiLabel">
                            <div class="flex items-center justify-between mb-3">
                                <div class="w-10 h-10 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center text-base border border-purple-100">
                                    <i class="fa-solid fa-wallet"></i>
                                </div>
                                <input type="radio" name="paymentMethod" value="KHALTI" id="khaltiRadio" class="w-4 h-4 text-purple-600 focus:ring-purple-600">
                            </div>
                            <p class="text-xs font-extrabold text-slate-900">Khalti Digital Wallet</p>
                            <p class="text-[11px] text-slate-500 font-medium mt-0.5">Instant online payment via Khalti</p>
                        </label>

                    </div>

                    <!-- Place Order CTA -->
                    <div class="pt-2">
                        <button type="submit"
                                id="placeOrderButton"
                                class="w-full bg-slate-900 hover:bg-slate-800 text-white text-xs sm:text-sm font-bold py-4 rounded-2xl transition-all shadow-md hover:shadow-lg flex items-center justify-center gap-2.5 active:scale-95">
                            <i class="fa-solid fa-lock text-brand-400 text-xs"></i>
                            <span id="btnText">Confirm &amp; Place Order - Rs. <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                        </button>

                        <p class="text-center text-[11px] text-slate-400 mt-3 font-medium flex items-center justify-center gap-1.5">
                            <i class="fa-solid fa-shield-halved text-brand-600"></i>
                            256-bit encrypted checkout. Your payment details are always protected.
                        </p>
                    </div>

                </form>
            </div>

        </div>

        <!-- Right Column: Order Summary -->
        <div class="lg:col-span-4">
            <div class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-6">
                <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider pb-3 border-b border-slate-100">
                    Order Summary
                </h3>

                <!-- Items list -->
                <div class="flex flex-col gap-3.5 max-h-72 overflow-y-auto pr-1">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="flex items-center gap-3 text-xs">
                            <div class="w-12 h-12 rounded-xl bg-slate-100 border border-slate-100 flex items-center justify-center overflow-hidden flex-shrink-0">
                                <c:choose>
                                    <c:when test="${not empty item.productImage}">
                                        <img src="${pageContext.request.contextPath}/uploads/${item.productImage}"
                                             alt="${item.productName}" class="w-full h-full object-cover">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                                             alt="${item.productName}" class="w-full h-full object-cover">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="flex-1 min-w-0">
                                <p class="font-bold text-slate-900 truncate">${item.productName}</p>
                                <p class="text-slate-400 text-[11px] font-semibold mt-0.5">Qty: ${item.quantity}</p>
                            </div>
                            <span class="font-bold text-slate-900 flex-shrink-0">
                                Rs. <fmt:formatNumber value="${item.productDiscountPrice > 0 ? item.productDiscountPrice * item.quantity : item.productPrice * item.quantity}" pattern="#,##0"/>
                            </span>
                        </div>
                    </c:forEach>
                </div>

                <!-- Totals Breakdown -->
                <div class="border-t border-slate-100 pt-4 space-y-3 text-xs font-medium text-slate-600">
                    <div class="flex justify-between">
                        <span>Subtotal</span>
                        <span class="font-bold text-slate-900">Rs. <fmt:formatNumber value="${subTotal}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="flex justify-between">
                        <span>Shipping Fee</span>
                        <span class="font-bold text-slate-900">Rs. <fmt:formatNumber value="${shippingCharge}" pattern="#,##0.00"/></span>
                    </div>
                    <c:if test="${sessionScope.appliedPromoCode != null}">
                        <div class="flex justify-between text-brand-700 font-bold">
                            <span>Promo Discount (${sessionScope.appliedPromoCode.discountPercent}%)</span>
                            <span>
                                - Rs. <fmt:formatNumber value="${subTotal * sessionScope.appliedPromoCode.discountPercent / 100}" pattern="#,##0.00"/>
                            </span>
                        </div>
                    </c:if>
                    <div class="flex justify-between text-sm font-extrabold text-slate-900 border-t border-slate-100 pt-3">
                        <span>Grand Total</span>
                        <span class="text-base text-slate-900">Rs. <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                    </div>
                </div>

                <!-- Back to Cart Link -->
                <a href="${pageContext.request.contextPath}/cart"
                   class="w-full block text-center border border-slate-200 text-slate-700 py-2.5 rounded-2xl text-xs font-bold hover:bg-slate-50 transition">
                    <i class="fa-solid fa-arrow-left mr-1 text-[10px]"></i> Modify Cart
                </a>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/templates/user/footer.jsp" />

<script>
    <c:if test="${not empty promoError}">
        showToast('<c:out value="${promoError}"/>', 'error');
    </c:if>

    <c:if test="${not empty promoSuccess}">
        showToast('<c:out value="${promoSuccess}"/>', 'success');
    </c:if>

    const params = new URLSearchParams(window.location.search);
    if (params.has('error')) {
        const messages = {
            orderfailed: 'Failed to create order. Please try again.'
        };
        const error = params.get('error');
        showToast(messages[error] || 'An error occurred.', 'error');
        window.history.replaceState({}, document.title, window.location.pathname);
    }
</script>
</body>
</html>

