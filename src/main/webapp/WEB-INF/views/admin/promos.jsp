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

            <!-- Page Header -->
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h2 class="text-2xl font-bold">Promo Codes</h2>
                    <p class="text-xs text-gray-400 font-medium mt-1">Create and manage discount codes</p>
                </div>
                <button onclick="toggleModal('addPromoModal')"
                        class="inline-flex items-center gap-2 bg-info text-white px-5 py-2.5 rounded-xl text-sm font-bold shadow-sm hover:opacity-90 transition">
                    <i class="fa-solid fa-plus text-xs"></i> Create Promo
                </button>
            </div>

            <!-- Flash Messages -->
            <c:if test="${not empty success}">
                <div class="mb-6 flex items-center gap-3 bg-success/10 border border-success/20 text-success px-5 py-4 rounded-2xl text-sm font-medium">
                    <i class="fa-solid fa-circle-check"></i>
                    ${success}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="mb-6 flex items-center gap-3 bg-danger/10 border border-danger/20 text-danger px-5 py-4 rounded-2xl text-sm font-medium">
                    <i class="fa-solid fa-circle-xmark"></i>
                    ${error}
                </div>
            </c:if>

            <!-- Promo Table -->
            <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">#</th>
                                <th class="px-6 py-4">Promo Code</th>
                                <th class="px-6 py-4">Discount</th>
                                <th class="px-6 py-4">Valid Until</th>
                                <th class="px-6 py-4 text-center">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                                <th class="px-6 py-4 text-right">Edit Promo</th>
                                
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-secondary text-sm">

                            <c:forEach var="p" items="${promoList}" varStatus="status">
                                <tr class="hover:bg-secondary/30 transition-colors">

                                    <!-- Index -->
                                    <td class="px-6 py-4 text-xs text-gray-400 font-medium">
                                        ${status.index + 1}
                                    </td>

                                    <!-- Code -->
                                    <td class="px-6 py-4">
                                        <span class="bg-accent text-white px-3 py-1.5 rounded-lg font-mono text-xs font-bold tracking-widest">
                                            ${p.code}
                                        </span>
                                    </td>

                                    <!-- Discount -->
                                    <td class="px-6 py-4">
                                        <span class="text-sm font-bold text-success">
                                            <fmt:formatNumber value="${p.discountPercent}" pattern="#,##0.##"/>% OFF
                                        </span>
                                    </td>

                                    <!-- Expiry Date -->
                                    <td class="px-6 py-4 text-sm text-gray-600">
                                        <%-- LocalDate doesn't work with fmt:formatDate, display directly --%>
                                        ${p.expiryDate}
                                    </td>
                                    
                                    <td class="px-6 py-4 text-center">
                                        <c:choose>
                                            <c:when test="${p.active}">
                                                <c:set var="toggleMsg"   value="Deactivate promo code" />
                                                <c:set var="toggleLabel" value="Active" />
                                                <c:set var="toggleClass" value="bg-success/10 text-success hover:bg-success hover:text-white" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="toggleMsg"   value="Activate promo code" />
                                                <c:set var="toggleLabel" value="Inactive" />
                                                <c:set var="toggleClass" value="bg-danger/10 text-danger hover:bg-danger hover:text-white" />
                                            </c:otherwise>
                                        </c:choose>

                                        <form id="togglePromo-${p.id}" action="promos" method="POST">
                                            <input type="hidden" name="action" value="toggleStatus">
                                            <input type="hidden" name="id"     value="${p.id}">
                                            <button type="button"
                                                    data-msg="${toggleMsg} ${p.code}?"
                                                    data-form="togglePromo-${p.id}"
                                                    onclick="handleConfirm(this)"
                                                    class="px-3 py-1 rounded-lg text-[10px] font-bold uppercase transition ${toggleClass}">
                                                ${toggleLabel}
                                            </button>
                                        </form>
                                    </td>

                                    <!-- Delete -->
                                    <td class="px-6 py-4 text-right">
                                        <form id="delPromo-${p.id}" action="promos" method="POST">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id"     value="${p.id}">
                                            <button type="button"
                                                    data-msg="Permanently delete promo code ${p.code}?"
                                                    data-form="delPromo-${p.id}"
                                                    onclick="handleConfirm(this)"
                                                    class="w-9 h-9 flex items-center justify-center bg-danger/10 text-danger rounded-xl hover:bg-danger hover:text-white transition ml-auto"
                                                    title="Delete">
                                                <i class="fa-solid fa-trash-can text-xs"></i>
                                            </button>
                                        </form>
                                    </td>

                                    <!-- Edit --> 
                                     <td class="px-6 py-4 text-right">
                                        <div class="flex justify-end items-center gap-2">
                                            
                                            <%-- Edit button --%>
                                            <button type="button"
                                                    onclick="openEditModal('${p.id}', '${p.code}', '${p.discountPercent}', '${p.expiryDate}')"
                                                    class="w-9 h-9 flex items-center justify-center bg-info/10 text-info rounded-xl hover:bg-info hover:text-white transition"
                                                    title="Edit">
                                                <i class="fa-solid fa-pen-to-square text-xs"></i>
                                            </button>

                                            <%-- Delete (existing) --%>
                                            <form id="delPromo-${p.id}" action="promos" method="POST">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${p.id}">
                                                <button type="button"
                                                        data-msg="Permanently delete promo code ${p.code}?"
                                                        data-form="delPromo-${p.id}"
                                                        onclick="handleConfirm(this)"
                                                        class="w-9 h-9 flex items-center justify-center bg-danger/10 text-danger rounded-xl hover:bg-danger hover:text-white transition ml-auto"
                                                        title="Delete">
                                                    <i class="fa-solid fa-trash-can text-xs"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <!-- Empty State -->
                            <c:if test="${empty promoList}">
                                <tr>
                                    <td colspan="6" class="px-6 py-20 text-center">
                                        <i class="fa-solid fa-ticket text-4xl text-gray-200 mb-4 block"></i>
                                        <p class="text-gray-400 italic text-sm">No promo codes found.</p>
                                        <button onclick="toggleModal('addPromoModal')"
                                                class="mt-4 inline-flex items-center gap-2 bg-info text-white px-4 py-2 rounded-xl text-xs font-bold">
                                            <i class="fa-solid fa-plus"></i> Create First Promo
                                        </button>
                                    </td>
                                </tr>
                            </c:if>

                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    <!-- ── ADD PROMO MODAL ─────────────────────────────────────────────── -->
    <div id="addPromoModal"
         tabindex="-1"
         aria-hidden="true"
         class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">

        <div class="relative w-full max-w-md mx-4">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden">

                <!-- Modal Header -->
                <div class="flex items-center justify-between px-8 py-6 border-b border-gray-100">
                    <div>
                        <h3 class="text-lg font-bold text-accent">New Promo Code</h3>
                        <p class="text-xs text-gray-400 mt-0.5">Create a discount code for customers</p>
                    </div>
                    <button onclick="toggleModal('addPromoModal')"
                            class="w-8 h-8 flex items-center justify-center rounded-xl bg-gray-100 hover:bg-gray-200 transition">
                        <i class="fa-solid fa-xmark text-xs text-gray-500"></i>
                    </button>
                </div>

                <!-- Modal Form -->
                <form action="promos" method="POST" class="px-8 py-6 space-y-5">
                    <input type="hidden" name="action" value="insert">

                    <!-- Code -->
                    <div>
                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">
                            Promo Code*
                        </label>
                        <input type="text" name="code" required
                               maxlength="20"
                               placeholder="e.g. SAVE20"
                               style="text-transform: uppercase;"
                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-mono font-bold focus:ring-2 focus:ring-info tracking-widest">
                        <p class="text-[10px] text-gray-400 mt-1">Letters and numbers only, max 20 characters</p>
                    </div>

                    <!-- Discount Percent -->
                    <div>
                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">
                            Discount Percentage* (1–100)
                        </label>
                        <div class="relative">
                            <input type="number" name="discountPercent" required
                                   min="1" max="100" step="0.01"
                                   placeholder="e.g. 15"
                                   class="w-full bg-secondary border-none rounded-xl py-3 px-4 pr-10 text-sm font-bold focus:ring-2 focus:ring-info">
                            <span class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 font-bold text-sm">%</span>
                        </div>
                    </div>

                    <!-- Expiry Date -->
                    <div>
                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">
                            Expiry Date*
                        </label>
                        <input type="date" name="expiry" required
                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                        <p class="text-[10px] text-gray-400 mt-1">Code will automatically expire after this date</p>
                    </div>

                    <!-- Actions -->
                    <div class="flex gap-3 pt-2">
                        <button type="button"
                                onclick="toggleModal('addPromoModal')"
                                class="flex-1 bg-gray-100 text-gray-500 py-3 rounded-xl text-sm font-bold hover:bg-gray-200 transition">
                            Cancel
                        </button>
                        <button type="submit"
                                class="flex-1 bg-accent text-white py-3 rounded-xl text-sm font-bold shadow-lg shadow-accent/20 hover:opacity-90 transition">
                            Save Promo
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>


