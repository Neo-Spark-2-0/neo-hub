<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Edit Product: ${product.name}" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Edit Product" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="max-w-4xl mx-auto">
                
                <!-- Breadcrumb/Back -->
                <div class="flex items-center gap-4 mb-8">
                    <a href="products" class="w-10 h-10 flex items-center justify-center bg-white rounded-xl shadow-sm hover:bg-gray-50 transition">
                        <i class="fa-solid fa-arrow-left text-xs"></i>
                    </a>
                    <div>
                        <h2 class="text-2xl font-bold text-accent">Edit Product</h2>
                        <p class="text-xs text-gray-400 font-medium uppercase tracking-tighter">Product ID: #${product.id}</p>
                    </div>
                </div>

                <form action="products" method="POST" enctype="multipart/form-data" class="space-y-6">
                    <!-- CRITICAL: ID and Action -->
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${product.id}">

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                        
                        <!-- Left: Main Details -->
                        <div class="lg:col-span-2 space-y-6">
                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2"><i class="fa-solid fa-circle-info text-info"></i> Basic Information</h3>
                                
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Product Name</label>
                                        <input type="text" name="name" value="${product.name}" required 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info transition-all">
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Brand</label>
                                            <input type="text" name="brand" value="${product.brand}"
                                                   class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">
                                        </div>
                                        <div>
                                            <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">SKU Code</label>
                                            <input type="text" name="sku" value="${product.sku}" required
                                                   class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info font-mono uppercase">
                                        </div>
                                    </div>

                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Description</label>
                                        <textarea name="description" rows="5" 
                                                  class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">${product.description}</textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2"><i class="fa-solid fa-tag text-success"></i> Inventory & Pricing</h3>
                                <div class="grid grid-cols-2 gap-6">
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Original Price (Rs.)</label>
                                        <input type="number" step="0.01" name="price" value="${product.price}" required 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-bold">
                                    </div>
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Discounted Price (Rs.)</label>
                                        <input type="number" step="0.01" name="discountPrice" value="${product.discountPrice}" 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-bold text-success">
                                    </div>
                                    <div class="col-span-2">
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Stock Level</label>
                                        <input type="number" name="stock" value="${product.stock}" required 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right: Category, Image & Status -->
                        <div class="space-y-6">
                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2"><i class="fa-solid fa-image text-purple-500"></i> Media</h3>
                                
                                <div class="mb-4">
                                    <p class="text-[10px] font-bold text-gray-400 uppercase mb-2">Current Image</p>
                                    <div class="w-full h-40 bg-secondary rounded-2xl overflow-hidden border border-gray-100">
                                        <img src="${pageContext.request.contextPath}/${product.image}" class="w-full h-full object-contain" />
                                    </div>
                                </div>

                                <div>
                                    <p class="text-[10px] font-bold text-gray-400 uppercase mb-2">Upload New Image</p>
                                    <input type="file" name="image" 
                                           class="block w-full text-xs text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-xs file:font-bold file:bg-info/10 file:text-info hover:file:bg-info/20">
                                    <p class="text-[9px] text-gray-400 mt-2 italic">Leave empty to keep existing image</p>
                                </div>
                            </div>

                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2"><i class="fa-solid fa-sliders text-warning"></i> Configuration</h3>
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Category</label>
                                        <select name="categoryId" required class="w-full bg-secondary border-none rounded-xl py-3 text-sm">
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.id}" ${cat.id == product.categoryId ? 'selected' : ''}>${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <label class="flex items-center gap-3 cursor-pointer py-2">
                                        <input type="checkbox" name="isActive" ${product.active ? 'checked' : ''} class="w-5 h-5 rounded border-gray-300 text-info focus:ring-info">
                                        <span class="text-sm font-medium text-gray-700">Published</span>
                                    </label>

                                    <label class="flex items-center gap-3 cursor-pointer py-2">
                                        <input type="checkbox" name="isFeatured" ${product.isFeatured ? 'checked' : ''} class="w-5 h-5 rounded border-gray-300 text-warning focus:ring-warning">
                                        <span class="text-sm font-medium text-gray-700">Featured</span>
                                    </label>
                                </div>
                            </div>

                            <div class="flex flex-col gap-3">
                                <button type="submit" class="w-full bg-accent text-white py-4 rounded-2xl font-bold shadow-lg shadow-accent/20 hover:opacity-95 transition-all">Update Product</button>
                                <button type="reset" class="w-full bg-white text-gray-400 py-3 rounded-2xl font-bold hover:bg-gray-50 transition-all">Reset Changes</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </main>
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>
</body>
</html>