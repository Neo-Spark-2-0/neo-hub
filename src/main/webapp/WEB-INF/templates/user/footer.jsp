<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="bg-primary border-t border-gray-200 mt-16">
    <div class="w-[90vw] mx-auto py-10">

        <div class="flex flex-col md:flex-row justify-between gap-8">

            <%-- Brand — takes left half --%>
            <div class="flex flex-col gap-2 w-full md:w-1/2 max-w-xs">
                <img src="${pageContext.request.contextPath}/static/images/neo-hub-logo.png"
                     alt="NEO-HUB" class="w-20" />
                <p class="text-xs text-gray-400">
                    IoT Equipment &amp; Project Marketplace.<br/>
                    Arduino, sensors, modules and ready-made IoT kits.
                </p>
            </div>

            <%-- Link columns — start from right half with even spacing --%>
            <div class="flex flex-col md:flex-row md:w-1/2 justify-between gap-10 text-sm">

                <div class="flex flex-col gap-2">
                    <p class="text-xs font-bold uppercase text-gray-900 mb-1 tracking-wider">Shop</p>
                    <a href="${pageContext.request.contextPath}/products"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">All Products</a>
                    <a href="${pageContext.request.contextPath}/products?category=boards"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">Boards</a>
                    <a href="${pageContext.request.contextPath}/products?category=sensors"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">Sensors</a>
                    <a href="${pageContext.request.contextPath}/products?category=kits"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">IoT Kits</a>
                </div>

                <div class="flex flex-col gap-2">
                    <p class="text-xs font-bold uppercase text-gray-900 mb-1 tracking-wider">Account</p>
                    <a href="${pageContext.request.contextPath}/profile"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">Profile</a>
                    <a href="${pageContext.request.contextPath}/orders"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">My Orders</a>
                    <a href="${pageContext.request.contextPath}/cart"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">Cart</a>
                </div>

                <div class="flex flex-col gap-2">
                    <p class="text-xs font-bold uppercase text-gray-900 mb-1 tracking-wider">Company</p>
                    <a href="${pageContext.request.contextPath}/about"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">About Us</a>
                    <a href="${pageContext.request.contextPath}/contact"
                       class="text-gray-500 hover:text-accent hover:translate-x-0.5 transition-all duration-200">Contact</a>
                </div>

            </div>
        </div>

        <div class="h-[0.5px] bg-gray-200 my-6"></div>

        <div class="flex flex-col md:flex-row items-center justify-between gap-2">
            <p class="text-xs text-gray-400">&copy; 2026 NEO-HUB. All rights reserved.</p>
            <p class="text-xs text-gray-400">Designed &amp; Developed by <span class="font-bold text-gray-900">NEO-SPARK Team</span></p>
        </div>

    </div>
</footer>