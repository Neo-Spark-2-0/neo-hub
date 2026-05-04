<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Edit Product: ${product.name}" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">

    <!-- Sidebar Inclusion -->
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        
        <!-- Header Inclusion -->
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Edit Product" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1">
            <div class="max-w-5xl mx-auto">
                
                <!-- Back Button and Title -->
                <div class="flex items-center gap-4 mb-8">
                    <a href="${pageContext.request.contextPath}/admin/products" 
                       class="w-10 h-10 flex items-center justify-center bg-white rounded-xl shadow-sm hover:bg-gray-50 transition">
                        <i class="fa-solid fa-arrow-left text-xs"></i>
                    </a>
                    <div>
                        <h2 class="text-2xl font-bold text-accent">Edit Product</h2>
                        <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest mt-1">
                            System Reference: #${product.id}
                        </p>
                    </div>
                </div>

                <!-- Form Start -->
                <form action="${pageContext.request.contextPath}/admin/products" method="POST" enctype="multipart/form-data" class="space-y-6">
                    
                    <!-- Hidden fields for Action and ID -->
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${product.id}">

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                        
                        <!-- LEFT COLUMN: Main Information -->
                        <div class="lg:col-span-2 space-y-6">
                            
                            <!-- Basic Info Card -->
                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2">
                                    <i class="fa-solid fa-circle-info text-info"></i> Basic Details
                                </h3>
                                
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
                                            <!-- ✅ Corrected property name -->
                                            <input type="text" name="sku" value="${product.stockKeepingUnit}" required
                                                   class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info font-mono uppercase">
                                        </div>
                                    </div>

                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Description</label>
                                        <textarea name="description" rows="4" 
                                                  class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info">${product.description}</textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- Inventory/Pricing Card -->
                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2">
                                    <i class="fa-solid fa-tag text-success"></i> Inventory & Pricing
                                </h3>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Price (Rs.)</label>
                                        <input type="number" step="0.01" name="price" value="${product.price}" required 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-bold">
                                    </div>
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Sale Price (Rs.)</label>
                                        <input type="number" step="0.01" name="discountPrice" value="${product.discountPrice}" 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-bold text-success" placeholder="0.00">
                                    </div>
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Stock Qty</label>
                                        <input type="number" name="stock" value="${product.stock}" required 
                                               class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm font-bold">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- RIGHT COLUMN: Media & Configuration -->
                        <div class="space-y-6">
                            
                            <!-- Media Card -->
                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2">
                                    <i class="fa-solid fa-image text-purple-500"></i> Product Media
                                </h3>
                                
                                <div class="mb-4">
                                    <p class="text-[10px] font-bold text-gray-400 uppercase mb-2">Current Image</p>
                                    <div class="w-full h-44 bg-secondary rounded-2xl overflow-hidden border border-gray-100 shadow-inner flex items-center justify-center">
                                        <c:choose>
                                            <c:when test="${not empty product.image}">
                                                <!-- Handle Seed URL vs Local Upload -->
                                                <c:choose>
                                                    <c:when test="${product.image.startsWith('http')}">
                                                        <img src="${product.image}" class="w-full h-full object-contain">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/display-image/${product.image}" 
                                                             class="w-full h-full object-contain">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-xs text-gray-300 italic">No Image Available</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div>
                                    <p class="text-[10px] font-bold text-gray-400 uppercase mb-2">Replace Image</p>
                                    <input type="file" name="image" 
                                           class="block w-full text-[10px] text-gray-400 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-[10px] file:font-bold file:bg-info/10 file:text-info hover:file:bg-info/20">
                                </div>
                            </div>

                            <!-- Visibility Card -->
                            <div class="bg-primary p-8 rounded-3xl shadow-sm border border-gray-100">
                                <h3 class="text-sm font-bold mb-6 flex items-center gap-2">
                                    <i class="fa-solid fa-sliders text-warning"></i> Settings
                                </h3>
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2">Category</label>
                                        <select name="categoryId" required class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm">
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.id}" ${cat.id == product.categoryId ? 'selected' : ''}>
                                                    ${cat.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="space-y-3 pt-2">
                                        <label class="flex items-center gap-3 cursor-pointer group">
                                            <input type="checkbox" name="isActive" ${product.active ? 'checked' : ''} 
                                                   class="w-5 h-5 rounded border-gray-200 text-info focus:ring-info transition">
                                            <span class="text-xs font-bold text-accent uppercase group-hover:text-info transition">Active (Live)</span>
                                        </label>

                                        <label class="flex items-center gap-3 cursor-pointer group">
                                            <input type="checkbox" name="isFeatured" ${product.featured ? 'checked' : ''} 
                                                   class="w-5 h-5 rounded border-gray-200 text-warning focus:ring-warning transition">
                                            <span class="text-xs font-bold text-accent uppercase group-hover:text-warning transition">Featured Product</span>
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex flex-col gap-3">
                                <button type="submit" class="w-full bg-accent text-white py-4 rounded-2xl text-sm font-bold shadow-lg shadow-accent/20 hover:opacity-95 transition-all">
                                    Save Changes
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/products" 
                                   class="w-full bg-white text-gray-400 py-4 rounded-2xl text-sm font-bold text-center border border-gray-100 hover:bg-gray-50 transition-all">
                                    Discard
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </main>

        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    <script>
        // Simple client-side preview (optional)
        const fileInput = document.querySelector('input[type="file"]');
        fileInput.addEventListener('change', function(e) {
            if (e.target.files && e.target.files[0]) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    document.querySelector('img').src = event.target.result;
                }
                reader.readAsDataURL(e.target.files[0]);
            }
        });
    </script>
</body>
</html>