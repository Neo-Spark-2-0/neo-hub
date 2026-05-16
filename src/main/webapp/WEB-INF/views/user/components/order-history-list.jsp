<table class="w-full text-sm" id="order-table">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Order ID</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Date</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Total</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Payment</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Status</th>
                                    <th class="text-left py-4 px-5 font-semibold text-gray-600">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr class="border-b border-gray-100 hover:bg-gray-50 transition">
                                        <td class="py-4 px-5 font-medium text-accent">#${order.id}</td>
                                        <td class="py-4 px-5 text-gray-600">
                                            <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td class="py-4 px-5 font-semibold text-accent">
                                            Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                                        </td>
                                        <td class="py-4 px-5">
                                            <c:choose>
                                                <c:when test="${order.paymentMethod == 'Khalti'}">
                                                    <span class="inline-flex items-center gap-1 text-red-600">
                                                        <i class="fa-solid fa-paper-plane text-[#DC0019]"></i>Khalti
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center gap-1 text-green-600">
                                                        <i class="fa-solid fa-money-bill-wave"></i> COD
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="py-4 px-5">
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
                                        </td>
                                        <td class="py-4 px-5">
                                            <a href="${pageContext.request.contextPath}/order-history?action=view&id=${order.id}"
                                               class="text-accent hover:text-accent/70 text-sm font-medium transition">
                                                View Details →
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>