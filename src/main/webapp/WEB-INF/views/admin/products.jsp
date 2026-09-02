<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Manage Products | NEO-HUB Admin" />
</jsp:include>

<body class="bg-slate-50 font-poppins text-slate-900 antialiased">

    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <div class="sm:ml-64 min-h-screen flex flex-col">
        
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Product Management" />
        </jsp:include>

        <main class="p-6 md:p-10 flex-1 space-y-6">
            
            <!-- Page Heading & Add Button -->
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h2 class="text-2xl font-black text-slate-900">Product Inventory</h2>
                    <p class="text-xs text-slate-400 font-medium mt-1">Monitor stock, update pricing, and manage catalog visibility.</p>
                </div>
                
                <a href="${pageContext.request.contextPath}/admin/products?action=add" 
                   class="inline-flex items-center justify-center gap-2 bg-slate-900 hover:bg-slate-800 text-white px-5 py-3 rounded-2xl text-xs font-bold transition shadow-md active:scale-95">
                    <i class="fa-solid fa-plus text-brand-400 text-xs"></i>
                    Add New Product
                </a>
            </div>

            <!-- SEARCH & FILTER CARD -->
            <div class="bg-white p-5 rounded-3xl shadow-sm border border-slate-200/80">
                <form action="${pageContext.request.contextPath}/admin/products" method="get" class="grid grid-cols-1 md:grid-cols-12 gap-4 items-end">
                    
                    <%-- Search Input --%>
                    <div class="md:col-span-5 space-y-1.5">
                        <label class="block text-[10px] font-extrabold text-slate-400 uppercase tracking-widest">Search</label>
                        <div class="relative">
                            <i class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                            <input type="text" name="search" value="${search}"
                                   class="w-full bg-slate-50 border border-slate-200 rounded-2xl py-3 pl-10 pr-4 text-xs font-medium focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:bg-white transition"
                                   placeholder="Product name, brand or SKU..." />
                        </div>
                    </div>

                    <%-- Category Dropdown --%>
                    <div class="md:col-span-4 space-y-1.5">
                        <label class="block text-[10px] font-extrabold text-slate-400 uppercase tracking-widest">Category</label>
                        <select name="categoryId" class="w-full bg-slate-50 border border-slate-200 rounded-2xl py-3 px-4 text-xs font-medium focus:outline-none focus:ring-2 focus:ring-brand-500/20 transition">
                            <option value="0">All Categories</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${cat.id == categoryId ? 'selected' : ''}>
                                    ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <%-- Action Buttons --%>
                    <div class="md:col-span-3 flex gap-2">
                        <button type="submit" class="flex-1 bg-slate-900 hover:bg-slate-800 text-white py-3 rounded-2xl text-xs font-bold transition shadow-sm">
                            Apply Filters
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/products" 
                           class="p-3 bg-slate-100 hover:bg-slate-200 text-slate-500 rounded-2xl transition flex items-center justify-center" title="Clear Filters">
                            <i class="fa-solid fa-rotate-right text-xs"></i>
                        </a>
                    </div>
                </form>
            </div>

            <!-- DATA TABLE CARD -->
            <div class="bg-white rounded-3xl shadow-sm border border-slate-200/80 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-[10px] uppercase font-extrabold text-slate-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">Image</th>
                                <th class="px-6 py-4">Product Details</th>
                                <th class="px-6 py-4">Price</th>
                                <th class="px-6 py-4">Inventory</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 text-xs font-medium">
                            <c:forEach var="product" items="${productList}">
                                <tr class="hover:bg-slate-50/60 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="w-12 h-12 rounded-2xl bg-slate-100 overflow-hidden border border-slate-200">
                                            <c:choose>
                                                <c:when test="${not empty product.image}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${product.image}" class="w-full h-full object-cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                                                         alt="No image" class="w-full h-full object-cover">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="font-extrabold text-slate-900 leading-tight">${product.name}</div>
                                        <div class="flex items-center gap-2 mt-1">
                                            <span class="text-[9px] font-extrabold bg-blue-50 text-blue-600 border border-blue-100 px-1.5 py-0.5 rounded-lg uppercase">${product.stockKeepingUnit}</span>
                                            <span class="text-[10px] text-slate-400">${product.brand}</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 font-extrabold">
                                        <c:choose>
                                            <c:when test="${product.discountPrice > 0}">
                                                <div class="text-emerald-600">Rs. ${product.discountPrice}</div>
                                                <div class="text-[10px] text-slate-300 line-through font-normal">Rs. ${product.price}</div>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-slate-900">Rs. ${product.price}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex flex-col gap-1.5">
                                            <span class="font-extrabold ${product.stock < 10 ? 'text-red-600' : 'text-slate-900'}">
                                                ${product.stock} Units
                                            </span>
                                            <div class="w-16 h-1.5 bg-slate-100 rounded-full overflow-hidden">
                                                <div class="h-full rounded-full ${product.stock < 10 ? 'bg-red-400' : 'bg-emerald-400'}" style="width: ${product.stock > 100 ? 100 : product.stock}%"></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex flex-col gap-1">
                                            <c:if test="${product.active}">
                                                <span class="inline-flex items-center gap-1.5 text-[10px] font-bold text-emerald-600">
                                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>Active
                                                </span>
                                            </c:if>
                                            <c:if test="${not product.active}">
                                                <span class="inline-flex items-center gap-1.5 text-[10px] font-bold text-slate-400">
                                                    <span class="w-1.5 h-1.5 rounded-full bg-slate-300"></span>Hidden
                                                </span>
                                            </c:if>
                                            <c:if test="${product.featured}">
                                                <span class="inline-flex items-center gap-1 text-[10px] font-bold text-amber-500">
                                                    <i class="fa-solid fa-star text-[8px]"></i>Featured
                                                </span>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex justify-end items-center gap-2">
                                            <%-- Edit Action --%>
                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}" 
                                               class="w-8 h-8 flex items-center justify-center bg-blue-50 text-blue-600 border border-blue-100 rounded-xl hover:bg-blue-600 hover:text-white transition"
                                               title="Edit Product">
                                                <i class="fa-solid fa-pen-to-square text-xs"></i>
                                            </a>
                                            
                                            <%-- Delete Action --%>
                                            <form id="delete-form-${product.id}" action="${pageContext.request.contextPath}/admin/products" method="POST" class="inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${product.id}">
                                                <button type="button" 
                                                        onclick="confirmAdminAction('Permanently remove this product from the catalog?', 'delete-form-${product.id}')"
                                                        class="w-8 h-8 flex items-center justify-center bg-red-50 text-red-600 border border-red-100 rounded-xl hover:bg-red-500 hover:text-white transition"
                                                        title="Delete Product">
                                                    <i class="fa-solid fa-trash-can text-xs"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty productList}">
                                <tr>
                                    <td colspan="6" class="px-6 py-20 text-center">
                                        <i class="fa-solid fa-box-open text-slate-200 text-4xl mb-3 block"></i>
                                        <p class="text-slate-400 text-sm font-medium">No products found matching your filters.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- PAGINATION SECTION -->
                <c:if test="${totalPages > 1}">
                    <div class="px-6 py-5 bg-slate-50/60 border-t border-slate-100 flex justify-center items-center gap-1.5">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&search=${search}&categoryId=${categoryId}" 
                               class="w-9 h-9 flex items-center justify-center rounded-xl text-xs font-extrabold transition
                               ${i == currentPage ? 'bg-slate-900 text-white shadow-md' : 'bg-white text-slate-500 hover:bg-slate-100 border border-slate-200'}">
                                ${i}
                            </a>
                        </c:forEach>
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