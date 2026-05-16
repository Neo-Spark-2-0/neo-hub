<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<!-- 1. HEAD SECTION -->
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Manage Products" />
</jsp:include>

<body class="bg-secondary font-poppins text-accent">

    <!-- 2. SIDEBAR SECTION -->
    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <!-- 3. MAIN CONTENT CONTAINER -->
    <div class="sm:ml-64 min-h-screen flex flex-col">
        
        <!-- 4. HEADER SECTION -->
        <jsp:include page="/WEB-INF/templates/admin/header.jsp">
            <jsp:param name="activePage" value="Product Management" />
        </jsp:include>

        <!-- 5. MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 flex-1">
            
            <!-- Page Heading & Add Button -->
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
                <div>
                    <h2 class="text-2xl font-bold">Product Inventory</h2>
                    <p class="text-xs text-gray-500 font-medium mt-1">Monitor stock, update pricing, and manage visibility.</p>
                </div>
                
                <a href="${pageContext.request.contextPath}/admin/products?action=add" 
                   class="inline-flex items-center justify-center gap-2 bg-info hover:opacity-90 text-white px-6 py-3 rounded-xl text-sm font-bold transition-all shadow-sm">
                    <i class="fa-solid fa-plus text-xs"></i>
                    Add New Product
                </a>
            </div>

            <!-- SEARCH & FILTER CARD -->
            <div class="bg-primary p-6 rounded-2xl shadow-sm border border-gray-100 mb-8">
                <form action="${pageContext.request.contextPath}/admin/products" method="get" class="grid grid-cols-1 md:grid-cols-12 gap-4 items-end">
                    
                    <%-- Search Input --%>
                    <div class="md:col-span-5">
                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">Search</label>
                        <div class="relative">
                            <i class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="search" value="${search}"
                                   class="w-full bg-secondary border-none rounded-xl py-3 pl-10 pr-4 text-sm focus:ring-2 focus:ring-info transition-all"
                                   placeholder="Product name, brand or SKU..." />
                        </div>
                    </div>

                    <%-- Category Dropdown --%>
                    <div class="md:col-span-4">
                        <label class="block text-[10px] font-bold text-gray-400 uppercase mb-2 tracking-widest">Category</label>
                        <select name="categoryId" class="w-full bg-secondary border-none rounded-xl py-3 px-4 text-sm focus:ring-2 focus:ring-info transition-all">
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
                        <button type="submit" class="flex-1 bg-accent text-white py-3 rounded-xl text-sm font-bold hover:opacity-90 transition shadow-sm">
                            Apply Filters
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/products" 
                           class="p-3 bg-gray-100 text-gray-500 rounded-xl hover:bg-gray-200 transition flex items-center justify-center" title="Clear Filters">
                            <i class="fa-solid fa-rotate-right"></i>
                        </a>
                    </div>
                </form>
            </div>

            <!-- DATA TABLE CARD -->
            <div class="bg-primary rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-secondary text-[10px] uppercase font-bold text-gray-400 tracking-wider">
                            <tr>
                                <th class="px-6 py-4">Image</th>
                                <th class="px-6 py-4">Product Details</th>
                                <th class="px-6 py-4">Price</th>
                                <th class="px-6 py-4">Inventory</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-secondary text-sm">
                            <c:forEach var="p" items="${productList}">
                                <tr class="hover:bg-secondary/30 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="w-14 h-14 rounded-xl bg-secondary overflow-hidden border border-gray-100 shadow-inner">
                                            <c:choose>
                                                <c:when test="${not empty p.image}">
                                                    <img src="${pageContext.request.contextPath}/${p.image}" class="w-full h-full object-cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full flex items-center justify-center text-[10px] text-gray-300 italic">No Img</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="font-bold text-accent leading-tight">${p.name}</div>
                                        <div class="flex items-center gap-2 mt-1">
                                            <span class="text-[9px] font-bold bg-info/10 text-info px-1.5 py-0.5 rounded uppercase leading-none">${p.stockKeepingUnit}</span>
                                            <span class="text-[10px] text-gray-400 leading-none">${p.brand}</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 font-bold">
                                        <c:choose>
                                            <c:when test="${p.discountPrice > 0}">
                                                <div class="text-success">Rs. ${p.discountPrice}</div>
                                                <div class="text-[10px] text-gray-300 line-through font-normal">Rs. ${p.price}</div>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-accent">Rs. ${p.price}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex flex-col gap-1">
                                            <span class="text-xs font-bold ${p.stock < 10 ? 'text-danger' : 'text-accent'}">
                                                ${p.stock} Units
                                            </span>
                                            <div class="w-16 h-1 bg-gray-100 rounded-full overflow-hidden">
                                                <div class="h-full ${p.stock < 10 ? 'bg-danger' : 'bg-success'}" style="width: ${p.stock > 100 ? 100 : p.stock}%"></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-1.5">
                                            <c:if test="${p.active}">
                                                <span class="w-2 h-2 rounded-full bg-success animate-pulse"></span>
                                                <span class="text-[10px] font-bold text-success uppercase">Active</span>
                                            </c:if>
                                            <c:if test="${not p.active}">
                                                <span class="w-2 h-2 rounded-full bg-gray-300"></span>
                                                <span class="text-[10px] font-bold text-gray-400 uppercase">Hidden</span>
                                            </c:if>
                                            <c:if test="${p.featured}">
                                                <span class="ml-2 text-warning"><i class="fa-solid fa-star text-[10px]"></i></span>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex justify-end items-center gap-2">
                                            <%-- Edit Action --%>
                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" 
                                               class="w-9 h-9 flex items-center justify-center bg-info/10 text-info rounded-xl hover:bg-info hover:text-white transition-all shadow-sm"
                                               title="Edit Product">
                                                <i class="fa-solid fa-pen-to-square text-xs"></i>
                                            </a>
                                            
                                            <%-- Delete Action --%>
                                            <form id="delete-form-${p.id}" action="${pageContext.request.contextPath}/admin/products" method="POST" class="inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${p.id}">
                                                <button type="button" 
                                                        onclick="confirmAdminAction('Warning: This will permanently remove the product and its image from the system. Continue?', 'delete-form-${p.id}')"
                                                        class="w-9 h-9 flex items-center justify-center bg-danger/10 text-danger rounded-xl hover:bg-danger hover:text-white transition-all shadow-sm"
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
                                        <img src="${pageContext.request.contextPath}/static/images/empty-box.png" class="h-20 mx-auto opacity-20 mb-4" onerror="this.style.display='none'">
                                        <p class="text-gray-400 italic text-sm">No products found in the database.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- PAGINATION SECTION -->
                <c:if test="${totalPages > 1}">
                    <div class="px-6 py-6 bg-secondary/20 border-t border-secondary flex justify-center items-center gap-1.5">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&search=${search}&categoryId=${categoryId}" 
                               class="w-9 h-9 flex items-center justify-center rounded-xl text-xs font-bold transition-all
                               ${i == currentPage ? 'bg-accent text-white shadow-lg' : 'bg-primary text-gray-400 hover:bg-gray-200 border border-gray-100'}">
                                ${i}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </main>

        <!-- 6. FOOTER SECTION -->
        <jsp:include page="/WEB-INF/templates/admin/footer.jsp" />
    </div>

    <!-- SCRIPT FOR NOTIFICATIONS -->
    <script>
        window.onload = function() {
            <%-- Read from session flash messages --%>
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