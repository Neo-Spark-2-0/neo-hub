<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="NEO-HUB | Checkout" />
</jsp:include>

<body class="font-poppins bg-secondary">
<jsp:include page="/WEB-INF/templates/user/header.jsp" />

<main class="w-[90vw] mx-auto py-10">

    <div class="mb-6">
        <p class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1">Step 2 of 2</p>
        <h1 class="text-2xl md:text-3xl font-bold text-accent">Checkout</h1>
    </div>

    <!-- Error from promo -->
    <c:if test="${not empty promoError}">
        <div class="mb-4 bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-xl">
            <i class="fa-solid fa-circle-exclamation mr-2"></i>${promoError}
        </div>
    </c:if>
    <c:if test="${not empty promoSuccess}">
        <div class="mb-4 bg-green-50 border border-green-200 text-green-600 text-sm px-4 py-3 rounded-xl">
            <i class="fa-solid fa-circle-check mr-2"></i>${promoSuccess}
        </div>
    </c:if>

    <div class="flex flex-col lg:flex-row gap-8">

        <!-- ════════════════════════════════
             LEFT — DELIVERY + PAYMENT
        ════════════════════════════════ -->
        <div class="flex-1 flex flex-col gap-5">

            <!-- Delivery Address -->
            <div class="bg-primary border border-gray-200 rounded-2xl p-6">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-sm font-bold text-accent">Delivery Address</h3>
                    <a href="${pageContext.request.contextPath}/profile"
                       class="text-xs text-gray-400 hover:text-accent transition">
                        <i class="fa-solid fa-pen-to-square mr-1"></i> Change
                    </a>
                </div>

                <c:choose>
                    <c:when test="${not empty user.street || not empty user.city}">
                        <div class="flex items-start gap-3">
                            <div class="w-9 h-9 rounded-xl bg-accent/10 flex items-center justify-center flex-shrink-0 mt-0.5">
                                <i class="fa-solid fa-location-dot text-accent text-sm"></i>
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-accent">${user.fullName}</p>
                                <p class="text-sm text-gray-500">${user.phone}</p>
                                <p class="text-sm text-gray-500 mt-1">
                                    <c:if test="${not empty user.street}">${user.street}, </c:if>
                                    <c:if test="${not empty user.city}">${user.city}, </c:if>
                                    <c:if test="${not empty user.district}">${user.district}, </c:if>
                                    <c:if test="${not empty user.province}">${user.province}</c:if>
                                </p>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex items-center gap-3 text-yellow-600 bg-yellow-50 border border-yellow-200 rounded-xl p-4">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            <div>
                                <p class="text-sm font-semibold">No address saved</p>
                                <p class="text-xs mt-0.5">
                                    <a href="${pageContext.request.contextPath}/profile"
                                       class="underline hover:text-yellow-800">Add your address</a> before placing the order.
                                </p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Promo Code -->
            <div class="bg-primary border border-gray-200 rounded-2xl p-6">
                <h3 class="text-sm font-bold text-accent mb-4">Promo Code</h3>
                <form action="${pageContext.request.contextPath}/checkout" method="post"
                      class="flex gap-2">
                    <input type="text"
                           name="promoCode"
                           value="${sessionScope.appliedPromoCode != null ? sessionScope.appliedPromoCode.code : ''}"
                           placeholder="Enter promo code"
                           class="flex-1 border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-accent uppercase"
                           ${sessionScope.appliedPromoCode != null ? 'disabled' : ''}>
                    <c:choose>
                        <c:when test="${sessionScope.appliedPromoCode != null}">
                            <a href="${pageContext.request.contextPath}/checkout?removePromo=true"
                               class="px-4 py-2.5 rounded-xl border border-red-200 text-red-500 text-sm font-semibold hover:bg-red-50 transition whitespace-nowrap">
                                Remove
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button type="submit"
                                    class="px-5 py-2.5 bg-accent text-white text-sm font-semibold rounded-xl hover:opacity-90 transition whitespace-nowrap">
                                Apply
                            </button>
                        </c:otherwise>
                    </c:choose>
                </form>
                <c:if test="${sessionScope.appliedPromoCode != null}">
                    <p class="text-xs text-green-600 mt-2 font-medium">
                        <i class="fa-solid fa-circle-check mr-1"></i>
                        ${sessionScope.appliedPromoCode.discountPercent}% discount applied
                    </p>
                </c:if>
            </div>

            <!-- Payment Method -->
            <div class="bg-primary border border-gray-200 rounded-2xl p-6">
                <h3 class="text-sm font-bold text-accent mb-4">Payment Method</h3>

                <form action="${pageContext.request.contextPath}/place-order"
                      method="post"
                      id="orderForm">

                    <div class="flex flex-col gap-3">

                        <!-- Cash on Delivery -->
                        <label class="flex items-center gap-4 border border-gray-200 rounded-xl p-4 cursor-pointer hover:border-accent transition has-[:checked]:border-accent has-[:checked]:bg-accent/5"
                               id="codLabel">
                            <input type="radio" name="paymentMethod" value="COD"
                                   id="codRadio" checked
                                   class="accent-accent"
                                   onchange="togglePaymentUI()">
                            <div class="flex items-center gap-3 flex-1">
                                <div class="w-9 h-9 rounded-xl bg-gray-100 flex items-center justify-center">
                                    <i class="fa-solid fa-money-bill-wave text-green-600 text-sm"></i>
                                </div>
                                <div>
                                    <p class="text-sm font-semibold text-accent">Cash on Delivery</p>
                                    <p class="text-xs text-gray-400">Pay when your order arrives</p>
                                </div>
                            </div>
                        </label>

                        <!-- Khalti -->
                        <label class="flex items-center gap-4 border border-gray-200 rounded-xl p-4 cursor-pointer hover:border-accent transition has-[:checked]:border-accent has-[:checked]:bg-accent/5"
                               id="khaltiLabel">
                            <input type="radio" name="paymentMethod" value="KHALTI"
                                   id="khaltiRadio"
                                   class="accent-accent"
                                   onchange="togglePaymentUI()">
                            <div class="flex items-center gap-3 flex-1">
                                <div class="w-9 h-9 rounded-xl bg-purple-50 flex items-center justify-center">
                                    <!-- Khalti purple icon -->
                                    <svg width="20" height="20" viewBox="0 0 40 40" fill="none">
                                        <rect width="40" height="40" rx="8" fill="#5C2D91"/>
                                        <text x="50%" y="55%" dominant-baseline="middle" text-anchor="middle"
                                              fill="white" font-size="18" font-weight="bold">K</text>
                                    </svg>
                                </div>
                                <div>
                                    <p class="text-sm font-semibold text-accent">Khalti Wallet</p>
                                    <p class="text-xs text-gray-400">Fast &amp; secure digital payment</p>
                                </div>
                            </div>
                        </label>

                    </div>

                    <!-- Khalti info box — shown when Khalti selected -->
                    <div id="khaltiInfo"
                         class="hidden mt-4 bg-purple-50 border border-purple-200 rounded-xl p-4">
                        <div class="flex items-start gap-3">
                            <i class="fa-solid fa-circle-info text-purple-500 mt-0.5"></i>
                            <div>
                                <p class="text-sm font-semibold text-purple-700">Pay via Khalti</p>
                                <p class="text-xs text-purple-600 mt-1">
                                    You will be redirected to Khalti's secure payment page.
                                    After payment, you'll be brought back here automatically.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Place Order Button -->
                    <button type="submit"
                            id="placeOrderBtn"
                            class="mt-5 w-full bg-accent text-white text-sm font-bold py-3.5 rounded-xl hover:opacity-90 transition flex items-center justify-center gap-2">
                        <i class="fa-solid fa-lock text-xs"></i>
                        <span id="btnText">Place Order — Rs. <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                    </button>

                    <p class="text-center text-xs text-gray-400 mt-3">
                        <i class="fa-solid fa-shield-halved mr-1"></i>
                        Your payment information is secure and encrypted
                    </p>

                </form>
            </div>

        </div>

        <!-- ════════════════════════════════
             RIGHT — ORDER SUMMARY
        ════════════════════════════════ -->
        <div class="w-full lg:w-80 flex-shrink-0">
            <div class="bg-primary border border-gray-200 rounded-2xl p-6 sticky top-4">
                <h3 class="text-sm font-bold text-accent mb-5">Order Summary</h3>

                <!-- Cart Items -->
                <div class="flex flex-col gap-4 mb-5">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="flex items-center gap-3">
                            <img src="${pageContext.request.contextPath}/uploads/${item.productImage}"
                                 alt="${item.productName}"
                                 class="w-12 h-12 rounded-xl object-cover border border-gray-100 flex-shrink-0"
                                 onerror="this.src='${pageContext.request.contextPath}/static/images/placeholder.png'">
                            <div class="flex-1 min-w-0">
                                <p class="text-xs font-semibold text-accent truncate">${item.productName}</p>
                                <p class="text-xs text-gray-400 mt-0.5">Qty: ${item.quantity}</p>
                            </div>
                            <span class="text-xs font-bold text-accent flex-shrink-0">
                                Rs. <fmt:formatNumber value="${item.productDiscountPrice > 0 ? item.productDiscountPrice * item.quantity : item.productPrice * item.quantity}" pattern="#,##0"/>
                            </span>
                        </div>
                    </c:forEach>
                </div>

                <div class="border-t border-gray-100 pt-4 flex flex-col gap-3">
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-500">Subtotal</span>
                        <span class="font-medium text-accent">Rs. <fmt:formatNumber value="${subTotal}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-500">Shipping</span>
                        <span class="font-medium text-accent">Rs. <fmt:formatNumber value="${shippingCharge}" pattern="#,##0.00"/></span>
                    </div>
                    <c:if test="${sessionScope.appliedPromoCode != null}">
                        <div class="flex justify-between text-sm">
                            <span class="text-green-600">Discount (${sessionScope.appliedPromoCode.discountPercent}%)</span>
                            <span class="font-medium text-green-600">
                                - Rs. <fmt:formatNumber value="${subTotal * sessionScope.appliedPromoCode.discountPercent / 100}" pattern="#,##0.00"/>
                            </span>
                        </div>
                    </c:if>
                    <div class="flex justify-between text-base font-bold border-t border-gray-100 pt-3">
                        <span class="text-accent">Total</span>
                        <span class="text-accent">Rs. <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                    </div>
                </div>

                <!-- Back to Cart -->
                <a href="${pageContext.request.contextPath}/cart"
                   class="mt-5 w-full block text-center text-sm text-gray-400 hover:text-accent transition py-2 border border-gray-200 rounded-xl">
                    <i class="fa-solid fa-arrow-left mr-1 text-xs"></i> Back to Cart
                </a>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/templates/user/footer.jsp" />

<script>
function togglePaymentUI() {
    const khaltiSelected = document.getElementById('khaltiRadio').checked;
    const khaltiInfo     = document.getElementById('khaltiInfo');
    const btnText        = document.getElementById('btnText');
    const total          = '<fmt:formatNumber value="${total}" pattern="#,##0.00"/>';

    if (khaltiSelected) {
        khaltiInfo.classList.remove('hidden');
        btnText.textContent = 'Pay with Khalti — Rs. ' + total;
    } else {
        khaltiInfo.classList.add('hidden');
        btnText.textContent = 'Place Order — Rs. ' + total;
    }
}
</script>

</body>
</html>
