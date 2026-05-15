<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="Order Placed - NEO-HUB" />
        <jsp:param name="metaDescription" value="Your order has been placed successfully!" />
        <jsp:param name="metaKeywords" value="order success, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="home" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">
        <div class="max-w-[100%] lg:max-w-[60vw] mx-auto">
            <div class="bg-white rounded-2xl border border-gray-200 p-8 text-center">

                <!-- icon tick  -->
                <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <i class="fa-solid fa-check text-green-600 text-3xl"></i>
                </div>
                
                <h1 class="text-2xl md:text-3xl font-bold text-accent mb-2">Order Placed Successfully!</h1>
                <p class="text-gray-500 mb-6">Thank you for your purchase. Your order has been received.</p>

                <!--order id, delivery box -->
                <div class="bg-gray-50 rounded-xl p-6 mb-6 text-left">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Order ID</p>
                            <p class="text-lg font-bold text-accent">#${order.id}</p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Payment Method</p>
                            <p class="text-lg font-semibold">
                                <c:choose>
                                    <c:when test="${order.paymentMethod == 'Khalti'}">
                                        <span class="text-red-600"><i class="fa-solid fa-paper-plane text-[#DC0019]"></i>  Khalti Wallet</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-green-600"><i class="fa-solid fa-money-bill-wave mr-1"></i> Cash on Delivery</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Order Status</p>
                            <p class="text-lg font-semibold">
                                <c:choose>
                                    <c:when test="${order.orderStatus == 'Confirmed'}">
                                        <span class="text-green-600"><i class="fa-solid fa-circle-check mr-1"></i> Confirmed</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-blue-600">${order.orderStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-400 uppercase tracking-wide mb-1">Delivery Address</p>
                            <p class="text-sm text-gray-600">${order.userAddress}</p>
                        </div>
                    </div>
                </div>

                <!-- ordered items -->
                <div class="border-t border-gray-200 pt-6 mb-6">
                    <h3 class="text-lg font-semibold text-accent mb-4 text-left">Order Items</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="text-left py-3 px-4 font-semibold text-gray-600">Product</th>
                                    <th class="text-center py-3 px-4 font-semibold text-gray-600">Quantity</th>
                                    <th class="text-right py-3 px-4 font-semibold text-gray-600">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.orderItems}">
                                    <tr class="border-b border-gray-100">
                                        <td class="py-3 px-4 text-left font-medium text-accent">${item.productName}</td>
                                        <td class="py-3 px-4 text-center">${item.quantity}</td>
                                        <td class="py-3 px-4 text-right">Rs. <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,##0"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-gray-50">
                                <tr class="border-t border-gray-200">
                                    <td colspan="2" class="py-3 px-4 text-right font-bold text-accent">Total Paid:</td>
                                    <td class="py-3 px-4 text-right font-bold text-accent">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!-- buttons -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/order-history" 
                       class="inline-flex items-center justify-center gap-2 bg-accent text-white px-6 py-3 rounded-xl font-semibold hover:opacity-90 transition">
                        <i class="fa-solid fa-receipt"></i> View My Orders
                    </a>
                    <button class="inline-flex items-center justify-center gap-2 bg-gray-200 text-gray-600 px-6 py-3 rounded-xl font-semibold hover:bg-gray-300 transition" onclick="printInvoice()">
                        <i class="fa-solid fa-download"></i> Download Invoice
                    </button>
                </div>
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
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
                    body {
                        font-family: 'Poppins', sans-serif;
                        padding: 40px;
                        background: white;
                    }
                    .invoice-header {
                        text-align: center;
                        margin-bottom: 30px;
                        padding-bottom: 20px;
                        border-bottom: 2px solid #1D1D1F;
                    }
                    .invoice-header h1 {
                        font-size: 28px;
                        color: #1D1D1F;
                        margin-bottom: 5px;
                    }
                    .invoice-header p {
                        color: #666;
                        font-size: 12px;
                    }
                    .order-details {
                        margin-bottom: 30px;
                    }
                    .order-details table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    .order-details td {
                        padding: 6px 0;
                        font-size: 14px;
                    }
                    .order-details td:first-child {
                        width: 120px;
                        font-weight: 600;
                        color: #555;
                    }
                    table.items {
                        width: 100%;
                        margin: 20px 0;
                    }
                    table.items th {
                        background: #f5f5f5;
                        padding: 10px;
                        text-align: left;
                        font-size: 13px;
                        font-weight: 600;
                        border-bottom: 1px solid #ddd;
                    }
                    table.items td {
                        padding: 8px 10px;
                        font-size: 13px;
                        border-bottom: 1px solid #eee;
                    }
                    .total-row {
                        text-align: right;
                        font-weight: bold;
                        font-size: 16px;
                        margin-top: 20px;
                        padding-top: 10px;
                        border-top: 2px solid #1D1D1F;
                    }
                    .footer {
                        text-align: center;
                        margin-top: 40px;
                        font-size: 11px;
                        color: #aaa;
                    }
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
                        <tr><td>Payment Method</td><td>${order.paymentMethod}</td></tr>
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
                    <p>Thank you for shopping with NEO-HUB!</p>
                    <p>For any queries, contact neohubnepal@gmail.com</p>
                </div>
            </body>
            </html>
        `);
        
        printWindow.document.close();
        printWindow.addEventListener('load', function () {
            printWindow.focus();

            // we are keeping this after print to close window after print and 
            // we keep this inside load event because it should be proper loaded before close
        printWindow.addEventListener('afterprint', function () {
            printWindow.close();
        });

        printWindow.print();
        });
        
    }
    </script>
</body>
</html>