<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> 
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="${user.fullName} | Account Profile" />
    <jsp:param name="metaDescription" value="Profile and settings page on NEO-HUB." />
    <jsp:param name="metaKeywords" value="profile, NEO-HUB, settings" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-8">
        
        <!-- Breadcrumb Header -->
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-slate-200/80 pb-6">
            <div>
                <div class="flex items-center gap-2 text-xs font-semibold text-slate-500 mb-1">
                    <a href="${pageContext.request.contextPath}/" class="hover:text-slate-900 transition">Home</a>
                    <i class="fa-solid fa-chevron-right text-[9px] text-slate-400"></i>
                    <span class="text-slate-900 font-bold">My Account</span>
                </div>
                <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
                    Account Profile &amp; Settings
                </h1>
            </div>
            <span class="inline-flex items-center gap-2 px-3 py-1.5 rounded-2xl bg-white border border-slate-200 text-xs font-bold text-slate-700 shadow-subtle">
                <span class="w-2 h-2 rounded-full ${user.active ? 'bg-brand-500 animate-pulse' : 'bg-red-500'}"></span>
                ${user.active ? 'Account Active' : 'Account Suspended'}
            </span>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- Left Column: User Card & Navigation -->
            <div class="lg:col-span-4 flex flex-col gap-6">
                
                <!-- Avatar & Identity Card -->
                <div class="bg-white rounded-3xl border border-slate-200/80 p-6 sm:p-7 shadow-card flex flex-col items-center text-center relative overflow-hidden">
                    <form action="${pageContext.request.contextPath}/profile" method="post" id="photoForm" enctype="multipart/form-data" class="relative group cursor-pointer mb-4">
                        <input type="hidden" name="action" value="uploadPhoto" />
                        <div class="w-24 h-24 rounded-3xl bg-slate-100 border-2 border-slate-200 overflow-hidden flex items-center justify-center relative shadow-md group-hover:border-slate-900 transition-colors"
                             onclick="document.getElementById('photoInput').click()">
                            <c:choose>
                                <c:when test="${not empty user.profileImage}">
                                    <img src="${pageContext.request.contextPath}/uploads/${user.profileImage}" alt="Photo" class="w-full h-full object-cover"/>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-2xl font-black text-slate-800">
                                        <c:set var="parts" value="${fn:split(user.fullName, ' ')}" />
                                        ${fn:substring(parts[0], 0, 1)}
                                        <c:if test="${fn:length(parts) > 1}">
                                            ${fn:substring(parts[1], 0, 1)}
                                        </c:if>
                                    </span>
                                </c:otherwise>
                            </c:choose>

                            <!-- Hover Overlay for upload -->
                            <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center text-white text-xs font-bold">
                                <i class="fa-solid fa-camera mr-1"></i> Change
                            </div>
                        </div>
                        <input type="file" id="photoInput" name="profilePhoto" accept="image/png, image/jpeg, image/jpg" class="hidden"
                               onchange="document.getElementById('photoForm').submit()"/>
                    </form>

                    <h2 class="text-base sm:text-lg font-extrabold text-slate-900 leading-tight"><c:out value="${user.fullName}" /></h2>
                    <p class="text-xs text-slate-500 font-medium mt-0.5 truncate max-w-full"><c:out value="${user.email}" /></p>

                    <div class="mt-3 flex items-center gap-2">
                        <span class="px-3 py-1 rounded-xl text-[11px] font-bold tracking-wider uppercase ${user.role eq 'ADMIN' ? 'bg-purple-100 text-purple-700 border border-purple-200' : 'bg-slate-100 text-slate-700'}">
                            ${user.role eq 'ADMIN' ? 'Administrator' : 'Maker / Customer'}
                        </span>
                        <c:choose>
                            <c:when test="${user.emailVerified}">
                                <span class="px-2.5 py-1 rounded-xl bg-brand-50 border border-brand-200 text-brand-700 text-[11px] font-bold flex items-center gap-1">
                                    <i class="fa-solid fa-circle-check text-brand-600"></i> Verified
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-2.5 py-1 rounded-xl bg-amber-50 border border-amber-200 text-amber-700 text-[11px] font-bold flex items-center gap-1">
                                    <i class="fa-solid fa-triangle-exclamation"></i> Unverified
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Navigation Links -->
                    <div class="w-full pt-6 mt-6 border-t border-slate-100 flex flex-col gap-1.5 text-xs font-bold">
                        <a href="${pageContext.request.contextPath}/profile"
                           class="flex items-center gap-2.5 px-4 py-3 rounded-2xl bg-slate-900 text-white shadow-sm">
                            <i class="fa-solid fa-user-gear text-brand-400"></i>
                            <span>Profile &amp; Settings</span>
                        </a>
                        <c:if test="${user.role ne 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/order-history"
                               class="flex items-center gap-2.5 px-4 py-3 rounded-2xl text-slate-600 hover:text-slate-900 hover:bg-slate-100 transition">
                                <i class="fa-solid fa-receipt text-slate-400"></i>
                                <span>Order History</span>
                            </a>
                        </c:if>
                        <c:if test="${user.role eq 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard"
                               class="flex items-center gap-2.5 px-4 py-3 rounded-2xl text-purple-700 bg-purple-50 hover:bg-purple-100 transition">
                                <i class="fa-solid fa-gauge-high text-purple-600"></i>
                                <span>Admin Dashboard</span>
                            </a>
                        </c:if>
                        <button type="button"
                                onclick="confirmLogout()"
                                class="flex items-center gap-2.5 px-4 py-3 rounded-2xl text-danger hover:bg-red-50 transition text-left mt-2">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i>
                            <span>Sign Out</span>
                        </button>
                    </div>
                </div>

                <!-- Account Metadata Card -->
                <div class="bg-white rounded-3xl border border-slate-200/80 p-6 shadow-card space-y-3.5 text-xs font-medium text-slate-600">
                    <h3 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider pb-2 border-b border-slate-100">
                        Account Details
                    </h3>
                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Registered Since</span>
                        <span class="font-bold text-slate-900"><fmt:formatDate value="${user.createdAt}" pattern="MMMM dd, yyyy"/></span>
                    </div>
                    <div class="flex justify-between items-center">
                        <span class="text-slate-400">Last Profile Update</span>
                        <span class="font-bold text-slate-900"><fmt:formatDate value="${user.updatedAt}" pattern="MMMM dd, yyyy"/></span>
                    </div>
                </div>

            </div>

            <!-- Right Column: Settings Sections -->
            <div class="lg:col-span-8 flex flex-col gap-6">

                <!-- 1. Personal Information Section -->
                <section class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-6">
                    <form action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="updateProfile"/>
                        <input type="hidden" name="province" value="<c:out value="${user.province}" />"/>
                        <input type="hidden" name="district" value="<c:out value="${user.district}" />"/>
                        <input type="hidden" name="city" value="<c:out value="${user.city}" />"/>
                        <input type="hidden" name="localLevel" value="<c:out value="${user.localLevel}" />"/>
                        <input type="hidden" name="ward" value="<c:out value="${user.ward}" />"/>
                        <input type="hidden" name="street" value="<c:out value="${user.street}" />"/>
                        <input type="hidden" name="landmark" value="<c:out value="${user.landmark}" />"/>

                        <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                            <div>
                                <h2 class="text-sm font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
                                    <i class="fa-solid fa-address-card text-brand-600"></i>
                                    Personal Information
                                </h2>
                            </div>
                            <div>
                                <button type="button"
                                        id="personalEditButton"
                                        onclick="enablePersonalInformationEdit()"
                                        class="px-4 py-2 rounded-xl bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold transition shadow-sm flex items-center gap-1.5">
                                    <i class="fa-solid fa-pen-to-square text-[10px]"></i> Edit Details
                                </button>
                                <div id="personalActionButtons" class="hidden flex gap-2">
                                    <button type="submit" class="px-4 py-2 rounded-xl bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold transition">
                                        Save
                                    </button>
                                    <button type="button" onclick="cancelPersonalInformationEdit()" class="px-4 py-2 rounded-xl bg-slate-200 text-slate-700 text-xs font-bold hover:bg-slate-300 transition">
                                        Cancel
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 pt-4">
                            <!-- Name -->
                            <div class="space-y-1.5">
                                <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Full Name</label>
                                <p class="text-sm font-bold text-slate-900 view-mode-personal"><c:out value="${user.fullName}" /></p>
                                <input type="text" name="fullName" value="<c:out value='${user.fullName}' />"
                                       class="hidden edit-mode-personal w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20" required/>
                            </div>

                            <!-- Phone -->
                            <div class="space-y-1.5">
                                <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Phone Number</label>
                                <p class="text-sm font-bold text-slate-900 view-mode-personal">+977 <c:out value="${user.phone}" /></p>
                                <input type="text" name="phone" value="<c:out value='${user.phone}' />"
                                       placeholder="98XXXXXXXX"
                                       class="hidden edit-mode-personal w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20" required/>
                            </div>

                            <!-- Email -->
                            <div class="space-y-1.5">
                                <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Email Address (Read-only)</label>
                                <p class="text-sm font-bold text-slate-900 break-all"><c:out value="${user.email}" /></p>
                            </div>

                            <!-- Status -->
                            <div class="space-y-1.5">
                                <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Email Verification</label>
                                <div>
                                    <c:choose>
                                        <c:when test="${user.emailVerified}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-xl bg-brand-50 border border-brand-200 text-brand-700 text-xs font-bold">
                                                <i class="fa-solid fa-circle-check"></i> Email Verified
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-xl bg-amber-50 border border-amber-200 text-amber-700 text-xs font-bold">
                                                <i class="fa-solid fa-circle-exclamation"></i> Not Verified
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </form>
                </section>

                <!-- 2. Shipping Address Section -->
                <c:if test="${user.role ne 'ADMIN'}">
                    <section class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-6">
                        <form id="address-form" action="${pageContext.request.contextPath}/profile" method="post">
                            <input type="hidden" name="action" value="updateProfile"/>
                            <input type="hidden" name="fullName" value="${user.fullName}"/>
                            <input type="hidden" name="phone" value="${user.phone}"/>

                            <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                                <div>
                                    <h2 class="text-sm font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
                                        <i class="fa-solid fa-map-location-dot text-brand-600"></i>
                                        Shipping &amp; Delivery Destination
                                    </h2>
                                </div>
                                <div>
                                    <button type="button"
                                            id="addressEditButton"
                                            onclick="enableAddressEdit()"
                                            class="px-4 py-2 rounded-xl bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold transition shadow-sm flex items-center gap-1.5">
                                        <i class="fa-solid fa-pen-to-square text-[10px]"></i> Edit Address
                                    </button>
                                    <div id="addressActionButtons" class="hidden flex gap-2">
                                        <button type="submit" class="px-4 py-2 rounded-xl bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold transition">
                                            Save
                                        </button>
                                        <button type="button" onclick="cancelAddressEdit()" class="px-4 py-2 rounded-xl bg-slate-200 text-slate-700 text-xs font-bold hover:bg-slate-300 transition">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 pt-4">
                                <!-- Province -->
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Province</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.province}" default="Not set"/>
                                    </p>
                                    <select name="province" class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900">
                                        <option value="">Select Province</option>
                                        <c:forEach var="p" items="${['Koshi','Madhesh','Bagmati','Gandaki','Lumbini','Karnali','Sudurpashchim']}">
                                            <option value="${p}" ${user.province eq p ? 'selected' : ''}>${p}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- District -->
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">District</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.district}" default="Not set"/>
                                    </p>
                                    <input type="text" name="district" value="<c:out value='${user.district}' />"
                                           placeholder="e.g. Kaski, Kathmandu"
                                           class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900"/>
                                </div>

                                <!-- City -->
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">City / Town</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.city}" default="Not set"/>
                                    </p>
                                    <input type="text" name="city" value="<c:out value='${user.city}' />"
                                           placeholder="e.g. Pokhara, Lalitpur"
                                           class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900"/>
                                </div>

                                <!-- Municipality -->
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Municipality / Local Level</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.localLevel}" default="Not set"/>
                                    </p>
                                    <input type="text" name="localLevel" value="<c:out value='${user.localLevel}' />"
                                           placeholder="e.g. Pokhara Metropolitan City"
                                           class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900"/>
                                </div>

                                <!-- Ward -->
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Ward No.</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.ward}" default="Not set"/>
                                    </p>
                                    <input type="text" name="ward" value="<c:out value='${user.ward}' />"
                                           placeholder="e.g. 15"
                                           class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900"/>
                                </div>

                                <!-- Street / Tole -->
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Street / Tole</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.street}" default="Not set"/>
                                    </p>
                                    <input type="text" name="street" value="<c:out value='${user.street}' />"
                                           placeholder="e.g. Nayabazar"
                                           class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900"/>
                                </div>

                                <!-- Landmark -->
                                <div class="sm:col-span-2 space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Nearby Landmark</label>
                                    <p class="text-sm font-bold text-slate-900 view-mode-address">
                                        <c:out value="${user.landmark}" default="Not set"/>
                                    </p>
                                    <input type="text" name="landmark" value="<c:out value='${user.landmark}' />"
                                           placeholder="e.g. Opposite to Red Cross Building"
                                           class="hidden edit-mode-address w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900"/>
                                </div>
                            </div>
                        </form>
                    </section>
                </c:if>

                <!-- 3. Security & Password Section -->
                <section class="bg-white border border-slate-200/80 rounded-3xl p-6 sm:p-7 shadow-card space-y-6">
                    <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                        <h2 class="text-sm font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
                            <i class="fa-solid fa-lock text-brand-600"></i>
                            Security &amp; Account Protection
                        </h2>
                    </div>

                    <div class="space-y-4">
                        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 p-4 rounded-2xl bg-slate-50 border border-slate-100">
                            <div>
                                <h4 class="text-xs font-bold text-slate-900">Account Password</h4>
                                <p class="text-[11px] text-slate-500 font-medium">Update your password regularly to keep your projects and orders safe.</p>
                            </div>
                            <button type="button" onclick="togglePassword()"
                                    class="px-4 py-2 rounded-xl bg-white border border-slate-200 text-slate-800 text-xs font-bold hover:bg-slate-100 transition shadow-subtle flex items-center gap-1.5 whitespace-nowrap">
                                <i class="fa-solid fa-key text-[10px]"></i> Change Password
                            </button>
                        </div>

                        <!-- Change Password Dropdown Panel -->
                        <div id="password-section" class="hidden p-5 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-4">
                            <form action="${pageContext.request.contextPath}/profile" method="post" class="space-y-3.5">
                                <input type="hidden" name="action" value="changePassword"/>

                                <div class="space-y-1">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Current Password</label>
                                    <input type="password" name="currentPassword" required
                                           class="w-full px-3.5 py-2 bg-white border border-slate-200 rounded-xl text-xs font-semibold focus:outline-none focus:ring-2 focus:ring-brand-500/20"/>
                                </div>
                                <div class="space-y-1">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">New Password</label>
                                    <input type="password" name="newPassword" required
                                           class="w-full px-3.5 py-2 bg-white border border-slate-200 rounded-xl text-xs font-semibold focus:outline-none focus:ring-2 focus:ring-brand-500/20"/>
                                </div>
                                <div class="space-y-1">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Confirm New Password</label>
                                    <input type="password" name="confirmPassword" required
                                           class="w-full px-3.5 py-2 bg-white border border-slate-200 rounded-xl text-xs font-semibold focus:outline-none focus:ring-2 focus:ring-brand-500/20"/>
                                </div>

                                <div class="flex gap-2 pt-2">
                                    <button type="submit" class="px-5 py-2.5 rounded-xl bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold transition">
                                        Update Password
                                    </button>
                                    <button type="button" onclick="togglePassword()" class="px-4 py-2.5 rounded-xl bg-slate-200 text-slate-700 text-xs font-bold hover:bg-slate-300 transition">
                                        Cancel
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Danger Zone -->
                        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 p-4 rounded-2xl bg-red-50 border border-red-200/80">
                            <div>
                                <h4 class="text-xs font-bold text-danger">Delete Account</h4>
                                <p class="text-[11px] text-red-600 font-medium">Permanently delete your profile, orders, and addresses.</p>
                            </div>
                            <form action="${pageContext.request.contextPath}/profile" method="post" id="deleteForm">
                                <input type="hidden" name="action" value="deleteAccount"/>
                                <button type="button" onclick="confirmDelete()"
                                        class="px-4 py-2 rounded-xl bg-white border border-red-300 text-danger text-xs font-bold hover:bg-red-100 transition whitespace-nowrap">
                                    Delete Account
                                </button>
                            </form>
                        </div>

                    </div>
                </section>

            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />

    <script>
        // Personal info edit toggler
        const personalEditButton = document.querySelector("#personalEditButton");
        const personalActionButtons = document.querySelector("#personalActionButtons");

        function enablePersonalInformationEdit() {
            personalEditButton.classList.add("hidden");
            personalActionButtons.classList.remove("hidden");
            document.querySelectorAll(".view-mode-personal").forEach(el => el.classList.add("hidden"));
            document.querySelectorAll(".edit-mode-personal").forEach(el => el.classList.remove("hidden"));
        }

        function cancelPersonalInformationEdit() {
            personalEditButton.classList.remove("hidden");
            personalActionButtons.classList.add("hidden");
            document.querySelectorAll(".view-mode-personal").forEach(el => el.classList.remove("hidden"));
            document.querySelectorAll(".edit-mode-personal").forEach(el => el.classList.add("hidden"));
        }

        // Address info edit toggler
        const addressEditButton = document.querySelector("#addressEditButton");
        const addressActionButtons = document.querySelector("#addressActionButtons");
        
        function enableAddressEdit() {
            if (addressEditButton) addressEditButton.classList.add("hidden");
            if (addressActionButtons) addressActionButtons.classList.remove("hidden");
            document.querySelectorAll(".view-mode-address").forEach(el => el.classList.add("hidden"));
            document.querySelectorAll(".edit-mode-address").forEach(el => el.classList.remove("hidden"));
        }

        function cancelAddressEdit(){
            if (addressEditButton) addressEditButton.classList.remove("hidden");
            if (addressActionButtons) addressActionButtons.classList.add("hidden");
            document.querySelectorAll(".view-mode-address").forEach(el => el.classList.remove("hidden"));
            document.querySelectorAll(".edit-mode-address").forEach(el => el.classList.add("hidden"));
        }

        // Password section toggler
        const passwordSection = document.querySelector("#password-section");
        function togglePassword() {
            passwordSection.classList.toggle("hidden");
        }

        // SweetAlert2 delete confirmation
        function confirmDelete() {
            Swal.fire({
                title: "Are you sure?",
                text: "This action cannot be undone! Your account data will be permanently wiped.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#ef4444",
                cancelButtonColor: "#64748b",
                confirmButtonText: "Yes, delete account"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById("deleteForm").submit();
                }
            });
        }

        // SweetAlert2 logout confirmation
        function confirmLogout() {
            Swal.fire({
                title: "Sign Out?",
                text: "You will be signed out of your current session.",
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: "#0f172a",
                cancelButtonColor: "#64748b",
                confirmButtonText: "Yes, sign out"
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "${pageContext.request.contextPath}/logout";
                }
            });
        }

        // Server flash toasts
        <c:if test="${not empty profileSuccess}">
            showToast("<c:out value='${profileSuccess}' />", "success");
        </c:if>

        <c:if test="${not empty passwordSuccess}">
            showToast("<c:out value='${passwordSuccess}' />", "success");
        </c:if>

        <c:if test="${not empty profileError}">
            showToast("<c:out value='${profileError}' />", "error");
        </c:if>

        <c:if test="${not empty passwordError}">
            showToast("<c:out value='${passwordError}' />", "error");
        </c:if>

        <c:if test="${not empty deleteError}">
            showToast("<c:out value='${deleteError}' />", "error");
        </c:if>
    </script>
</body>
</html>
