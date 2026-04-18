<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="User Management" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="users" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Users" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h2 class="text-2xl font-bold">System Users</h2>
                    <p class="text-xs text-gray-500 font-medium">Manage permissions and account statuses</p>
                </div>
            </div>

            <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <table class="w-full text-left">
                    <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400 tracking-wider">
                        <tr>
                            <th class="px-6 py-4">User</th>
                            <th class="px-6 py-4">Contact</th>
                            <th class="px-6 py-4 text-center">Role</th>
                            <th class="px-6 py-4 text-center">Verification</th>
                            <th class="px-6 py-4 text-center">Status</th>
                            <th class="px-6 py-4 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-secondary text-sm">
                        <c:forEach var="u" items="${userList}">
                            <tr class="hover:bg-secondary/30 transition-colors">
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 rounded-full bg-secondary overflow-hidden border border-gray-100">
                                            <img src="${pageContext.request.contextPath}/${not empty u.profileImage ? u.profileImage : 'static/images/default-user.png'}" class="w-full h-full object-cover">
                                        </div>
                                        <div>
                                            <div class="font-bold text-accent">${u.fullName}</div>
                                            <div class="text-[11px] text-gray-400">${u.email}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-gray-600">${u.phone}</td>
                                <td class="px-6 py-4 text-center">
                                    <span class="px-2 py-1 rounded-lg text-[10px] font-bold uppercase ${u.role eq 'ADMIN' ? 'bg-accent text-white' : 'bg-gray-100 text-gray-500'}">
                                        ${u.role}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${u.emailVerified}">
                                            <i class="fa-solid fa-circle-check text-success" title="Verified"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-circle-xmark text-gray-300" title="Unverified"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <form id="statusForm-${u.id}" action="users" method="POST">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="userId" value="${u.id}">
                                        <button type="button" onclick="confirmAdminAction('Change this user status?', 'statusForm-${u.id}')"
                                            class="px-2 py-1 rounded-lg text-[10px] font-bold uppercase ${u.active ? 'bg-success/10 text-success' : 'bg-danger/10 text-danger'}">
                                            ${u.active ? 'Active' : 'Banned'}
                                        </button>
                                    </form>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <c:if test="${u.id != sessionScope.user.id}">
                                        <form id="delUser-${u.id}" action="users" method="POST">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="userId" value="${u.id}">
                                            <button type="button" onclick="confirmAdminAction('Permanently delete this user?', 'delUser-${u.id}')"
                                                    class="text-danger hover:bg-danger/10 p-2 rounded-lg transition">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>