<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../common/import.jsp"/>

<div class="p-6 bg-gray-100 min-h-screen font-poppins">

    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-dark">Product Management</h1>

        <a href="${pageContext.request.contextPath}/admin/products?action=add"
           class="bg-primary text-white px-4 py-2 rounded-lg shadow hover:bg-blue-600 transition">
            <i class="fa fa-plus mr-2"></i>Add Product
        </a>
    </div>

    <!-- Table -->
    <div class="bg-white rounded-xl shadow overflow-x-auto">
        <table class="min-w-full text-sm text-left">
            <thead class="bg-gray-200 text-gray-700 uppercase text-xs">
                <tr>
                    <th class="px-6 py-3">Image</th>
                    <th class="px-6 py-3">Name</th>
                    <th class="px-6 py-3">Category</th>
                    <th class="px-6 py-3">Price</th>
                    <th class="px-6 py-3">Stock</th>
                    <th class="px-6 py-3 text-center">Actions</th>
                </tr>
            </thead>

            <tbody class="divide-y">

                <c:forEach var="product" items="${productList}">
                    <tr class="hover:bg-gray-50">

                        <!-- Image -->
                        <td class="px-6 py-4">
                            <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                                 class="w-12 h-12 object-cover rounded">
                        </td>

                        <!-- Name -->
                        <td class="px-6 py-4 font-medium text-dark">
                            ${product.name}
                        </td>

                        <!-- Category -->
                        <td class="px-6 py-4">
                            ${product.categoryName}
                        </td>

                        <!-- Price -->
                        <td class="px-6 py-4 text-secondary font-semibold">
                            Rs. ${product.price}
                        </td>

                        <!-- Stock -->
                        <td class="px-6 py-4">
                            <span class="${product.stock < 5 ? 'text-danger font-bold' : 'text-gray-700'}">
                                ${product.stock}
                            </span>
                        </td>

                        <!-- Actions -->
                        <td class="px-6 py-4 text-center space-x-2">

                            <!-- Edit -->
                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}"
                               class="bg-info text-white px-3 py-1 rounded hover:bg-cyan-600">
                                <i class="fa fa-edit"></i>
                            </a>

                            <!-- Delete -->
                            <button onclick="confirmDelete('${product.id}')"
                                    class="bg-danger text-white px-3 py-1 rounded hover:bg-red-600">
                                <i class="fa fa-trash"></i>
                            </button>

                        </td>
                    </tr>
                </c:forEach>

            </tbody>
        </table>
    </div>

</div>

<!-- SweetAlert Delete -->
<script>
    function confirmDelete(id) {
        Swal.fire({
            title: 'Are you sure?',
            text: "This product will be deleted!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#EF4444',
            cancelButtonColor: '#6B7280',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href =
                    '${pageContext.request.contextPath}/admin/products?action=delete&id=' + id;
            }
        });
    }
</script>