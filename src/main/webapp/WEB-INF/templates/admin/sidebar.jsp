<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0 bg-accent shadow-2xl">
    <div class="h-full px-3 py-4 overflow-y-auto flex flex-col">
        
        <!-- Brand Logo -->
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center ps-2.5 mb-8 mt-2 gap-3">
            <div class="bg-primary p-1.5 rounded-lg">
                <img src="${pageContext.request.contextPath}/static/images/neo-hub-logo.png" class="h-6 w-auto" alt="Logo" />
            </div>
            <span class="self-center text-xl font-bold whitespace-nowrap text-primary font-poppins tracking-tight">NEO-HUB</span>
        </a>

        <!-- Navigation Links -->
        <ul class="space-y-2 font-medium flex-1">
            <p class="text-[10px] font-bold text-gray-500 uppercase px-3 mb-2 tracking-widest">Main Menu</p>
            
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard" 
                   class="flex items-center p-3 rounded-xl transition-all group ${param.activePage == 'dashboard' ? 'bg-white/10 text-primary border-l-4 border-info' : 'text-gray-400 hover:bg-white/5 hover:text-white'}">
                    <i class="fa-solid fa-chart-pie w-5 text-center"></i>
                    <span class="ms-3 text-sm">Dashboard</span>
                </a>
            </li>

            <p class="text-[10px] font-bold text-gray-500 uppercase px-3 mt-6 mb-2 tracking-widest">Management</p>

            <li>
                <a href="${pageContext.request.contextPath}/admin/products" 
                   class="flex items-center p-3 rounded-xl transition-all group ${param.activePage == 'products' ? 'bg-white/10 text-primary border-l-4 border-info' : 'text-gray-400 hover:bg-white/5 hover:text-white'}">
                    <i class="fa-solid fa-box w-5 text-center"></i>
                    <span class="ms-3 text-sm">Products</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/categories" 
                   class="flex items-center p-3 rounded-xl transition-all group ${param.activePage == 'categories' ? 'bg-white/10 text-primary border-l-4 border-info' : 'text-gray-400 hover:bg-white/5 hover:text-white'}">
                    <i class="fa-solid fa-tags w-5 text-center"></i>
                    <span class="ms-3 text-sm">Categories</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/orders" 
                   class="flex items-center p-3 rounded-xl transition-all group ${param.activePage == 'orders' ? 'bg-white/10 text-primary border-l-4 border-info' : 'text-gray-400 hover:bg-white/5 hover:text-white'}">
                    <i class="fa-solid fa-cart-shopping w-5 text-center"></i>
                    <span class="ms-3 text-sm">Orders</span>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/admin/users" 
                   class="flex items-center p-3 rounded-xl transition-all group ${param.activePage == 'users' ? 'bg-white/10 text-primary border-l-4 border-info' : 'text-gray-400 hover:bg-white/5 hover:text-white'}">
                    <i class="fa-solid fa-users w-5 text-center"></i>
                    <span class="ms-3 text-sm">Users</span>
                </a>
            </li>

            <li>
                 <a href="${pageContext.request.contextPath}/admin/promos" 
                     class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${param.activePage == 'promos' ? 'bg-blue-600 text-white' : 'text-slate-400 hover:bg-slate-800'}">
                     <i class="fa-solid fa-ticket w-5"></i>
                     <span class="text-sm font-medium">Offers & Promos</span>
                </a>
            </li>

        </ul>

     

        <!-- Logout at Bottom -->
        <div class="pt-4 border-t border-gray-700">
            <a href="${pageContext.request.contextPath}/logout" 
               onclick="return confirm('Are you sure you want to logout?')"
               class="flex items-center p-3 text-danger rounded-xl hover:bg-danger/10 transition-all group">
                <i class="fa-solid fa-right-from-bracket w-5 text-center"></i>
                <span class="ms-3 text-sm font-bold">Logout</span>
            </a>
        </div>
    </div>
    
</aside>