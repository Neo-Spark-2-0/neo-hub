<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<header class="glass-nav border-b border-slate-200/80 sticky top-0 z-50 transition-all">
    <div class="w-[92vw] max-w-7xl mx-auto flex items-center justify-between h-16 gap-4">

        <!-- Brand Logo -->
        <a href="${pageContext.request.contextPath}/"
           class="flex items-center gap-2.5 flex-shrink-0 group">
            <img src="${pageContext.request.contextPath}/static/images/neo-hub-logo.png"
                 alt="NEO-HUB"
                 class="h-12 md:h-14 w-auto object-contain transition-transform group-hover:scale-105">
        </a>

        <!-- Desktop Navigation Links -->
        <nav class="hidden md:flex items-center gap-1.5 text-sm justify-center bg-slate-100/70 p-1 rounded-2xl border border-slate-200/60">
            <a href="${pageContext.request.contextPath}/"
               class="px-4 py-2 rounded-xl font-semibold transition-all duration-200
               ${param.activePage eq 'home' ? 'bg-slate-900 text-white shadow-sm' : 'text-slate-600 hover:text-slate-900 hover:bg-white/80'}">
                Home
            </a>
            <a href="${pageContext.request.contextPath}/products"
               class="px-4 py-2 rounded-xl font-semibold transition-all duration-200
               ${param.activePage eq 'products' ? 'bg-slate-900 text-white shadow-sm' : 'text-slate-600 hover:text-slate-900 hover:bg-white/80'}">
                Products
            </a>
            <a href="${pageContext.request.contextPath}/about"
               class="px-4 py-2 rounded-xl font-semibold transition-all duration-200
               ${param.activePage eq 'about' ? 'bg-slate-900 text-white shadow-sm' : 'text-slate-600 hover:text-slate-900 hover:bg-white/80'}">
                About Us
            </a>
            <a href="${pageContext.request.contextPath}/contact"
               class="px-4 py-2 rounded-xl font-semibold transition-all duration-200
               ${param.activePage eq 'contact' ? 'bg-slate-900 text-white shadow-sm' : 'text-slate-600 hover:text-slate-900 hover:bg-white/80'}">
                Contact Us
            </a>
        </nav>

        <!-- Right Section Icons & Profile -->
        <div class="flex items-center gap-2">

        <c:choose>
            <%-- Logged in user --%>
            <c:when test="${not empty sessionScope.user}">

                    <%-- Notifications dropdown --%>
                    <div class="relative" id="notificationDropdown">
                        <button onclick="toggleNotifications()"
                                class="w-10 h-10 flex items-center justify-center rounded-xl text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-all border border-transparent hover:border-slate-200"
                                aria-label="Notifications">
                            <i class="fa-regular fa-bell text-base"></i>
                        </button>

                        <%-- Notification panel --%>
                        <div id="notificationMenu"
                             class="hidden absolute right-[-100px] sm:right-0 top-full mt-2 w-80 bg-white border border-slate-200
                                    rounded-2xl shadow-card z-50 overflow-hidden animate-fade-in">
                            <div class="flex items-center justify-between px-4 py-3.5 border-b border-slate-100 bg-slate-50/50">
                                <div class="flex items-center gap-2">
                                    <span class="w-2 h-2 rounded-full bg-brand-500"></span>
                                    <p class="text-xs font-bold text-slate-900 uppercase tracking-wider">Notifications</p>
                                </div>
                                <span class="text-[11px] font-semibold text-slate-400">Activity</span>
                            </div>
                            <div class="py-6 px-4 text-center">
                                <div class="w-10 h-10 rounded-full bg-slate-100 text-slate-400 flex items-center justify-center mx-auto mb-2">
                                    <i class="fa-regular fa-bell-slash text-sm"></i>
                                </div>
                                <p class="text-xs font-medium text-slate-500">No new notifications right now.</p>
                            </div>
                        </div>
                    </div>

                    <%-- Cart button --%>
                    <a href="${pageContext.request.contextPath}/cart"
                       class="relative w-10 h-10 flex items-center justify-center rounded-xl text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition-all border border-transparent hover:border-slate-200"
                       aria-label="Cart">
                        <i class="fa-solid fa-cart-shopping text-base"></i>
                    </a>

                    <%-- Profile dropdown --%>
                    <div class="relative" id="profileDropdown">
                        <button onclick="toggleProfileMenu()"
                                class="flex items-center gap-2.5 pl-1.5 pr-3 py-1.5 rounded-xl hover:bg-slate-100 border border-slate-200/80 transition-all bg-white shadow-subtle">

                            <!-- Avatar -->
                            <div class="w-8 h-8 rounded-lg bg-gradient-to-tr from-slate-900 to-slate-700 text-white overflow-hidden flex items-center justify-center flex-shrink-0 font-bold text-xs shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.profileImage}">
                                        <img src="${pageContext.request.contextPath}/uploads/${sessionScope.user.profileImage}"
                                             class="w-full h-full object-cover" alt="Photo" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="parts" value="${fn:split(sessionScope.user.fullName, ' ')}" />
                                        ${fn:substring(parts[0], 0, 1)}
                                        <c:if test="${fn:length(parts) > 1}">
                                            ${fn:substring(parts[1], 0, 1)}
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <span class="text-xs font-bold text-slate-800 hidden md:block">
                                <c:out value="${fn:split(sessionScope.user.fullName, ' ')[0]}" />
                            </span>
                            <i class="fa-solid fa-chevron-down text-[10px] text-slate-400 hidden md:block transition-transform duration-200"></i>
                        </button>

                        <%-- Profile Menu Dropdown --%>
                        <div id="profileMenu"
                             class="hidden absolute right-0 top-full mt-2 w-60 bg-white border border-slate-200
                                    rounded-2xl shadow-card py-1.5 z-50 animate-fade-in">
                            <div class="px-4 py-3 border-b border-slate-100 bg-slate-50/50">
                                <p class="text-xs font-bold text-slate-900 truncate">
                                    <c:out value="${sessionScope.user.fullName}" />
                                </p>
                                <p class="text-[11px] text-slate-500 font-medium truncate mt-0.5">
                                    <c:out value="${sessionScope.user.email}" />
                                </p>
                            </div>

                            <div class="py-1">
                                <a href="${pageContext.request.contextPath}/profile"
                                   class="flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 hover:text-slate-900 transition-colors">
                                    <div class="w-6 h-6 rounded-lg bg-slate-100 flex items-center justify-center text-slate-500">
                                        <i class="fa-regular fa-user text-xs"></i>
                                    </div>
                                    My Profile
                                </a>

                                <c:if test="${sessionScope.user.role eq 'USER'}">
                                    <a href="${pageContext.request.contextPath}/order-history"
                                       class="flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-slate-700 hover:bg-slate-50 hover:text-slate-900 transition-colors">
                                        <div class="w-6 h-6 rounded-lg bg-slate-100 flex items-center justify-center text-slate-500">
                                            <i class="fa-solid fa-box text-xs"></i>
                                        </div>
                                        Order History
                                    </a>
                                </c:if>

                                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                                       class="flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-indigo-600 hover:bg-indigo-50 transition-colors">
                                        <div class="w-6 h-6 rounded-lg bg-indigo-100 flex items-center justify-center text-indigo-600">
                                            <i class="fa-solid fa-chart-line text-xs"></i>
                                        </div>
                                        Admin Panel
                                    </a>
                                </c:if>
                            </div>

                            <div class="h-px bg-slate-100 my-1"></div>

                            <a href="#"
                               class="flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-danger hover:bg-red-50 transition-colors"
                               onclick="confirmLogout()">
                                <div class="w-6 h-6 rounded-lg bg-red-100 flex items-center justify-center text-danger">
                                    <i class="fa-solid fa-arrow-right-from-bracket text-xs"></i>
                                </div>
                                Logout
                            </a>
                        </div>
                    </div>

                </c:when>

                <%-- Guest / Logged out state --%>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"
                       class="px-5 py-2 rounded-xl bg-slate-900 text-white text-xs font-bold
                              hover:bg-slate-800 transition-all shadow-sm hover:shadow-md">
                        Sign in
                    </a>
                </c:otherwise>
            </c:choose>

            <%-- Mobile menu toggle button --%>
            <button onclick="toggleMobileMenu()"
                    class="md:hidden w-10 h-10 flex items-center justify-center rounded-xl text-slate-700 hover:bg-slate-100 border border-slate-200 transition-colors"
                    aria-label="Toggle mobile menu">
                <i class="fa-solid fa-bars text-sm"></i>
            </button>
        </div>
    </div>

    <%-- Mobile Nav Dropdown --%>
    <div id="mobileMenu" class="hidden md:hidden border-t border-slate-200 bg-white/95 backdrop-blur-md animate-slide-down">
        <nav class="w-[92vw] mx-auto py-4 flex flex-col gap-1.5 text-sm">
            <a href="${pageContext.request.contextPath}/"
               class="px-3.5 py-2.5 rounded-xl font-semibold transition-colors flex items-center gap-3
               ${param.activePage eq 'home' ? 'bg-slate-900 text-white' : 'text-slate-700 hover:bg-slate-100'}">
                <i class="fa-solid fa-house text-xs w-4"></i>Home
            </a>
            <a href="${pageContext.request.contextPath}/products"
               class="px-3.5 py-2.5 rounded-xl font-semibold transition-colors flex items-center gap-3
               ${param.activePage eq 'products' ? 'bg-slate-900 text-white' : 'text-slate-700 hover:bg-slate-100'}">
                <i class="fa-solid fa-box text-xs w-4"></i>Products
            </a>
            <a href="${pageContext.request.contextPath}/about"
               class="px-3.5 py-2.5 rounded-xl font-semibold transition-colors flex items-center gap-3
               ${param.activePage eq 'about' ? 'bg-slate-900 text-white' : 'text-slate-700 hover:bg-slate-100'}">
                <i class="fa-solid fa-circle-info text-xs w-4"></i>About Us
            </a>
            <a href="${pageContext.request.contextPath}/contact"
               class="px-3.5 py-2.5 rounded-xl font-semibold transition-colors flex items-center gap-3
               ${param.activePage eq 'contact' ? 'bg-slate-900 text-white' : 'text-slate-700 hover:bg-slate-100'}">
                <i class="fa-solid fa-phone text-xs w-4"></i>Contact Us
            </a>

            <c:if test="${not empty sessionScope.user}">
                <div class="h-px bg-slate-200 my-2"></div>
                <a href="${pageContext.request.contextPath}/cart"
                   class="px-3.5 py-2.5 rounded-xl text-slate-700 hover:bg-slate-100 font-semibold flex items-center gap-3">
                    <i class="fa-solid fa-cart-shopping text-xs w-4"></i>Cart
                </a>
                <a href="${pageContext.request.contextPath}/order-history"
                   class="px-3.5 py-2.5 rounded-xl text-slate-700 hover:bg-slate-100 font-semibold flex items-center gap-3">
                    <i class="fa-solid fa-box text-xs w-4"></i>My Orders
                </a>
                <a href="${pageContext.request.contextPath}/profile"
                   class="px-3.5 py-2.5 rounded-xl text-slate-700 hover:bg-slate-100 font-semibold flex items-center gap-3">
                    <i class="fa-regular fa-user text-xs w-4"></i>Profile
                </a>
                <a href="#"
                   class="px-3.5 py-2.5 rounded-xl text-danger hover:bg-red-50 font-semibold flex items-center gap-3"
                   onclick="confirmLogout()">
                    <i class="fa-solid fa-arrow-right-from-bracket text-xs w-4"></i>Logout
                </a>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <div class="h-px bg-slate-200 my-2"></div>
                <a href="${pageContext.request.contextPath}/login"
                   class="px-3.5 py-2.5 rounded-xl bg-slate-900 text-white font-bold text-center">
                    Sign in
                </a>
            </c:if>
        </nav>
    </div>
