<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="Order #${order.id} - NEO-HUB" />
        <jsp:param name="metaDescription" value="View details of your order ${order.id}" />
        <jsp:param name="metaKeywords" value="order details, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
</head>
<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20">
        <div class="flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/order-history" 
               class="inline-flex items-center gap-1 text-sm text-gray-500 hover:text-accent transition mb-6">
                <i class="fa-solid fa-arrow-left text-xs"></i> Back to Orders
            </a>
            <c:if test="${order.orderStatus == 'Confirmed' or order.orderStatus == 'Delivered' or order.orderStatus == 'Shipped' or order.orderStatus == 'Processing'}">
                <button onclick="printInvoice()" class="inline-flex items-center gap-2 bg-gray-200 text-gray-600 px-4 py-2 rounded-xl text-sm font-semibold hover:bg-gray-300 transition ml-4">
                <i class="fa-solid fa-download"></i> Download Invoice 
                </button>
            </c:if>
        </div>

        <h1 class="text-2xl md:text-3xl font-bold text-accent mb-6">Order #${order.id}</h1>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
            <!-- order info  -->
            <div class="bg-white rounded-2xl border border-gray-200 p-6">
                <h3 class="text-sm font-bold text-accent mb-4">Order Information</h3>
                <div class="space-y-3 text-sm">
                    <div class="flex justify-between">
                        <span class="text-gray-500">Date:</span>
                        <span class="font-medium"><fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-500">Status:</span>
                        <c:choose>
                            <c:when test="${order.orderStatus == 'Delivered'}">
                                <span class="inline-block px-2 py-1 text-xs font-semibold bg-green-100 text-green-700 rounded-full">Delivered</span>
                            </c:when>
                            <c:when test="${order.orderStatus == 'Cancelled'}">
                                <span class="inline-block px-2 py-1 text-xs font-semibold bg-red-100 text-red-700 rounded-full">Cancelled</span>
                            </c:when>
                            <c:when test="${order.orderStatus == 'Shipped'}">
                                <span class="inline-block px-2 py-1 text-xs font-semibold bg-blue-100 text-blue-700 rounded-full">Shipped</span>
                            </c:when>
                            <c:when test="${order.orderStatus == 'Processing'}">
                                <span class="inline-block px-2 py-1 text-xs font-semibold bg-yellow-100 text-yellow-700 rounded-full">Processing</span>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-block px-2 py-1 text-xs font-semibold bg-gray-100 text-gray-700 rounded-full">${order.orderStatus}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-500">Payment Method:</span>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'Khalti'}">
                                <span class="font-medium text-red-600"><i class="fa-solid fa-paper-plane text-[#DC0019]"></i></i> Khalti</span>
                            </c:when>
                            <c:otherwise>
                                <span class="font-medium text-green-600"><i class="fa-solid fa-money-bill-wave mr-1"></i> Cash on Delivery</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-500">Payment Status:</span>
                        <c:choose>
                            <c:when test="${order.paymentStatus == 'Completed'}">
                                <span class="text-green-600 font-medium"><i class="fa-solid fa-circle-check"></i> Completed</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-yellow-600 font-medium"><i class="fa-solid fa-clock"></i> ${order.paymentStatus}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${not empty order.transactionId}">
                        <div class="flex justify-between">
                            <span class="text-gray-500">Transaction ID:</span>
                            <span class="font-mono text-xs">${order.transactionId}</span>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- delivery  -->
            <div class="bg-white rounded-2xl border border-gray-200 p-6">
                <h3 class="text-sm font-bold text-accent mb-4">Delivery Address</h3>
                <div class="space-y-1 text-sm">
                    <p class="font-semibold text-accent">${order.userFullName}</p>
                    <p class="text-gray-600">${order.userPhone}</p>
                    <p class="text-gray-500">${order.userAddress}</p>
                </div>
            </div>
        </div>

        <!-- ordered items -->
        <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden mb-6">
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="bg-gray-50 border-b border-gray-200">
                        <tr>
                            <th class="text-left py-4 px-5 font-semibold text-gray-600">Product</th>
                            <th class="text-left py-4 px-5 font-semibold text-gray-600">Image</th>
                            <th class="text-left py-4 px-5 font-semibold text-gray-600">Unit Price</th>
                            <th class="text-left py-4 px-5 font-semibold text-gray-600">Quantity</th>
                            <th class="text-left py-4 px-5 font-semibold text-gray-600">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.orderItems}">
                            <tr class="border-b border-gray-100 hover:bg-gray-50 transition">
                                <td class="py-4 px-5 font-medium text-accent">${item.productName}</td>
                                <td class="py-4 px-5">
                                    <c:choose>
                                        <c:when test="${not empty item.productImage}">
                                            <img src="${pageContext.request.contextPath}/uploads/${item.productImage}" 
                                                 alt="${item.productName}" 
                                                 class="w-12 h-12 object-cover rounded-lg"/>
                                        </c:when>
                                        <c:otherwise>
                                           <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg" 
                                                 alt="${item.productName}" 
                                                 class="w-12 h-12 object-cover rounded-lg"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-4 px-5 text-gray-600">Rs. <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0"/></td>
                                <td class="py-4 px-5">${item.quantity}</td>
                                <td class="py-4 px-5 font-semibold text-accent">Rs. <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,##0"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- price details -->
        <div class="bg-white rounded-2xl border border-gray-200 p-6 max-w-md ml-auto">
            <h3 class="text-sm font-bold text-accent mb-4">Order Summary</h3>
            <div class="space-y-2">
                <div class="flex justify-between text-sm">
                    <span class="text-gray-500">Subtotal</span>
                    <span class="font-medium">Rs. <fmt:formatNumber value="${order.subTotalAmount}" pattern="#,##0"/></span>
                </div>
                <div class="flex justify-between text-sm">
                    <span class="text-gray-500">Shipping</span>
                    <span class="font-medium">Rs. <fmt:formatNumber value="${order.shippingCharge}" pattern="#,##0"/></span>
                </div>
                <c:if test="${order.discountAmount > 0}">
                    <div class="flex justify-between text-sm">
                        <span class="text-green-600">Discount</span>
                        <span class="font-medium text-green-600">- Rs. <fmt:formatNumber value="${order.discountAmount}" pattern="#,##0"/></span>
                    </div>
                </c:if>
                <div class="border-t border-gray-200 pt-2 mt-2">
                    <div class="flex justify-between text-base font-bold">
                        <span class="text-accent">Total</span>
                        <span class="text-accent">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></span>
                    </div>
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
                <title>.</title>
                <style>
                    * { margin: 0; padding: 0; box-sizing: border-box; }
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