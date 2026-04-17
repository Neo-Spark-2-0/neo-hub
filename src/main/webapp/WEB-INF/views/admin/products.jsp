<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - NEO-HUB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Create your NEO-HUB account to connect with the latest tech news, projects, and community. Join us today!">
    <meta name="keywords" content="NEO-HUB, registration, sign up, create account, tech community">
    <meta name="author" content="NEO-HUB Team">
    <link rel="icon" href="${pageContext.request.contextPath}/static/images/favicon.png" type="image/x-icon">
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body class="font-poppins bg-gray-100 min-h-screen">
<div class="p-6">

    <!-- Header & Add Button -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">Product Management</h1>
        <a href="${pageContext.request.contextPath}/admin/products?action=add" 
           class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded shadow-sm transition">
           + Add New Product
        </a>
    </div>

    <!-- Alert Messages (Success/Error) -->
    <c:if test="${not empty success}">
        <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4 shadow-sm" role="alert">
            <p class="font-bold">Success</p>
            <p>${success}</p>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 shadow-sm" role="alert">
            <p class="font-bold">Error</p>
            <p>${error}</p>
        </div>
    </c:if>

    <!-- Search & Filter Area -->
    <div class="bg-white p-4 rounded shadow-sm mb-6 border">
        <form action="${pageContext.request.contextPath}/admin/products" method="get" class="flex flex-wrap gap-4 items-end">
            <div class="w-full md:w-1/3">
                <label class="block text-sm font-medium text-gray-700 mb-1">Search Products</label>
                <input type="text" name="search" value="${search}"
                       class="border border-gray-300 px-3 py-2 rounded w-full focus:ring-blue-500 focus:border-blue-500"
                       placeholder="Enter product name..." />
            </div>

            <div class="w-full md:w-1/4">
                <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                <select name="categoryId" class="border border-gray-300 px-3 py-2 rounded w-full">
                    <option value="0">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${cat.id == categoryId ? 'selected' : ''}>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded transition shadow-sm">
                Search
            </button>
            
            <a href="${pageContext.request.contextPath}/admin/products" class="text-gray-500 hover:underline text-sm pb-2">
                Clear Filters
            </a>
        </form>
    </div>

    <!-- Table -->
    <div class="overflow-x-auto bg-white rounded shadow-sm border">
        <table class="min-w-full leading-normal">
            <thead>
                <tr class="bg-gray-50 border-b text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                    <th class="px-5 py-3">Image</th>
                    <th class="px-5 py-3 text-center">SKU</th>
                    <th class="px-5 py-3">Product Name</th>
                    <th class="px-5 py-3">Price</th>
                    <th class="px-5 py-3">Stock</th>
                    <th class="px-5 py-3 text-center">Status</th>
                    <th class="px-5 py-3 text-right">Actions</th>
                </tr>
            </thead>

            <tbody class="divide-y divide-gray-200">
                <c:forEach var="p" items="${productList}">
                    <tr class="hover:bg-gray-50 transition">
                        <td class="px-5 py-4">
                            <div class="h-12 w-12 overflow-hidden rounded bg-gray-100 border">
                                <c:choose>
                                    <c:when test="${not empty p.image}">
                                        <!-- Corrected Path: Servlet already includes 'uploads/' in the string -->
                                        <img src="${pageContext.request.contextPath}/${p.image}" 
                                             class="h-full w-full object-cover" 
                                             alt="${p.name}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="h-full w-full flex items-center justify-center text-gray-400 text-[10px]">NO IMG</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                        <td class="px-5 py-4 text-center text-sm font-mono text-gray-500">${p.sku}</td>
                        <td class="px-5 py-4">
                            <div class="text-sm font-bold text-gray-900">${p.name}</div>
                            <div class="text-xs text-gray-500 truncate w-40">${p.brand}</div>
                        </td>
                        <td class="px-5 py-4 text-sm font-semibold text-gray-700">
                           <c:choose>
                               <c:when test="${p.discountPrice > 0}">
                                   <span class="text-green-600">Rs. ${p.discountPrice}</span>
                                   <div class="text-[10px] text-gray-400 line-through">Rs. ${p.price}</div>
                               </c:when>
                               <c:otherwise>Rs. ${p.price}</c:otherwise>
                           </c:choose>
                        </td>
                        <td class="px-5 py-4">
                            <span class="px-2 py-1 text-xs font-medium rounded-full ${p.stock < 10 ? 'bg-red-100 text-red-700' : 'bg-gray-100 text-gray-700'}">
                                ${p.stock} units
                            </span>
                        </td>
                        <td class="px-5 py-4 text-center">
                            <c:if test="${p.active}"><span class="text-xs bg-blue-100 text-blue-800 px-2 py-0.5 rounded mr-1">Active</span></c:if>
                            <c:if test="${p.featured}"><span class="text-xs bg-amber-100 text-amber-800 px-2 py-0.5 rounded">★</span></c:if>
                        </td>
                        <td class="px-5 py-4 text-right text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" 
                               class="text-blue-600 hover:text-blue-900 mr-4">Edit</a>
                            
                            <!--  NEW DELETE FORM (POST Method) -->
                            <form action="${pageContext.request.contextPath}/admin/products" 
                                  method="POST" 
                                  class="inline-block"
                                  onsubmit="return confirm('Are you sure you want to delete this product? This action cannot be undone.')">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="text-red-600 hover:text-red-900 font-medium">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <div class="mt-6 flex justify-center items-center gap-2">
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="?page=${i}&search=${search}&categoryId=${categoryId}"
               class="px-4 py-2 border rounded transition ${i == currentPage ? 'bg-blue-600 text-white border-blue-600' : 'bg-white text-gray-700 hover:bg-gray-100'}">
                ${i}
            </a>
        </c:forEach>
    </div>

</div>
</body>
</html>