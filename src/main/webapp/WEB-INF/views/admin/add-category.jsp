<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Add Category" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="categories" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Add Category" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="max-w-2xl mx-auto">
                <div class="flex items-center gap-4 mb-8">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="w-10 h-10 flex items-center justify-center bg-white rounded-xl shadow-sm"><i class="fa-solid fa-arrow-left text-xs"></i></a>
                    <h2 class="text-2xl font-bold">New Category</h2>
                </div>

                <form action="${pageContext.request.contextPath}/admin/categories" method="POST" enctype="multipart/form-data" class="bg-primary p-8 rounded-2xl shadow-sm border border-gray-100 space-y-6">
                    <input type="hidden" name="action" value="insert">
                    
                    <div>
                        <label class="block text-xs font-bold mb-2 uppercase tracking-widest text-gray-400">Category Name*</label>
                        <input type="text" name="name" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                    </div>

                    <div>
                        <label class="block text-xs font-bold mb-2 uppercase tracking-widest text-gray-400">Description</label>
                        <textarea name="description" rows="4" class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info"></textarea>
                    </div>

                    <div>
                        <label class="block text-xs font-bold mb-2 uppercase tracking-widest text-gray-400">Icon / Image</label>
                        <input type="file" name="image" required class="block w-full text-xs text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:bg-info/10 file:text-info">
                    </div>

                    <div class="flex items-center gap-3">
                        <input type="checkbox" name="isActive" checked class="w-5 h-5 rounded border-gray-300 text-info focus:ring-info">
                        <span class="text-sm font-medium">Visible to Customers</span>
                    </div>

                    <div class="flex justify-end gap-3 pt-4 border-t border-gray-50">
                        <button type="reset" class="px-6 py-2.5 text-gray-400 text-sm font-bold">Discard</button>
                        <button type="submit" class="bg-accent text-white px-8 py-2.5 rounded-xl text-sm font-bold hover:opacity-90 shadow-lg">Save Category</button>
                    </div>
                </form>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>