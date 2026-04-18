<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Add New Product" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Add Product" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="max-w-4xl mx-auto">
                
                <div class="flex items-center gap-4 mb-8">
                    <a href="products" class="w-10 h-10 flex items-center justify-center bg-white rounded-xl shadow-sm hover:bg-gray-50 transition">
                        <i class="fa-solid fa-arrow-left text-xs"></i>
                    </a>
                    <h2 class="text-2xl font-bold">Create New Product</h2>
                </div>

                <form action="products" method="POST" enctype="multipart/form-data" class="space-y-6">
                    <input type="hidden" name="action" value="insert">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        
                        <!-- Left Column: Basics -->
                        <div class="space-y-6">
                            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-4 uppercase tracking-widest text-gray-400">Basic Info</h3>
                                
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-xs font-bold mb-2">Product Name*</label>
                                        <input type="text" name="name" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info" placeholder="e.g. Arduino Uno R3">
                                    </div>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-xs font-bold mb-2">Brand</label>
                                            <input type="text" name="brand" class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info" placeholder="Arduino">
                                        </div>
                                        <div>
                                            <label class="block text-xs font-bold mb-2">SKU (Unique)*</label>
                                            <input type="text" name="sku" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info" placeholder="ARD-001">
                                        </div>
                                    </div>
                                    <div>
                                        <label class="block text-xs font-bold mb-2">Category*</label>
                                        <select name="categoryId" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.id}">${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-4 uppercase tracking-widest text-gray-400">Inventory & Pricing</h3>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-xs font-bold mb-2">Base Price (Rs.)*</label>
                                        <input type="number" step="0.01" name="price" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                                    </div>
                                    <div>
                                        <label class="block text-xs font-bold mb-2">Discount Price</label>
                                        <input type="number" step="0.01" name="discountPrice" class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info" value="0">
                                    </div>
                                    <div class="col-span-2">
                                        <label class="block text-xs font-bold mb-2">Stock Quantity*</label>
                                        <input type="number" name="stock" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column: Media & Status -->
                        <div class="space-y-6">
                            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-4 uppercase tracking-widest text-gray-400">Product Image</h3>
                                <div class="border-2 border-dashed border-gray-200 rounded-2xl p-8 text-center">
                                    <i class="fa-solid fa-cloud-arrow-up text-3xl text-gray-300 mb-4"></i>
                                    <input type="file" name="image" required class="block w-full text-xs text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-xs file:font-bold file:bg-info/10 file:text-info hover:file:bg-info/20">
                                </div>
                            </div>

                            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-4 uppercase tracking-widest text-gray-400">Settings</h3>
                                <div class="space-y-4">
                                    <label class="flex items-center gap-3 cursor-pointer group">
                                        <input type="checkbox" name="isActive" checked class="w-5 h-5 rounded border-gray-300 text-info focus:ring-info">
                                        <span class="text-sm font-medium text-gray-700">Active (Visible in Store)</span>
                                    </label>
                                    <label class="flex items-center gap-3 cursor-pointer group">
                                        <input type="checkbox" name="isFeatured" class="w-5 h-5 rounded border-gray-300 text-warning focus:ring-warning">
                                        <span class="text-sm font-medium text-gray-700">Featured (Home Page)</span>
                                    </label>
                                </div>
                            </div>

                            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100">
                                <label class="block text-xs font-bold mb-2 uppercase tracking-widest text-gray-400">Description</label>
                                <textarea name="description" rows="5" class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info" placeholder="Detailed product features..."></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-end gap-4 pt-6">
                        <button type="reset" class="px-8 py-3 bg-gray-100 text-gray-500 font-bold rounded-xl text-sm hover:bg-gray-200 transition">Discard</button>
                        <button type="submit" class="px-10 py-3 bg-accent text-white font-bold rounded-xl text-sm hover:opacity-90 transition shadow-lg shadow-accent/20">Save Product</button>
                    </div>
                </form>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>