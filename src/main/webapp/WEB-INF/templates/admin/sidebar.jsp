<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0 bg-slate-900 border-r border-slate-800 shadow-2xl flex flex-col font-poppins selection:bg-brand-500 selection:text-white">
    <div class="h-full px-4 py-5 overflow-y-auto flex flex-col justify-between">
        
        <div class="space-y-6">
            <!-- Brand Logo -->
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center gap-3 px-2">
                <div class="w-10 h-10 rounded-2xl bg-slate-800 border border-slate-700 text-white flex items-center justify-center font-black text-sm tracking-wider shadow-md">
                    <span class="text-brand-400">N</span>H
                </div>
                <div>
                    <span class="text-lg font-black tracking-tight text-white block leading-none">NEO<span class="text-brand-400">HUB</span></span>
                    <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">Admin Portal</span>
                </div>
            </a>

            <!-- Navigation Links -->
            <div class="space-y-5">
                <div>
                    <span class="text-[10px] font-extrabold text-slate-500 uppercase px-3 tracking-wider block mb-2">Overview</span>
                    <ul class="space-y-1">
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/dashboard" 
                               class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition ${param.activePage == 'dashboard' ? 'bg-brand-600 text-white shadow-md' : 'text-slate-400 hover:bg-slate-800/80 hover:text-white'}">
                                <i class="fa-solid fa-chart-pie w-4 text-center"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div>
                    <span class="text-[10px] font-extrabold text-slate-500 uppercase px-3 tracking-wider block mb-2">Catalog &amp; Sales</span>
                    <ul class="space-y-1">
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/products" 
                               class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition ${param.activePage == 'products' ? 'bg-brand-600 text-white shadow-md' : 'text-slate-400 hover:bg-slate-800/80 hover:text-white'}">
                                <i class="fa-solid fa-box w-4 text-center"></i>
                                <span>Products</span>
                            </a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/admin/categories" 
                               class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition ${param.activePage == 'categories' ? 'bg-brand-600 text-white shadow-md' : 'text-slate-400 hover:bg-slate-800/80 hover:text-white'}">
                                <i class="fa-solid fa-tags w-4 text-center"></i>
                                <span>Categories</span>
                            </a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/admin/orders" 
                               class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition ${param.activePage == 'orders' ? 'bg-brand-600 text-white shadow-md' : 'text-slate-400 hover:bg-slate-800/80 hover:text-white'}">
                                <i class="fa-solid fa-cart-shopping w-4 text-center"></i>
                                <span>Orders</span>
                            </a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/admin/promos" 
                               class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition ${param.activePage == 'promos' ? 'bg-brand-600 text-white shadow-md' : 'text-slate-400 hover:bg-slate-800/80 hover:text-white'}">
                                <i class="fa-solid fa-ticket w-4 text-center"></i>
                                <span>Promos &amp; Coupons</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div>
                    <span class="text-[10px] font-extrabold text-slate-500 uppercase px-3 tracking-wider block mb-2">Users &amp; System</span>
                    <ul class="space-y-1">
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/users" 
                               class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition ${param.activePage == 'users' ? 'bg-brand-600 text-white shadow-md' : 'text-slate-400 hover:bg-slate-800/80 hover:text-white'}">
                                <i class="fa-solid fa-users w-4 text-center"></i>
                                <span>Customers &amp; Admins</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Bottom Controls -->
        <div class="pt-4 border-t border-slate-800 space-y-2">
            <a href="${pageContext.request.contextPath}/" 
               class="flex items-center gap-2.5 px-3.5 py-2.5 rounded-2xl text-xs font-bold text-slate-400 hover:text-white hover:bg-slate-800/80 transition">
                <i class="fa-solid fa-store w-4 text-center text-brand-400"></i>
                <span>View Public Store</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" 
               onclick="return confirm('Sign out of Administrator dashboard?')"
               class="flex items-center gap-2.5 px-3.5 py-2.5 rounded-2xl text-xs font-bold text-danger hover:bg-red-500/10 transition">
                <i class="fa-solid fa-right-from-bracket w-4 text-center"></i>
                <span>Sign Out</span>
            </a>
        </div>
    </div>
</aside>