<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Order Confirmed! | NEO-HUB" />
    <jsp:param name="metaDescription" value="Your NEO-HUB order has been placed successfully!" />
    <jsp:param name="metaKeywords" value="order success, confirmed, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[92vw] max-w-4xl mx-auto py-12 pb-28 space-y-8">
        
        <!-- Celebration Card -->
        <div class="bg-white rounded-3xl border border-slate-200/80 p-8 sm:p-12 text-center shadow-card space-y-8">
            
            <!-- Success Animated Ring -->
            <div class="relative w-20 h-20 mx-auto">
                <div class="absolute inset-0 rounded-full bg-brand-500/20 animate-ping"></div>
                <div class="relative w-20 h-20 rounded-full bg-brand-50 text-brand-600 border border-brand-200 flex items-center justify-center text-3xl shadow-subtle">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
            </div>

            <div class="space-y-2">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand-50 border border-brand-200 text-brand-700 text-xs font-bold">
                    <i class="fa-solid fa-sparkles"></i> Order Confirmed
                </div>
                <h1 class="text-2xl sm:text-4xl font-extrabold text-slate-900 tracking-tight">
                    Thank You for Your Order!
                </h1>
                <p class="text-xs sm:text-sm text-slate-500 font-medium max-w-md mx-auto">
                    We've received your order and our hardware lab is already preparing your parcel.
                </p>
            </div>

            <!-- Order Key Details Grid -->
            <div class="bg-slate-50 rounded-2xl border border-slate-100 p-6 text-left grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4 text-xs font-medium">
                <div>
                    <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px] mb-1">Order Ref</span>
                    <span class="font-extrabold font-mono text-sm text-slate-900">#${order.id}</span>
                </div>
                <div>
                    <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px] mb-1">Payment Channel</span>
                    <c:choose>
                        <c:when test="${order.paymentMethod == 'Khalti'}">
                            <span class="font-bold text-purple-700 flex items-center gap-1">
                                <i class="fa-solid fa-wallet text-purple-600"></i> Khalti
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="font-bold text-emerald-700 flex items-center gap-1">
                                <i class="fa-solid fa-hand-holding-dollar text-emerald-600"></i> COD
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px] mb-1">Order Status</span>
                    <span class="inline-flex items-center gap-1 font-bold text-brand-700">
                        <i class="fa-solid fa-circle-check"></i> ${order.orderStatus}
                    </span>
                </div>
                <div>
                    <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px] mb-1">Total Paid</span>
                    <span class="font-extrabold text-sm text-slate-900">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></span>
                </div>
            </div>

            <!-- Shipping Destination Preview -->
            <div class="p-4 rounded-2xl bg-white border border-slate-200/80 text-left text-xs space-y-1">
                <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px]">Shipping Destination:</span>
                <p class="font-bold text-slate-800">${order.userFullName} &bull; ${order.userPhone}</p>
                <p class="text-slate-500 font-medium">${order.userAddress}</p>
            </div>

            <!-- Actions -->
            <div class="flex flex-col sm:flex-row items-center justify-center gap-3 pt-2">
                <a href="${pageContext.request.contextPath}/order-history?action=view&id=${order.id}"
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm px-6 py-3.5 rounded-2xl transition shadow-md">
                    <i class="fa-solid fa-receipt text-brand-400"></i>
                    <span>Track Order Progress</span>
                </a>
                <button onclick="printInvoice()"
                        class="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold text-xs sm:text-sm px-6 py-3.5 rounded-2xl transition">
                    <i class="fa-solid fa-print"></i>
                    <span>Print Receipt</span>
                </button>
                <a href="${pageContext.request.contextPath}/products"
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2 text-slate-500 hover:text-slate-900 font-bold text-xs sm:text-sm px-4 py-3.5 transition">
                    <span>Continue Browsing</span>
                    <i class="fa-solid fa-arrow-right text-xs"></i>
                </a>
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
        printWindow.addEventListener('load', function () {
            printWindow.focus();
            printWindow.addEventListener('afterprint', function () {
                printWindow.close();
            });
            printWindow.print();
        });
    }
    </script>
</body>
</html>