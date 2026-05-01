<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<header class="bg-primary border-b border-gray-200 sticky top-0 z-50">
    <div class="w-[90vw] mx-auto flex items-center justify-between h-14 gap-4">

        <!-- logo  -->
        <a href="${pageContext.request.contextPath}/"
           class="flex items-center gap-2 flex-shrink-0">
            <img src="${pageContext.request.contextPath}/static/images/neo-hub-logo.png"
                 alt="NEO-HUB"
                 class="h-20 w-auto">
        </a>

        <!-- links  -->
        <nav class="hidden md:flex items-center gap-0.5 text-sm justify-center">
            <a href="${pageContext.request.contextPath}/"
               class="px-3 py-1.5 rounded-lg font-medium transition
               ${param.activePage eq 'home' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                Home
            </a>
            <a href="${pageContext.request.contextPath}/products"
               class="px-3 py-1.5 rounded-lg font-medium transition
               ${param.activePage eq 'products' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                Products
            </a>
            <a href="${pageContext.request.contextPath}/about"
               class="px-3 py-1.5 rounded-lg font-medium transition
               ${param.activePage eq 'about' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                About Us
            </a>
            <a href="${pageContext.request.contextPath}/contact"
               class="px-3 py-1.5 rounded-lg font-medium transition
               ${param.activePage eq 'contact' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                Contact Us
            </a>
        </nav>

        <!-- right section icons  -->
        <div class="flex items-center gap-1">

        <c:choose>
            <%-- logged in details shown in nav bar --%>
            <c:when test="${not empty sessionScope.user}">

                    <%-- Notification button --%>
                    <div class="relative" id="notificationDropdown">
                        <button onclick="toggleNotifications()"
                                class="w-9 h-9 flex items-center justify-center rounded-lg text-gray-600 hover:bg-gray-100 transition-colors">
                            <i class="fa fa-bell text-sm"></i>
                        </button>

                        <%-- Notification panel --%>
                        <div id="notificationMenu"
                             class="hidden absolute right-[-120px] md:right-0 top-full mt-1 w-72 bg-primary border border-gray-200
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

                    <%-- Cart button --%>
                    <a href="${pageContext.request.contextPath}/cart"
                       class="relative w-9 h-9 flex items-center justify-center rounded-lg text-gray-600 hover:bg-gray-100 transition-colors">
                        <i class="fa fa-cart-shopping text-sm"></i>
                    </a>

                    <%-- Profile dropdown --%>
                    <div class="relative" id="profileDropdown">
                        <button onclick="toggleProfileMenu()"
                                class="flex items-center gap-2 pl-1 pr-2 py-1 rounded-lg hover:bg-gray-100 transition-colors">

                            <!-- profile image avatar  -->
                            <div class="w-7 h-7 rounded-full bg-gray-200 overflow-hidden flex items-center justify-center flex-shrink-0">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.profileImage}">
                                        <img src="${pageContext.request.contextPath}/${sessionScope.user.profileImage}"
                                             class="w-full h-full object-cover" alt="Photo" />
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-[11px] font-semibold text-gray-600">

                                    <c:set var="parts" value="${fn:split(sessionScope.user.fullName, ' ')}" />
                                    ${fn:substring(parts[0], 0, 1)}
                                    <c:if test="${fn:length(parts) > 1}">
                                    ${fn:substring(parts[1], 0, 1)}
                                    </c:if>
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
                             class="hidden absolute right-0 top-full mt-1 w-54 bg-primary border border-gray-200
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
                            <a href="#"
                               class="flex items-center gap-2 px-4 py-2 text-sm text-danger hover:bg-red-50 transition-colors"
                               onclick="confirmLogout()">
                                <i class="fa fa-right-from-bracket text-xs w-4 text-center"></i> Logout
                            </a>
                        </div>
                    </div>

                </c:when>
                <%-- when user is logged in --%>   
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"
                       class="px-4 py-1.5 rounded-lg bg-accent text-white text-sm font-medium
                              hover:opacity-80 transition">
                        Sign in
                    </a>
                </c:otherwise>
            </c:choose>

            <%-- Mobile menu button --%>
            <button onclick="toggleMobileMenu()"
                    class="md:hidden w-9 h-9 flex items-center justify-center rounded-lg text-gray-600 hover:bg-gray-100">
                <i class="fa fa-bars text-sm"></i>
            </button>
        </div>
    </div>

    <%-- Mobile nav dropdown  --%>
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
            <a href="${pageContext.request.contextPath}/contact"
               class="px-3 py-2 rounded-lg font-medium transition-colors
               ${param.activePage eq 'contact' ? 'bg-gray-900 text-white' : 'text-gray-600 hover:bg-gray-100'}">
                <i class="fa fa-phone mr-2 text-xs"></i>Contact Us
            </a>

            <c:if test="${not empty sessionScope.user}">
                <div class="h-[0.5px] bg-gray-200 my-1"></div>
                <a href="${pageContext.request.contextPath}/cart"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium">
                    <i class="fa fa-cart-shopping mr-2 text-xs"></i>Cart
                </a>
                <a href="${pageContext.request.contextPath}/orders"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium">
                    <i class="fa fa-bag-shopping mr-2 text-xs"></i>My Orders
                </a>
                <a href="${pageContext.request.contextPath}/profile"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium">
                    <i class="fa fa-user mr-2 text-xs"></i>Profile
                </a>
                <a href="#"
                   class="px-3 py-2 rounded-lg text-danger hover:bg-red-50 font-medium"
                   onclick="confirmLogout()">
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
    const profileMenu = document.getElementById('profileMenu');
    const profileDropdown = document.getElementById('profileDropdown');
    const notificationMenu = document.getElementById('notificationMenu');
    const notificationDropdown = document.getElementById('notificationDropdown');
    const mobileMenu = document.getElementById('mobileMenu');

    function toggleProfileMenu() {
        profileMenu.classList.toggle('hidden');
        notificationMenu.classList.add('hidden');
    }

    function toggleNotifications() {
        notificationMenu.classList.toggle('hidden');
        profileMenu.classList.add('hidden');
    }

    function toggleMobileMenu() {
        mobileMenu.classList.toggle('hidden');
    }

    // closing dropdowns on outside click
    document.addEventListener('click', (e) => {
        if (!profileDropdown.contains(e.target)) {
            profileMenu.classList.add('hidden');
        }
        if (!notificationDropdown.contains(e.target)) {
            notificationMenu.classList.add('hidden');
        }
    });

    // alert for logout
    function confirmLogout() {
        Swal.fire({
            title: "Logout?",
            text: "You will be logged out of your account.",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#ef4444",
            cancelButtonColor: "#6b7280",
            confirmButtonText: "Yes, logout"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/logout";
            }
        });
    }

</script>
