<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order #${order.id} | NEO-HUB" />
    <jsp:param name="metaDescription" value="View details and invoice for order #${order.id}" />
    <jsp:param name="metaKeywords" value="order details, invoice, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-8">
        
        <!-- Header & Action Bar -->
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
            <div>
                <div class="flex items-center gap-2 text-xs font-semibold text-slate-500 mb-1">
                    <a href="${pageContext.request.contextPath}/order-history" class="hover:text-slate-900 transition flex items-center gap-1">
                        <i class="fa-solid fa-arrow-left text-[10px]"></i> All Orders
                    </a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                    <span class="text-slate-900 font-bold font-mono">#${order.id}</span>
                </div>
                <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight flex items-center gap-3">
                    <span>Order Receipt</span>
                    <span class="text-base sm:text-lg font-mono font-bold text-slate-400">#${order.id}</span>
                </h1>
            </div>

            <div class="flex items-center gap-3">
                <c:if test="${order.orderStatus == 'Confirmed' or order.orderStatus == 'Delivered' or order.orderStatus == 'Shipped' or order.orderStatus == 'Processing'}">
                    <button onclick="printInvoice()"
                            class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white px-5 py-2.5 rounded-2xl text-xs font-bold transition shadow-sm active:scale-95">
                        <i class="fa-solid fa-print text-brand-400"></i>
                        <span>Print Invoice</span>
                    </button>
                </c:if>
            </div>
        </div>

        <!-- Order Information & Delivery Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <!-- Order Details Card -->
            <div class="bg-white rounded-3xl border border-slate-200/80 p-6 shadow-card space-y-4">
                <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2 border-b border-slate-100 pb-3">
                    <i class="fa-solid fa-circle-info text-brand-600"></i>
                    Order Information
                </h3>
                
                <div class="space-y-3 text-xs font-medium text-slate-600">
                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Order Placed</span>
                        <span class="font-bold text-slate-900">
                            <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy, hh:mm a"/>
                        </span>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Order Status</span>
                        <c:choose>
                            <c:when test="${order.orderStatus == 'Delivered'}">
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 text-[11px] font-bold bg-brand-50 border border-brand-200 text-brand-700 rounded-lg">
                                    <i class="fa-solid fa-circle-check"></i> Delivered
                                </span>
                            </c:when>
                            <c:when test="${order.orderStatus == 'Cancelled'}">
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 text-[11px] font-bold bg-red-50 border border-red-200 text-danger rounded-lg">
                                    <i class="fa-solid fa-circle-xmark"></i> Cancelled
                                </span>
                            </c:when>
                            <c:when test="${order.orderStatus == 'Shipped'}">
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 text-[11px] font-bold bg-blue-50 border border-blue-200 text-blue-700 rounded-lg">
                                    <i class="fa-solid fa-truck-fast"></i> Shipped
                                </span>
                            </c:when>
                            <c:when test="${order.orderStatus == 'Processing'}">
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 text-[11px] font-bold bg-amber-50 border border-amber-200 text-amber-700 rounded-lg">
                                    <i class="fa-solid fa-arrows-rotate"></i> Processing
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 text-[11px] font-bold bg-slate-100 text-slate-700 rounded-lg">
                                    ${order.orderStatus}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Payment Channel</span>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'Khalti'}">
                                <span class="font-bold text-purple-700 flex items-center gap-1">
                                    <i class="fa-solid fa-wallet text-purple-600"></i> Khalti Wallet
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="font-bold text-emerald-700 flex items-center gap-1">
                                    <i class="fa-solid fa-hand-holding-dollar text-emerald-600"></i> Cash on Delivery
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Payment Status</span>
                        <c:choose>
                            <c:when test="${order.paymentStatus == 'Completed'}">
                                <span class="font-bold text-brand-700 flex items-center gap-1">
                                    <i class="fa-solid fa-circle-check"></i> Completed
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="font-bold text-amber-600 flex items-center gap-1">
                                    <i class="fa-solid fa-clock"></i> ${order.paymentStatus}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${not empty order.transactionId}">
                        <div class="flex justify-between items-center">
                            <span class="text-slate-400">Transaction Ref</span>
                            <span class="font-mono text-[11px] text-slate-700 bg-slate-100 px-2 py-0.5 rounded-md font-bold">${order.transactionId}</span>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Delivery Address Card -->
            <div class="bg-white rounded-3xl border border-slate-200/80 p-6 shadow-card space-y-4">
                <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2 border-b border-slate-100 pb-3">
                    <i class="fa-solid fa-location-dot text-brand-600"></i>
                    Shipping Destination
                </h3>
                <div class="space-y-2 text-xs">
                    <p class="font-extrabold text-slate-900 text-sm">${order.userFullName}</p>
                    <p class="text-slate-500 font-semibold"><i class="fa-solid fa-phone text-[10px] mr-1"></i> ${order.userPhone}</p>
                    <p class="text-slate-600 leading-relaxed font-medium bg-slate-50 p-3 rounded-2xl border border-slate-100">
                        ${order.userAddress}
                    </p>
                </div>
            </div>

        </div>

        <!-- Ordered Items Table -->
        <div class="bg-white rounded-3xl border border-slate-200/80 overflow-hidden shadow-card">
            <div class="p-6 border-b border-slate-100">
                <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider">
                    Purchased Components (${order.orderItems.size()})
                </h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-xs text-left">
                    <thead class="bg-slate-50 border-b border-slate-100 text-[11px] font-extrabold text-slate-400 uppercase tracking-wider">
                        <tr>
                            <th class="py-4 px-6">Product</th>
                            <th class="py-4 px-6">Unit Price</th>
                            <th class="py-4 px-6 text-center">Quantity</th>
                            <th class="py-4 px-6 text-right">Total Price</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 font-medium text-slate-700">
                        <c:forEach var="item" items="${order.orderItems}">
                            <tr class="hover:bg-slate-50/60 transition">
                                <td class="py-4 px-6">
                                    <div class="flex items-center gap-3.5">
                                        <div class="w-12 h-12 rounded-xl bg-slate-100 border border-slate-100 overflow-hidden flex items-center justify-center flex-shrink-0">
                                            <c:choose>
                                                <c:when test="${not empty item.productImage}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${item.productImage}" 
                                                         alt="${item.productName}" 
                                                         class="w-full h-full object-cover"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg" 
                                                         alt="${item.productName}" 
                                                         class="w-full h-full object-cover"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="font-bold text-slate-900">${item.productName}</span>
                                    </div>
                                </td>
                                <td class="py-4 px-6 text-slate-500 font-semibold">
                                    Rs. <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0"/>
                                </td>
                                <td class="py-4 px-6 text-center font-bold text-slate-900">
                                    ${item.quantity}
                                </td>
                                <td class="py-4 px-6 text-right font-extrabold text-slate-900">
                                    Rs. <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,##0"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Summary Totals Card -->
        <div class="bg-white rounded-3xl border border-slate-200/80 p-6 sm:p-7 shadow-card max-w-sm ml-auto space-y-3 text-xs font-medium text-slate-600">
            <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider pb-3 border-b border-slate-100">
                Summary Breakdown
            </h3>
            <div class="flex justify-between items-center">
                <span>Subtotal</span>
                <span class="font-bold text-slate-900">Rs. <fmt:formatNumber value="${order.subTotalAmount}" pattern="#,##0"/></span>
            </div>
            <div class="flex justify-between items-center">
                <span>Shipping Charge</span>
                <span class="font-bold text-slate-900">Rs. <fmt:formatNumber value="${order.shippingCharge}" pattern="#,##0"/></span>
            </div>
            <c:if test="${order.discountAmount > 0}">
                <div class="flex justify-between items-center text-brand-700 font-bold">
                    <span>Discount Applied</span>
                    <span>- Rs. <fmt:formatNumber value="${order.discountAmount}" pattern="#,##0"/></span>
                </div>
            </c:if>
            <div class="flex justify-between items-center text-sm font-extrabold text-slate-900 border-t border-slate-100 pt-3">
                <span>Grand Total</span>
                <span class="text-base text-slate-900">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></span>
            </div>
        </div>

    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />

    <script>
    function printInvoice() {
        const printWindow = window.open('', '_blank', 'width=800,height=600');
        printWindow.document.write(`
            <!DOCTYPE html>
            <html>
            <head>
                <title>Invoice - Order #${order.id}</title>
                <style>
                    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
                    body { padding: 40px; background: white; color: #1e293b; }
                    .invoice-header { text-align: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 2px solid #0f172a; }
                    .invoice-header h1 { font-size: 28px; font-weight: 800; color: #0f172a; margin-bottom: 5px; }
                    .invoice-header p { color: #64748b; font-size: 12px; }
                    .order-details { margin-bottom: 30px; }
                    .order-details table { width: 100%; border-collapse: collapse; }
                    .order-details td { padding: 6px 0; font-size: 13px; }
                    .order-details td:first-child { width: 140px; font-weight: 700; color: #64748b; }
                    table.items { width: 100%; margin: 20px 0; border-collapse: collapse; }
                    table.items th { background: #f8fafc; padding: 10px; text-align: left; font-size: 12px; font-weight: 700; border-bottom: 1px solid #e2e8f0; }
                    table.items td { padding: 8px 10px; font-size: 13px; border-bottom: 1px solid #f1f5f9; }
                    .total-row { text-align: right; font-weight: 800; font-size: 16px; margin-top: 20px; padding-top: 10px; border-top: 2px solid #0f172a; }
                    .footer { text-align: center; margin-top: 40px; font-size: 11px; color: #94a3b8; }
                </style>
            </head>
            <body>
                <div class="invoice-header">
                    <h1>NEO-HUB</h1>
                    <p>IoT Equipment & Project Marketplace</p>
                    <p>Gandaki Province, Pokhara, Nepal | neohubnepal@gmail.com</p>
                </div>
                <div class="order-details">
                    <table>
                        <tr><td>Order ID</td><td><strong>#${order.id}</strong></td></tr>
                        <tr><td>Order Date</td><td><fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></td></tr>
                        <tr><td>Payment Channel</td><td>${order.paymentMethod}</td></tr>
                        <tr><td>Order Status</td><td>${order.orderStatus}</td></tr>
                        <tr><td>Delivery Address</td><td>${order.userAddress}</td></tr>
                    </table>
                </div>
                <table class="items">
                    <thead>
                        <tr><th>Product</th><th>Quantity</th><th>Unit Price</th><th>Total</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.orderItems}">
                            <tr>
                                <td>${item.productName}</td>
                                <td>${item.quantity}</td>
                                <td>Rs. <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0"/></td>
                                <td>Rs. <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,##0"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="total-row">
                    Total Paid: Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                </div>
                <div class="footer">
                    <p>Thank you for building with NEO-HUB!</p>
                </div>
            </body>
            </html>
        `);
        printWindow.document.close();
        printWindow.addEventListener('load', function() {
            printWindow.focus();
            printWindow.addEventListener('afterprint', function() {
                printWindow.close();
            });
            printWindow.print();
        });
    }
    </script>
</body>
</html>