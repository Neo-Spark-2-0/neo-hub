<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Promotions" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="promos" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Offers & Promos" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h2 class="text-2xl font-bold">Promo Codes</h2>
                    <p class="text-xs text-gray-400 font-medium">Create discounts to increase sales</p>
                </div>
                <button onclick="toggleModal('addPromoModal')" class="bg-info text-white px-5 py-2.5 rounded-xl text-sm font-bold shadow-sm">
                    + Create Promo
                </button>
            </div>

            <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <table class="w-full text-left">
                    <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400">
                        <tr>
                            <th class="px-6 py-4">Promo Code</th>
                            <th class="px-6 py-4">Discount</th>
                            <th class="px-6 py-4">Valid Until</th>
                            <th class="px-6 py-4 text-center">Status</th>
                            <th class="px-6 py-4 text-right">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-secondary">
                        <c:forEach var="p" items="${promoList}">
                            <tr class="hover:bg-secondary/30 transition-colors">
                                <td class="px-6 py-4">
                                    <span class="bg-accent text-white px-3 py-1 rounded font-mono text-sm">${p.code}</span>
                                </td>
                                <td class="px-6 py-4 font-bold text-accent">
                                    ${p.discountType eq 'FIXED' ? 'Rs. ' : ''}${p.discountValue}${p.discountType eq 'PERCENTAGE' ? '%' : ''} OFF
                                    <div class="text-[10px] text-gray-400 font-normal mt-0.5">Min. Order: Rs. ${p.minOrderAmount}</div>
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-600">
                                    <fmt:parseDate value="${p.expiryDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="px-2 py-1 rounded-lg text-[10px] font-bold uppercase ${p.active ? 'bg-success/10 text-success' : 'bg-danger/10 text-danger'}">
                                        ${p.active ? 'Active' : 'Expired'}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <form id="delPromo-${p.id}" action="promos" method="POST">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="button" onclick="confirmAdminAction('Delete this promo code?', 'delPromo-${p.id}')" class="text-danger hover:underline text-xs font-bold">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    <!-- MODAL (Add Promo) - Pure Tailwind/Flowbite -->
    <div id="addPromoModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full bg-black/50">
        <div class="relative p-4 w-full max-w-md max-h-full">
            <div class="relative bg-white rounded-2xl shadow">
                <form action="promos" method="POST" class="p-6">
                    <input type="hidden" name="action" value="insert">
                    <h3 class="text-xl font-bold text-accent mb-6">New Promo Code</h3>
                    <div class="space-y-4">
                        <div>
                            <label class="block text-xs font-bold mb-2">Code (e.g. NEO2024)</label>
                            <input type="text" name="code" required class="w-full bg-secondary border-none rounded-xl py-3 text-sm">
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-bold mb-2">Type</label>
                                <select name="type" class="w-full bg-secondary border-none rounded-xl py-3 text-sm">
                                    <option value="PERCENTAGE">Percentage (%)</option>
                                    <option value="FIXED">Fixed (Rs.)</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-xs font-bold mb-2">Value</label>
                                <input type="number" name="value" required class="w-full bg-secondary border-none rounded-xl py-3 text-sm">
                            </div>
                        </div>
                        <div>
                            <label class="block text-xs font-bold mb-2">Expiry Date</label>
                            <input type="datetime-local" name="expiry" required class="w-full bg-secondary border-none rounded-xl py-3 text-sm">
                        </div>
                    </div>
                    <div class="flex gap-3 mt-8">
                        <button type="button" onclick="toggleModal('addPromoModal')" class="flex-1 bg-gray-100 py-3 rounded-xl text-sm font-bold">Cancel</button>
                        <button type="submit" class="flex-1 bg-accent text-white py-3 rounded-xl text-sm font-bold shadow-lg">Save Promo</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleModal(id) {
            document.getElementById(id).classList.toggle('hidden');
            document.getElementById(id).classList.toggle('flex');
        }
    </script>
</body>
</html>