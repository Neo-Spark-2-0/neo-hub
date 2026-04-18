<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<header class="bg-primary border-b border-gray-200 sticky top-0 z-50">
    <div class="w-[90vw] mx-auto flex items-center justify-between h-14 gap-4">

        <%-- ── Logo ── --%>
        <a href="${pageContext.request.contextPath}/"
           class="flex items-center gap-2 flex-shrink-0">
            <img src="${pageContext.request.contextPath}/static/images/logo.png"
                 alt="NEO-HUB"
                 class="h-7 w-auto"
                 onerror="this.style.display='none'" />
            <span class="text-base font-semibold text-accent tracking-tight">NEO-HUB</span>
        </a>

        <%-- ── Desktop nav links ── --%>
        <nav class="hidden md:flex items-center gap-0.5 text-sm flex-1 justify-center">
            <a href="${pageContext.request.contextPath}/"
               class="px-3 py-1.5 rounded-lg font-medium transition-colors
               ${param.activePage eq 'home' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                Home
            </a>
            <a href="${pageContext.request.contextPath}/products"
               class="px-3 py-1.5 rounded-lg font-medium transition-colors
               ${param.activePage eq 'products' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                Products
            </a>
            <a href="${pageContext.request.contextPath}/about"
               class="px-3 py-1.5 rounded-lg font-medium transition-colors
               ${param.activePage eq 'about' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                About Us
            </a>
        </nav>

        <%-- ── Right side icons ── --%>
        <div class="flex items-center gap-1 flex-shrink-0">

            <c:choose>
                <%-- ── LOGGED IN ── --%>
                <c:when test="${not empty sessionScope.user}">

                    <%-- Notifications --%>
                    <div class="relative">
                        <button onclick="toggleNotifications()"
                                class="w-9 h-9 flex items-center justify-center rounded-lg text-gray-600 hover:bg-gray-100 transition-colors">
                            <i class="fa fa-bell text-sm"></i>
                            <%-- Badge: show only when there are notifications --%>
                            <c:if test="${not empty sessionScope.notifCount and sessionScope.notifCount > 0}">
                                <span class="absolute top-1 right-1 bg-danger text-white text-[9px] font-bold
                                             w-3.5 h-3.5 flex items-center justify-center rounded-full">
                                    ${sessionScope.notifCount}
                                </span>
                            </c:if>
                        </button>

                        <%-- Notification dropdown --%>
                        <div id="notifDropdown"
                             class="hidden absolute right-0 top-full mt-1 w-72 bg-primary border border-gray-200
                                    rounded-xl shadow-md z-50 overflow-hidden">
                            <div class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                                <p class="text-xs font-semibold text-accent">Notifications</p>
                                <a href="${pageContext.request.contextPath}/notifications"
                                   class="text-[11px] text-gray-400 hover:text-accent transition-colors">See all</a>
                            </div>
                            <div class="py-2 px-4">
                                <p class="text-xs text-gray-400 py-2">No new notifications.</p>
                            </div>
                        </div>
                    </div>

                    <%-- Cart --%>
                    <a href="${pageContext.request.contextPath}/cart"
                       class="relative w-9 h-9 flex items-center justify-center rounded-lg text-gray-600
                              hover:bg-gray-100 transition-colors">
                        <i class="fa fa-cart-shopping text-sm"></i>
                        <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                            <span class="absolute top-1 right-1 bg-accent text-white text-[9px] font-bold
                                         w-3.5 h-3.5 flex items-center justify-center rounded-full">
                                ${sessionScope.cartCount}
                            </span>
                        </c:if>
                    </a>

                    <%-- Profile dropdown --%>
                    <div class="relative" id="profileDropdown">
                        <button onclick="toggleProfileMenu()"
                                class="flex items-center gap-2 pl-1 pr-2 py-1 rounded-lg hover:bg-gray-100 transition-colors">
                            <%-- Avatar --%>
                            <div class="w-7 h-7 rounded-full bg-gray-200 overflow-hidden flex items-center justify-center flex-shrink-0">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.profileImage}">
                                        <img src="${pageContext.request.contextPath}/${sessionScope.user.profileImage}"
                                             class="w-full h-full object-cover" alt="Photo" />
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-[11px] font-semibold text-gray-600">
                                            <c:out value="${fn:substring(sessionScope.user.fullName, 0, 2)}" />
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <span class="text-sm text-gray-700 font-medium hidden md:block">
                                <c:out value="${fn:split(sessionScope.user.fullName, ' ')[0]}" />
                            </span>
                            <i class="fa fa-chevron-down text-[10px] text-gray-400 hidden md:block"></i>
                        </button>

                        <%-- Profile dropdown menu --%>
                        <div id="profileMenu"
                             class="hidden absolute right-0 top-full mt-1 w-44 bg-primary border border-gray-200
                                    rounded-xl shadow-md py-1 z-50">
                            <div class="px-4 py-2 border-b border-gray-100">
                                <p class="text-xs font-semibold text-accent truncate">
                                    <c:out value="${sessionScope.user.fullName}" />
                                </p>
                                <p class="text-[11px] text-gray-400 truncate">
                                    <c:out value="${sessionScope.user.email}" />
                                </p>
                            </div>
                            <a href="${pageContext.request.contextPath}/profile"
                               class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 transition-colors">
                                <i class="fa fa-user text-xs text-gray-400 w-4 text-center"></i> Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/orders"
                               class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 transition-colors">
                                <i class="fa fa-box text-xs text-gray-400 w-4 text-center"></i> My Orders
                            </a>
                            <div class="h-[0.5px] bg-gray-200 my-1"></div>
                            <a href="${pageContext.request.contextPath}/logout"
                               class="flex items-center gap-2 px-4 py-2 text-sm text-danger hover:bg-red-50 transition-colors"
                               onclick="return confirm('Are you sure you want to logout?')">
                                <i class="fa fa-right-from-bracket text-xs w-4 text-center"></i> Logout
                            </a>
                        </div>
                    </div>

                </c:when>

                <%-- ── NOT LOGGED IN ── --%>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"
                       class="px-4 py-1.5 rounded-lg bg-accent text-white text-sm font-medium
                              hover:opacity-80 transition">
                        Sign in
                    </a>
                </c:otherwise>
            </c:choose>

            <%-- Mobile hamburger --%>
            <button onclick="toggleMobileMenu()"
                    class="md:hidden w-9 h-9 flex items-center justify-center rounded-lg text-gray-600 hover:bg-gray-100">
                <i class="fa fa-bars text-sm"></i>
            </button>
        </div>
    </div>

    <%-- ── Mobile nav dropdown ── --%>
    <div id="mobileMenu" class="hidden md:hidden border-t border-gray-200 bg-primary">
        <nav class="w-[90vw] mx-auto py-3 flex flex-col gap-1 text-sm">
            <a href="${pageContext.request.contextPath}/"
               class="px-3 py-2 rounded-lg font-medium transition-colors
               ${param.activePage eq 'home' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                <i class="fa fa-house mr-2 text-xs"></i>Home
            </a>
            <a href="${pageContext.request.contextPath}/products"
               class="px-3 py-2 rounded-lg font-medium transition-colors
               ${param.activePage eq 'products' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                <i class="fa fa-box mr-2 text-xs"></i>Products
            </a>
            <a href="${pageContext.request.contextPath}/about"
               class="px-3 py-2 rounded-lg font-medium transition-colors
               ${param.activePage eq 'about' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                <i class="fa fa-circle-info mr-2 text-xs"></i>About Us
            </a>
            <c:if test="${not empty sessionScope.user}">
                <div class="h-[0.5px] bg-gray-200 my-1"></div>
                <a href="${pageContext.request.contextPath}/cart"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium">
                    <i class="fa fa-cart-shopping mr-2 text-xs"></i>Cart
                    <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                        <span class="ml-1 bg-accent text-white text-[10px] px-1.5 py-0.5 rounded-full">${sessionScope.cartCount}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/orders"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium">
                    <i class="fa fa-bag-shopping mr-2 text-xs"></i>My Orders
                </a>
                <a href="${pageContext.request.contextPath}/profile"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium">
                    <i class="fa fa-user mr-2 text-xs"></i>Profile
                </a>
                <a href="${pageContext.request.contextPath}/logout"
                   class="px-3 py-2 rounded-lg text-danger hover:bg-red-50 font-medium"
                   onclick="return confirm('Are you sure you want to logout?')">
                    <i class="fa fa-right-from-bracket mr-2 text-xs"></i>Logout
                </a>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <div class="h-[0.5px] bg-gray-200 my-1"></div>
                <a href="${pageContext.request.contextPath}/login"
                   class="px-3 py-2 rounded-lg bg-accent text-white font-medium text-center">
                    Sign in
                </a>
            </c:if>
        </nav>
    </div>
</header>

<script>
    function toggleProfileMenu() {
        document.getElementById('profileMenu').classList.toggle('hidden');
        // close notif if open
        document.getElementById('notifDropdown') &&
        document.getElementById('notifDropdown').classList.add('hidden');
    }
    function toggleNotifications() {
        document.getElementById('notifDropdown').classList.toggle('hidden');
        document.getElementById('profileMenu').classList.add('hidden');
    }
    function toggleMobileMenu() {
        document.getElementById('mobileMenu').classList.toggle('hidden');
    }
    // Close dropdowns on outside click
    document.addEventListener('click', function(e) {
        const pd = document.getElementById('profileDropdown');
        if (pd && !pd.contains(e.target)) {
            document.getElementById('profileMenu').classList.add('hidden');
        }
        const nd = document.getElementById('notifDropdown');
        if (nd && !e.target.closest('button[onclick="toggleNotifications()"]') && !nd.contains(e.target)) {
            nd.classList.add('hidden');
        }
    });
</script>
