<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Edit Category: ${category.name}" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="categories" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Edit Category" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="max-w-2xl mx-auto">
                
                <div class="flex items-center gap-4 mb-8">
                    <a href="categories" class="w-10 h-10 flex items-center justify-center bg-white rounded-xl shadow-sm hover:bg-gray-50 transition">
                        <i class="fa-solid fa-arrow-left text-xs"></i>
                    </a>
                    <h2 class="text-2xl font-bold text-accent">Modify Category</h2>
                </div>

                <form action="categories" method="POST" enctype="multipart/form-data" 
                      class="bg-primary p-10 rounded-[2.5rem] shadow-sm border border-gray-100 space-y-8">
                    
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${category.id}">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        
                        <div class="space-y-6">
                            <div>
                                <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">Category Name</label>
                                <input type="text" name="name" value="${category.name}" required 
                                       class="w-full bg-secondary border-none rounded-2xl py-4 px-5 text-sm font-bold focus:ring-2 focus:ring-info">
                            </div>

                            <div>
                                <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">Visibility</label>
                                <label class="flex items-center gap-3 cursor-pointer bg-secondary p-4 rounded-2xl">
                                    <input type="checkbox" name="isActive" ${category.active ? 'checked' : ''} class="w-6 h-6 rounded-lg border-gray-200 text-success focus:ring-success">
                                    <span class="text-sm font-bold text-gray-700">Display Category Online</span>
                                </label>
                            </div>
                        </div>

                        <div>
                            <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">Category Icon</label>
                            <div class="relative group">
                                <div class="w-full h-40 bg-secondary rounded-2xl overflow-hidden border border-dashed border-gray-200 flex items-center justify-center">
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
                                <div class="mt-4">
                                    <input type="file" name="image" 
                                           class="block w-full text-xs text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-[10px] file:font-bold file:bg-accent file:text-white">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">Short Description</label>
                        <textarea name="description" rows="4" 
                                  class="w-full bg-secondary border-none rounded-2xl py-4 px-5 text-sm focus:ring-2 focus:ring-info">${category.description}</textarea>
                    </div>

                    <div class="flex gap-4 pt-4">
                        <button type="submit" class="flex-1 bg-accent text-white py-4 rounded-2xl font-bold shadow-xl shadow-accent/10 hover:opacity-90 transition-all">Save Changes</button>
                        <a href="categories" class="flex-1 bg-gray-100 text-gray-500 py-4 rounded-2xl font-bold text-center hover:bg-gray-200 transition-all">Cancel</a>
                    </div>
                </form>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>