</header>

<script>
    const profileMenu = document.getElementById('profileMenu');
    const profileDropdown = document.getElementById('profileDropdown');
    const notificationMenu = document.getElementById('notificationMenu');
    const notificationDropdown = document.getElementById('notificationDropdown');
    const mobileMenu = document.getElementById('mobileMenu');

    function toggleProfileMenu() {
        if (profileMenu) {
            profileMenu.classList.toggle('hidden');
        }
        if (notificationMenu) {
            notificationMenu.classList.add('hidden');
        }
    }

    function toggleNotifications() {
        if (notificationMenu) {
            notificationMenu.classList.toggle('hidden');
        }
        if (profileMenu) {
            profileMenu.classList.add('hidden');
        }
    }

    function toggleMobileMenu() {
        if (mobileMenu) {
            mobileMenu.classList.toggle('hidden');
        }
    }

    // closing dropdowns on outside click
    document.addEventListener('click', (e) => {
        if (profileDropdown && !profileDropdown.contains(e.target)) {
            if (profileMenu) profileMenu.classList.add('hidden');
        }
        if (notificationDropdown && !notificationDropdown.contains(e.target)) {
            if (notificationMenu) notificationMenu.classList.add('hidden');
        }
    });

    // alert for logout
    function confirmLogout() {
        Swal.fire({
            title: "Logout?",
            text: "Are you sure you want to log out?",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#0F172A",
            cancelButtonColor: "#94A3B8",
            confirmButtonText: "Yes, logout",
            cancelButtonText: "Cancel",
            customClass: {
                popup: "font-poppins shadow-2xl border border-slate-100",
                confirmButton: "rounded-xl px-5 py-2.5 font-semibold text-sm",
                cancelButton: "rounded-xl px-5 py-2.5 font-semibold text-sm"
            }
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/logout";
            }
        });
    }
</script>

