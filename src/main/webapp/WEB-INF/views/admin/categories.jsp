<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Categories" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="categories" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Categories" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="flex justify-between items-center mb-8">
                <h2 class="text-2xl font-bold">Product Categories</h2>
                <a href="categories?action=add" class="bg-info text-white px-5 py-2.5 rounded-xl text-sm font-bold shadow-lg shadow-info/20 hover:opacity-90 transition-all">
                    + New Category
                </a>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="category" items="${categoryList}">
                    <div class="bg-primary rounded-2xl p-6 border border-gray-100 shadow-sm hover:shadow-md transition-all relative overflow-hidden group">
                        <div class="flex items-start justify-between mb-4">
                            <div class="w-14 h-14 bg-secondary rounded-xl overflow-hidden border border-gray-50">
                                <c:choose>
                                    <c:when test="${not empty category.image}">
                                        <img
                                        src="${pageContext.request.contextPath}/uploads/${category.image}"
                                        alt="${category.name}"
                                        class="w-full h-full object-cover rounded-xl"
                                        />
                                    </c:when>
                                    <c:otherwise>
                                        <img
                                        src="${pageContext.request.contextPath}/static/images/category-fallback.jpg"
                                        alt="${category.name}"
                                        class="w-full h-full object-cover rounded-xl"
                                        />
                                    </c:otherwise>
                                </c:choose>
                                
                            </div>
                            <span class="text-[10px] font-bold uppercase px-2 py-1 rounded-lg ${category.active ? 'bg-success/10 text-success' : 'bg-gray-100 text-gray-400'}">
                                ${category.active ? 'Active' : 'Disabled'}
                            </span>
                        </div>
                        
                        <h3 class="font-bold text-accent mb-1">${category.name}</h3>
                        <p class="text-xs text-gray-400 leading-relaxed mb-6">
                            ${fn:substring(category.description, 0, 80)}...
                        </p>

                        <div class="flex gap-2">
                            <a href="categories?action=edit&id=${category.id}" class="flex-1 text-center bg-secondary text-accent py-2 rounded-lg text-xs font-bold hover:bg-gray-200 transition">
                                <i class="fa-solid fa-pen-to-square mr-1"></i> Edit
                            </a>
                            <form id="delCat-${category.id}" action="categories" method="POST" class="flex-1 m-0">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${category.id}">
                                <button type="button" onclick="confirmAdminAction('Delete category? All associated products may be affected.', 'delCat-${category.id}')"
                                    class="w-full bg-danger/10 text-danger py-2 rounded-lg text-xs font-bold hover:bg-danger hover:text-white transition">
                                    <i class="fa-solid fa-trash-can mr-1"></i> Delete
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>