// ── EDIT PROMO MODAL ─────────────────────────────────────────────── -->
    <div id="editPromoModal"
     tabindex="-1"
     aria-hidden="true"
     class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">

    <div class="relative w-full max-w-md mx-4">
        <div class="bg-white rounded-3xl shadow-2xl overflow-hidden">

            <div class="flex items-center justify-between px-8 py-6 border-b border-gray-100">
                <div>
                    <h3 class="text-lg font-bold text-accent">Edit Promo Code</h3>
                    <p class="text-xs text-gray-400 mt-0.5">Update discount code details</p>
                </div>
                <button onclick="toggleModal('editPromoModal')"
                        class="w-8 h-8 flex items-center justify-center rounded-xl bg-gray-100 hover:bg-gray-200 transition">
                    <i class="fa-solid fa-xmark text-xs text-gray-500"></i>
                </button>
            </div>

            <form action="promos" method="POST" class="px-8 py-6 space-y-5">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="edit-id">

                <div>
                    <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">
                        Promo Code*
                    </label>
                    <input type="text" name="code" id="edit-code" required
                           maxlength="20"
                           style="text-transform: uppercase;"
                           class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-mono font-bold focus:ring-2 focus:ring-info tracking-widest">
                </div>

                <div>
                    <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">
                        Discount Percentage* (1–100)
                    </label>
                    <div class="relative">
                        <input type="number" name="discountPercent" id="edit-discount" required
                               min="1" max="100" step="0.01"
                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 pr-10 text-sm font-bold focus:ring-2 focus:ring-info">
                        <span class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 font-bold text-sm">%</span>
                    </div>
                </div>

                <div>
                    <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">
                        Expiry Date*
                    </label>
                    <input type="date" name="expiry" id="edit-expiry" required
                           class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                </div>

                <div class="flex gap-3 pt-2">
                    <button type="button"
                            onclick="toggleModal('editPromoModal')"
                            class="flex-1 bg-gray-100 text-gray-500 py-3 rounded-xl text-sm font-bold hover:bg-gray-200 transition">
                        Cancel
                    </button>
                    <button type="submit"
                            class="flex-1 bg-accent text-white py-3 rounded-xl text-sm font-bold shadow-lg shadow-accent/20 hover:opacity-90 transition">
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

    <!-- Flash toast + modal script -->
    <script>
    function toggleModal(id) {
        const modal = document.getElementById(id);
        modal.classList.toggle('hidden');
    }

    function handleConfirm(btn) {
        if (confirm(btn.dataset.msg)) {
            document.getElementById(btn.dataset.form).submit();
        }
    }

    function openEditModal(id, code, discount, expiry) {
        document.getElementById('edit-id').value = id;
        document.getElementById('edit-code').value = code;
        document.getElementById('edit-discount').value = discount;
        document.getElementById('edit-expiry').value = expiry;
        toggleModal('editPromoModal');
    }

    document.getElementById('addPromoModal').addEventListener('click', function(e) {
        if (e.target === this) toggleModal('addPromoModal');
    });

    document.getElementById('editPromoModal').addEventListener('click', function(e) {
        if (e.target === this) toggleModal('editPromoModal');
    });

    document.querySelector('#addPromoModal input[name="code"]').addEventListener('input', function() {
        this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
    });

    window.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        document.querySelector('#addPromoModal input[name="expiry"]').min = today;
        document.querySelector('#editPromoModal input[name="expiry"]').min = today;

        <c:if test="${not empty success}">
            showToast('<c:out value="${success}"/>', "success");
        </c:if>
        <c:if test="${not empty error}">
            showToast('<c:out value="${error}"/>', "error");
        </c:if>
    });
</script>

</body>
</html>