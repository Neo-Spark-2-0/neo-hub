<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Categories | NEO-HUB Admin" />
</jsp:include>

<body class="bg-slate-50 font-poppins text-slate-900 antialiased">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="categories" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Categories" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1 space-y-6">

            <!-- Page Header -->
            <div class="flex justify-between items-center">
                <div>
                    <h2 class="text-2xl font-black text-slate-900">Product Categories</h2>
                    <p class="text-xs text-slate-400 font-medium mt-1">Manage catalog taxonomy and product groupings.</p>
                </div>
                <a href="categories?action=add"
                   class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white px-5 py-3 rounded-2xl text-xs font-bold transition shadow-md active:scale-95">
                    <i class="fa-solid fa-plus text-brand-400 text-xs"></i>
                    New Category
                </a>
            </div>

            <!-- Category Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                <c:forEach var="category" items="${categoryList}">
                    <div class="bg-white rounded-3xl p-6 border border-slate-200/80 shadow-sm hover:shadow-md hover:border-slate-300 transition-all relative overflow-hidden">
                        
                        <div class="flex items-start justify-between mb-5">
                            <div class="w-14 h-14 bg-slate-100 rounded-2xl overflow-hidden border border-slate-200">
                                <c:choose>
                                    <c:when test="${not empty category.image}">
                                        <img src="${pageContext.request.contextPath}/uploads/${category.image}"
                                             alt="${category.name}" class="w-full h-full object-cover"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/images/category-fallback.jpg"
                                             alt="${category.name}" class="w-full h-full object-cover"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <span class="text-[10px] font-extrabold uppercase px-2.5 py-1 rounded-xl border
                                ${category.active ? 'bg-emerald-50 text-emerald-600 border-emerald-100' : 'bg-slate-100 text-slate-400 border-slate-200'}">
                                ${category.active ? 'Active' : 'Disabled'}
                            </span>
                        </div>
                        
                        <h3 class="font-extrabold text-slate-900 text-sm mb-1">${category.name}</h3>
                        <p class="text-xs text-slate-400 font-medium leading-relaxed mb-5">
                            ${fn:substring(category.description, 0, 80)}...
                        </p>

                        <div class="flex gap-2">
                            <a href="categories?action=edit&id=${category.id}"
                               class="flex-1 text-center bg-slate-100 hover:bg-slate-200 text-slate-700 py-2.5 rounded-2xl text-xs font-bold transition">
                                <i class="fa-solid fa-pen-to-square mr-1 text-brand-500"></i> Edit
                            </a>
                            <form id="delCat-${category.id}" action="${pageContext.request.contextPath}/admin/categories" method="POST" class="flex-1 m-0">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${category.id}">
                                <button type="button"
                                        onclick="confirmAdminAction('Delete category? All associated products may be affected.', 'delCat-${category.id}')"
                                        class="w-full bg-red-50 border border-red-100 text-red-600 py-2.5 rounded-2xl text-xs font-bold hover:bg-red-500 hover:text-white transition">
                                    <i class="fa-solid fa-trash-can mr-1"></i> Delete
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty categoryList}">
                    <div class="md:col-span-3 bg-white rounded-3xl p-16 border border-slate-200/80 text-center">
                        <i class="fa-solid fa-tags text-slate-200 text-4xl mb-3 block"></i>
                        <p class="text-slate-400 text-sm font-medium">No categories created yet.</p>
                    </div>
                </c:if>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    <script>
        window.onload = function() {
            <c:if test="${not empty success}">
                showToast('<c:out value="${success}" />', "success");
            </c:if>
            <c:if test="${not empty error}">
                showToast('<c:out value="${error}" />', "error");
            </c:if>
        };
    </script>

</body>
</html>