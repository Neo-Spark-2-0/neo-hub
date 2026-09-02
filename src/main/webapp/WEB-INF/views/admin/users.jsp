<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="User Management" />
</jsp:include>

<body class="bg-slate-50 font-poppins text-slate-900 antialiased">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="users" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Users" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1 space-y-6">
            <div>
                <h2 class="text-2xl font-black text-slate-900">Customers &amp; Admins</h2>
                <p class="text-xs text-slate-400 font-medium mt-1">Manage user permissions and account statuses.</p>
            </div>

            <div class="bg-white rounded-3xl shadow-sm border border-slate-200/80 overflow-hidden">
                <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-slate-50 text-[10px] uppercase font-extrabold text-slate-400 tracking-wider">
                        <tr>
                            <th class="px-6 py-4">User</th>
                            <th class="px-6 py-4">Contact</th>
                            <th class="px-6 py-4 text-center">Role</th>
                            <th class="px-6 py-4 text-center">Verification</th>
                            <th class="px-6 py-4 text-center">Status</th>
                            <th class="px-6 py-4 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-xs font-medium">
                        <c:forEach var="user" items="${userList}">
                            <tr class="hover:bg-slate-50/60 transition-colors">
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 rounded-xl bg-slate-100 overflow-hidden border border-slate-200">
                                            <c:choose>
                                                <c:when test="${not empty user.profileImage}">
                                                <img src="${pageContext.request.contextPath}/uploads/${user.profileImage}" alt="Photo" class="w-full h-full object-cover"/>
                                                </c:when>
                                                <c:otherwise>
                                                <span class="text-sm font-extrabold text-slate-500 w-full h-full flex items-center justify-center">
                                                <c:set var="parts" value="${fn:split(user.fullName, ' ')}" />
                                                    ${fn:substring(parts[0], 0, 1)}
                                                    <c:if test="${fn:length(parts) > 1}">
                                                        ${fn:substring(parts[1], 0, 1)}
                                                    </c:if>
                                                </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div class="font-extrabold text-slate-900">${user.fullName}</div>
                                            <div class="text-[10px] text-slate-400">${user.email}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-slate-600">${user.phone}</td>
                                <td class="px-6 py-4 text-center">
                                    <span class="px-2.5 py-1 rounded-xl text-[10px] font-extrabold uppercase
                                        ${user.role eq 'ADMIN' ? 'bg-purple-50 text-purple-600 border border-purple-100' : 'bg-slate-100 text-slate-500 border border-slate-200'}">
                                        ${user.role}
                                    </span>
                                </td>

                                <!-- email verification status -->
                                <td class="px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${user.emailVerified}">
                                            <i class="fa-solid fa-circle-check text-emerald-500" title="Verified"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-circle-xmark text-slate-300" title="Unverified"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- toggle active/banned status -->
                                <td class="px-6 py-4 text-center">
                                    <form id="statusForm-${user.id}" action="${pageContext.request.contextPath}/admin/users" method="POST">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        
                                        <button type="button"
                                            onclick="confirmAdminAction('${user.active ? 'Ban' : 'Activate'}', '${user.fullName}', 'statusForm-${user.id}')"
                                            title="${user.active ? 'Click to ban user' : 'Click to activate user'}"
                                            class="inline-flex items-center gap-1 px-2.5 py-1 rounded-xl text-[10px] font-extrabold uppercase cursor-pointer transition
                                                ${user.active ? 'bg-emerald-50 text-emerald-600 border border-emerald-100 hover:bg-emerald-100' : 'bg-red-50 text-red-600 border border-red-100 hover:bg-red-100'}">
                                            <c:choose>
                                                <c:when test="${user.active}">
                                                    <i class="fa-solid fa-circle-check text-[10px]"></i> Active
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa-solid fa-ban text-[10px]"></i> Banned
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </form>
                                </td>

                                <!-- delete user, but not self -->
                                <td class="px-6 py-4 text-right">
                                    <c:if test="${user.id != sessionScope.user.id}">
                                        <form id="deleteForm-${user.id}" action="${pageContext.request.contextPath}/admin/users" method="POST">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <button type="button"
                                                onclick="confirmDelete('${user.fullName}', 'deleteForm-${user.id}')"
                                                class="w-8 h-8 flex items-center justify-center bg-red-50 text-red-600 border border-red-100 rounded-xl hover:bg-red-500 hover:text-white transition">
                                                <i class="fa-solid fa-trash-can text-xs"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    <script>
        <!-- Handle confirmation for admin actions -->
        function confirmAdminAction(actionLabel, userName, formId) {
            const isActivating = actionLabel === 'Activate';
            Swal.fire({
                title: actionLabel + " User?",
                text: isActivating
                    ? "This will restore access for " + userName + "."
                    : "This will revoke access for " + userName + ".",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: isActivating ? "#22c55e" : "#ef4444",
                cancelButtonColor: "#6b7280",
                confirmButtonText: "Yes, " + actionLabel
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById(formId).submit();
                }
            });
        }

        <!-- Handle confirmation for delete action -->
        function confirmDelete(userName, formId) {
            Swal.fire({
                title: "Delete " + userName + "?",
                text: "This action cannot be undone!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#ef4444",
                cancelButtonColor: "#6b7280",
                confirmButtonText: "Yes, delete it"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById(formId).submit();
                }
            });
        }

            <!-- Show flash messages -->       
        <c:if test="${not empty success}">
            showToast('<c:out value="${success}"/>', "success");
        </c:if>
        <c:if test="${not empty error}">
            showToast('<c:out value="${error}"/>', "error");
        </c:if>

    </script>

</body>
</html>