<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Promotions" />
</jsp:include>

<body class="bg-slate-50 font-poppins text-slate-900 antialiased">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="promos" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Offers &amp; Promos" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1 space-y-6">

            <!-- Page Header -->
            <div class="flex justify-between items-center">
                <div>
                    <h2 class="text-2xl font-black text-slate-900">Promo Codes</h2>
                    <p class="text-xs text-slate-400 font-medium mt-1">Create and manage discount codes for customers.</p>
                </div>
                <button onclick="toggleModal('addPromoModal')"
                        class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white px-5 py-3 rounded-2xl text-xs font-bold transition shadow-md active:scale-95">
                    <i class="fa-solid fa-plus text-brand-400 text-xs"></i> Create Promo
                </button>
            </div>

            <!-- Promo Table -->
            <div class="bg-white rounded-3xl shadow-sm border border-slate-200/80 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-[10px] uppercase font-extrabold text-slate-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">#</th>
                                <th class="px-6 py-4">Promo Code</th>
                                <th class="px-6 py-4">Discount</th>
                                <th class="px-6 py-4">Valid Until</th>
                                <th class="px-6 py-4 text-center">Status</th>
                                <th class="px-6 py-4 text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 text-xs font-medium">

                            <c:forEach var="promo" items="${promoList}" varStatus="status">
                                <tr class="hover:bg-slate-50/60 transition-colors">

                                    <!-- Index -->
                                    <td class="px-6 py-4 text-slate-400 font-medium">
                                        ${status.index + 1}
                                    </td>

                                    <!-- Code -->
                                    <td class="px-6 py-4">
                                        <span class="bg-slate-900 text-white px-3 py-1.5 rounded-xl font-mono text-xs font-extrabold tracking-widest">
                                            ${promo.code}
                                        </span>
                                    </td>

                                    <!-- Discount -->
                                    <td class="px-6 py-4">
                                        <span class="text-sm font-extrabold text-emerald-600">
                                            <fmt:formatNumber value="${promo.discountPercent}" pattern="#,##0.##"/>% OFF
                                        </span>
                                    </td>

                                    <!-- Expiry Date -->
                                    <td class="px-6 py-4 text-slate-600">
                                        ${promo.expiryDate}
                                    </td>
                                    
                                    <!-- Status -->
                                    <td class="px-6 py-4 text-center">
                                        <c:choose>
                                            <c:when test="${promo.active}">
                                                <c:set var="toggleMsg"   value="Deactivate promo code" />
                                                <c:set var="toggleLabel" value="Active" />
                                                <c:set var="toggleClass" value="bg-emerald-50 text-emerald-600 border border-emerald-100 hover:bg-emerald-100" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="toggleMsg"   value="Activate promo code" />
                                                <c:set var="toggleLabel" value="Inactive" />
                                                <c:set var="toggleClass" value="bg-red-50 text-red-600 border border-red-100 hover:bg-red-100" />
                                            </c:otherwise>
                                        </c:choose>

                                        <form id="togglePromo-${promo.id}" action="${pageContext.request.contextPath}/admin/promos" method="POST">
                                            <input type="hidden" name="action" value="toggleStatus">
                                            <input type="hidden" name="id"     value="${promo.id}">
                                            <button type="button"
                                                    data-form="togglePromo-${promo.id}"
                                                    data-action="${promo.active ? 'Deactivate' : 'Activate'}"
                                                    data-code="${promo.code}"
                                                    data-active="${promo.active}"
                                                    onclick="confirmPromoStatus(this)"
                                                    title="${promo.active ? 'Click to deactivate' : 'Click to activate'}"
                                                    class="inline-flex items-center gap-1 px-2.5 py-1 rounded-xl text-[10px] font-extrabold uppercase cursor-pointer transition ${toggleClass}">
                                                <c:choose>
                                                    <c:when test="${promo.active}">
                                                        <i class="fa-solid fa-circle-check text-[10px]"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa-solid fa-ban text-[10px]"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                ${toggleLabel}
                                            </button>
                                        </form>
                                    </td>

                                    <!-- Edit & Delete -->
                                    <td class="px-6 py-4 text-center">
                                        <div class="flex justify-center items-center gap-2">
                                            <%-- Edit button --%>
                                            <button type="button"
                                                    onclick="openEditModal('${promo.id}', '${promo.code}', '${promo.discountPercent}', '${promo.expiryDate}')"
                                                    class="w-8 h-8 flex items-center justify-center bg-blue-50 text-blue-600 border border-blue-100 rounded-xl hover:bg-blue-600 hover:text-white transition"
                                                    title="Edit">
                                                <i class="fa-solid fa-pen-to-square text-xs"></i>
                                            </button>

                                            <%-- Delete --%>
                                            <form id="delPromo-${promo.id}" action="${pageContext.request.contextPath}/admin/promos" method="POST" class="inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id"     value="${promo.id}">
                                                <button type="button"
                                                        data-code="${promo.code}"
                                                        data-form="delPromo-${promo.id}"
                                                        onclick="handleConfirm(this)"
                                                        class="w-8 h-8 flex items-center justify-center bg-red-50 text-red-600 border border-red-100 rounded-xl hover:bg-red-500 hover:text-white transition"
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
                                        <i class="fa-solid fa-ticket text-4xl text-slate-200 mb-3 block"></i>
                                        <p class="text-slate-400 text-sm font-medium">No promo codes found.</p>
                                        <button onclick="toggleModal('addPromoModal')"
                                                class="mt-4 inline-flex items-center gap-2 bg-slate-900 text-white px-4 py-2 rounded-xl text-xs font-bold">
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
                <div class="flex items-center justify-between px-8 py-6 border-b border-slate-100">
                    <div>
                        <h3 class="text-lg font-extrabold text-slate-900">New Promo Code</h3>
                        <p class="text-xs text-slate-400 mt-0.5">Create a discount code for customers</p>
                    </div>
                    <button onclick="toggleModal('addPromoModal')"
                            class="w-8 h-8 flex items-center justify-center rounded-xl bg-slate-100 hover:bg-slate-200 transition">
                        <i class="fa-solid fa-xmark text-xs text-slate-500"></i>
                    </button>
                </div>

                <!-- Modal Form -->
                <form action="${pageContext.request.contextPath}/admin/promos" method="POST" class="px-8 py-6 space-y-5">
                    <input type="hidden" name="action" value="insert">

                    <!-- Code -->
                    <div class="space-y-1.5">
                        <label class="block text-[10px] font-extrabold text-slate-400 uppercase mb-2 tracking-widest">
                            Promo Code*
                        </label>
                        <input type="text" name="code" required
                               maxlength="20"
                               placeholder="e.g. SAVE20"
                               style="text-transform: uppercase;"
                               class="w-full bg-slate-50 border border-slate-200 rounded-2xl py-3 px-4 text-xs font-mono font-extrabold focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:bg-white transition tracking-widest">
                        <p class="text-[10px] text-slate-400">Letters and numbers only, max 20 characters</p>
                    </div>

                    <!-- Discount Percent -->
                    <div class="space-y-1.5">
                        <label class="block text-[10px] font-extrabold text-slate-400 uppercase mb-2 tracking-widest">
                            Discount Percentage* (1–100)
                        </label>
                        <div class="relative">
                            <input type="number" name="discountPercent" required
                                   min="1" max="100" step="0.01"
                                   placeholder="e.g. 15"
                                   class="w-full bg-slate-50 border border-slate-200 rounded-2xl py-3 px-4 pr-10 text-xs font-extrabold focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:bg-white transition">
                            <span class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 font-bold text-xs">%</span>
                        </div>
                    </div>

                    <!-- Expiry Date -->
                    <div class="space-y-1.5">
                        <label class="block text-[10px] font-extrabold text-slate-400 uppercase mb-2 tracking-widest">
                            Expiry Date*
                        </label>
                        <input type="date" name="expiry" required
                               class="w-full bg-slate-50 border border-slate-200 rounded-2xl py-3 px-4 text-xs focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:bg-white transition">
                        <p class="text-[10px] text-slate-400">Code will automatically expire after this date</p>
                    </div>

                    <!-- Actions -->
                    <div class="flex gap-3 pt-2">
                        <button type="button"
                                onclick="toggleModal('addPromoModal')"
                                class="flex-1 bg-slate-100 text-slate-500 py-3 rounded-2xl text-xs font-bold hover:bg-slate-200 transition">
                            Cancel
                        </button>
                        <button type="submit"
                                class="flex-1 bg-slate-900 hover:bg-slate-800 text-white py-3 rounded-2xl text-xs font-bold shadow-md transition">
                            Save Promo
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- EDIT PROMO MODAL -->
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

            <form action="${pageContext.request.contextPath}/admin/promos" method="POST" class="px-8 py-6 space-y-5">
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
        <!-- Toggle visibility of modals -->
    function toggleModal(id) {
        const modal = document.getElementById(id);
        modal.classList.toggle('hidden');
    }

    <!-- Handle confirmation for delete/toggle actions -->
    function handleConfirm(btn) {
        Swal.fire({
            title: "Delete Promo?",
            text: "Permanently delete promo code " + btn.dataset.code + "? This cannot be undone!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#ef4444",
            cancelButtonColor: "#6b7280",
            confirmButtonText: "Yes, delete it"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(btn.dataset.form).submit();
            }
        });
    }

    <!-- Handle confirmation for status toggle actions -->
    function confirmPromoStatus(btn) {
        const isActivating = btn.dataset.active === "false";
        Swal.fire({
            title: btn.dataset.action + " Promo?",
            text: (isActivating ? "Activate" : "Deactivate") + " promo code " + btn.dataset.code + "?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: isActivating ? "#22c55e" : "#ef4444",
            cancelButtonColor: "#6b7280",
            confirmButtonText: "Yes, " + btn.dataset.action
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(btn.dataset.form).submit();
            }
        });
    }

    <!-- Open edit modal and populate fields -->
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


        <!-- Show flash messages -->
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