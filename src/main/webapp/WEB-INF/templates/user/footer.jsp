<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="bg-white border-t border-slate-200 mt-20">
    <!-- Top Trust Bar -->
    <div class="border-b border-slate-100 bg-slate-50/50">
        <div class="w-[92vw] max-w-7xl mx-auto py-8 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <div class="flex items-center gap-3.5">
                <div class="w-11 h-11 rounded-2xl bg-brand-50 text-brand-600 flex items-center justify-center flex-shrink-0 text-lg shadow-subtle border border-brand-100">
                    <i class="fa-solid fa-truck-fast"></i>
                </div>
                <div>
                    <h5 class="text-xs font-bold text-slate-900">Nationwide Shipping</h5>
                    <p class="text-[11px] text-slate-500 font-medium">Fast delivery across Nepal</p>
                </div>
            </div>

            <div class="flex items-center gap-3.5">
                <div class="w-11 h-11 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center flex-shrink-0 text-lg shadow-subtle border border-blue-100">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>
                <div>
                    <h5 class="text-xs font-bold text-slate-900">100% Genuine Parts</h5>
                    <p class="text-[11px] text-slate-500 font-medium">Tested &amp; verified components</p>
                </div>
            </div>

            <div class="flex items-center gap-3.5">
                <div class="w-11 h-11 rounded-2xl bg-purple-50 text-purple-600 flex items-center justify-center flex-shrink-0 text-lg shadow-subtle border border-purple-100">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <div>
                    <h5 class="text-xs font-bold text-slate-900">Secure Payments</h5>
                    <p class="text-[11px] text-slate-500 font-medium">Khalti &amp; Cash on Delivery</p>
                </div>
            </div>

            <div class="flex items-center gap-3.5">
                <div class="w-11 h-11 rounded-2xl bg-amber-50 text-amber-600 flex items-center justify-center flex-shrink-0 text-lg shadow-subtle border border-amber-100">
                    <i class="fa-solid fa-headset"></i>
                </div>
                <div>
                    <h5 class="text-xs font-bold text-slate-900">Expert Support</h5>
                    <p class="text-[11px] text-slate-500 font-medium">Friendly technical assistance</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Footer Content -->
    <div class="w-[92vw] max-w-7xl mx-auto py-12">
        <div class="grid grid-cols-1 md:grid-cols-12 gap-10">

            <!-- Brand Column -->
            <div class="md:col-span-5 flex flex-col gap-4 max-w-md">
                <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2">
                    <img src="${pageContext.request.contextPath}/static/images/neo-hub-logo.png"
                         alt="NEO-HUB" class="h-12 w-auto object-contain" />
                </a>
                <p class="text-xs text-slate-500 leading-relaxed font-medium">
                    Nepal's premier IoT &amp; Electronics marketplace. Empowering makers, engineers, and students with top-quality microcontrollers, sensors, modules, and IoT project kits.
                </p>

                <!-- Social Links -->
                <div class="flex items-center gap-2 mt-2">
                    <a href="#" class="w-9 h-9 rounded-xl bg-slate-100 text-slate-600 hover:bg-slate-900 hover:text-white flex items-center justify-center transition-all text-xs" aria-label="Facebook">
                        <i class="fa-brands fa-facebook-f"></i>
                    </a>
                    <a href="#" class="w-9 h-9 rounded-xl bg-slate-100 text-slate-600 hover:bg-slate-900 hover:text-white flex items-center justify-center transition-all text-xs" aria-label="Instagram">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="#" class="w-9 h-9 rounded-xl bg-slate-100 text-slate-600 hover:bg-slate-900 hover:text-white flex items-center justify-center transition-all text-xs" aria-label="GitHub">
                        <i class="fa-brands fa-github"></i>
                    </a>
                    <a href="#" class="w-9 h-9 rounded-xl bg-slate-100 text-slate-600 hover:bg-slate-900 hover:text-white flex items-center justify-center transition-all text-xs" aria-label="LinkedIn">
                        <i class="fa-brands fa-linkedin-in"></i>
                    </a>
                </div>
            </div>

            <!-- Shop Links -->
            <div class="md:col-span-2 flex flex-col gap-2.5">
                <p class="text-xs font-bold uppercase text-slate-900 tracking-wider mb-1">Shop</p>
                <a href="${pageContext.request.contextPath}/products"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">All Products</a>
                <a href="${pageContext.request.contextPath}/products?sort=newest"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">New Arrivals</a>
                <a href="${pageContext.request.contextPath}/products?featured=true"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">Featured Items</a>
            </div>

            <!-- Account Links -->
            <div class="md:col-span-2 flex flex-col gap-2.5">
                <p class="text-xs font-bold uppercase text-slate-900 tracking-wider mb-1">Account</p>
                <a href="${pageContext.request.contextPath}/profile"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">My Profile</a>
                <a href="${pageContext.request.contextPath}/order-history"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">Order History</a>
                <a href="${pageContext.request.contextPath}/cart"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">Shopping Cart</a>
            </div>

            <!-- Company Links -->
            <div class="md:col-span-3 flex flex-col gap-2.5">
                <p class="text-xs font-bold uppercase text-slate-900 tracking-wider mb-1">Company</p>
                <a href="${pageContext.request.contextPath}/about"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">About NEO-HUB</a>
                <a href="${pageContext.request.contextPath}/contact"
                   class="text-xs text-slate-500 hover:text-slate-900 hover:translate-x-1 transition-all font-medium">Contact &amp; Support</a>
                <div class="mt-3 p-3 rounded-xl bg-slate-50 border border-slate-200/60">
                    <p class="text-[11px] text-slate-600 font-semibold"><i class="fa-solid fa-envelope mr-1.5 text-brand-600"></i> support@neohub.com.np</p>
                </div>
            </div>

        </div>

        <!-- Bottom Copyright & Credits -->
        <div class="h-px bg-slate-200 mt-10 mb-6"></div>

        <div class="flex flex-col sm:flex-row items-center justify-between gap-4 text-xs font-medium text-slate-500">
            <p>&copy; 2026 NEO-HUB. All rights reserved.</p>
            <div class="flex items-center gap-1.5">
                <span>Crafted with passion by</span>
                <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-slate-900 text-white font-bold text-[11px]">
                    <span class="w-1.5 h-1.5 rounded-full bg-brand-500"></span>
                    NEO-SPARK Team
                </span>
            </div>
        </div>
    </div>
</footer>