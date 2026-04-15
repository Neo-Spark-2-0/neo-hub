<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Profile</title>
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>
<body class="bg-gray-50 min-h-screen">

<div class="max-w-6xl mx-auto px-4 py-8 flex flex-col md:flex-row gap-6">

    <%-- ====== LEFT: Sidebar ====== --%>
    <aside class="w-full md:w-72 shrink-0 bg-white rounded-2xl border border-gray-200 p-6 flex flex-col items-center gap-3 self-start">

        <%-- Avatar --%>
        <div class="w-24 h-24 rounded-full overflow-hidden border-2 border-gray-200">
            <c:choose>
                <c:when test="${not empty user.profileImage}">
                    <img src="${pageContext.request.contextPath}/${user.profileImage}"
                         alt="Profile Photo" class="w-full h-full object-cover" />
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                         alt="Default Avatar" class="w-full h-full object-cover" />
                </c:otherwise>
            </c:choose>
        </div>

        <h3 class="text-lg font-semibold text-gray-900 text-center">${user.fullName}</h3>
        <p class="text-sm text-gray-500 text-center -mt-2">${user.email}</p>

        <span class="px-3 py-1 rounded-full text-xs font-medium
            ${user.role eq 'ADMIN'
                ? 'bg-purple-100 text-purple-700'
                : 'bg-blue-100 text-blue-700'}">
            ${user.role}
        </span>

        <%-- Upload Photo --%>
        <form action="${pageContext.request.contextPath}/profile"
              method="post" enctype="multipart/form-data" class="w-full">
            <input type="hidden" name="action" value="uploadPhoto" />
            <label for="profilePhoto"
                   class="block w-full text-center cursor-pointer px-4 py-2 rounded-lg border border-gray-300 text-sm text-gray-600 hover:bg-gray-50 transition">
                Choose Photo
            </label>
            <input type="file" id="profilePhoto" name="profilePhoto"
                   accept="image/*" class="hidden"
                   onchange="this.form.submit()" />
        </form>

        <c:if test="${not empty photoSuccess}">
            <p class="text-xs text-green-600 bg-green-50 rounded-lg px-3 py-2 w-full text-center">${photoSuccess}</p>
        </c:if>
        <c:if test="${not empty photoError}">
            <p class="text-xs text-red-600 bg-red-50 rounded-lg px-3 py-2 w-full text-center">${photoError}</p>
        </c:if>

        <%-- Quick info --%>
        <ul class="w-full mt-2 divide-y divide-gray-100 text-sm">
            <li class="flex justify-between items-center py-3">
                <span class="text-gray-500">Phone</span>
                <span class="text-gray-800 font-medium">
                    ${not empty user.phone ? user.phone : 'Not set'}
                </span>
            </li>
            <li class="flex justify-between items-center py-3">
                <span class="text-gray-500">Email</span>
                <c:choose>
                    <c:when test="${user.isEmailVerified}">
                        <span class="px-2 py-0.5 rounded-full text-xs bg-green-100 text-green-700">Verified</span>
                    </c:when>
                    <c:otherwise>
                        <span class="px-2 py-0.5 rounded-full text-xs bg-red-100 text-red-700">Not Verified</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li class="flex justify-between items-center py-3">
                <span class="text-gray-500">Member Since</span>
                <span class="text-gray-800 font-medium">NEO-HUB Member</span>
            </li>
        </ul>
    </aside>

    <%-- ====== RIGHT: Main Content ====== --%>
    <main class="flex-1 bg-white rounded-2xl border border-gray-200 p-6">

        <%-- Tab Nav --%>
        <div class="flex gap-1 bg-gray-100 rounded-xl p-1 mb-6">
            <button class="tab-btn flex-1 py-2 px-4 rounded-lg text-sm font-medium transition-all text-gray-500 hover:text-gray-700"
                    data-tab="personal">
                Personal Info
            </button>
            <button class="tab-btn flex-1 py-2 px-4 rounded-lg text-sm font-medium transition-all text-gray-500 hover:text-gray-700"
                    data-tab="address">
                Address
            </button>
            <button class="tab-btn flex-1 py-2 px-4 rounded-lg text-sm font-medium transition-all text-gray-500 hover:text-gray-700"
                    data-tab="password">
                Change Password
            </button>
        </div>

        <%-- Shared alerts --%>
        <c:if test="${not empty profileSuccess}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-green-50 text-green-700 text-sm border border-green-200">${profileSuccess}</div>
        </c:if>
        <c:if test="${not empty profileError}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-red-50 text-red-700 text-sm border border-red-200">${profileError}</div>
        </c:if>

        <%-- ===== TAB 1: Personal Info ===== --%>
        <section class="tab-panel hidden" id="tab-personal">
            <h2 class="text-base font-semibold text-gray-900 mb-5">Personal Information</h2>
            <form action="${pageContext.request.contextPath}/profile" method="post" class="space-y-4">
                <input type="hidden" name="action" value="updateProfile" />

                <div>
                    <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition" />
                </div>

                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <input type="email" id="email" value="${user.email}" disabled
                           class="w-full px-3 py-2 rounded-lg border border-gray-200 text-sm bg-gray-50 text-gray-400 cursor-not-allowed" />
                    <p class="text-xs text-gray-400 mt-1">Email cannot be changed.</p>
                </div>

                <div>
                    <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                    <input type="text" id="phone" name="phone" value="${user.phone}" placeholder="98XXXXXXXX" required
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition" />
                </div>

                <%-- Hidden address fields --%>
                <input type="hidden" name="province" value="${user.province}" />
                <input type="hidden" name="district" value="${user.district}" />
                <input type="hidden" name="city"     value="${user.city}"     />
                <input type="hidden" name="ward"     value="${user.ward}"     />
                <input type="hidden" name="street"   value="${user.street}"   />
                <input type="hidden" name="landmark" value="${user.landmark}" />

                <button type="submit"
                        class="px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium transition">
                    Save Changes
                </button>
            </form>
        </section>

        <%-- ===== TAB 2: Address ===== --%>
        <section class="tab-panel hidden" id="tab-address">
            <h2 class="text-base font-semibold text-gray-900 mb-5">Address Information</h2>
            <form action="${pageContext.request.contextPath}/profile" method="post" class="space-y-4">
                <input type="hidden" name="action" value="updateProfile" />
                <input type="hidden" name="fullName" value="${user.fullName}" />
                <input type="hidden" name="phone"    value="${user.phone}"    />

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="province" class="block text-sm font-medium text-gray-700 mb-1">Province</label>
                        <select id="province" name="province"
                                class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition bg-white">
                            <option value="">-- Select Province --</option>
                            <c:forEach var="p" items="${['Koshi','Madhesh','Bagmati','Gandaki','Lumbini','Karnali','Sudurpashchim']}">
                                <option value="${p}" ${user.province eq p ? 'selected' : ''}>${p}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="district" class="block text-sm font-medium text-gray-700 mb-1">District</label>
                        <input type="text" id="district" name="district" value="${user.district}" placeholder="e.g. Kathmandu"
                               class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="city" class="block text-sm font-medium text-gray-700 mb-1">City / Municipality</label>
                        <input type="text" id="city" name="city" value="${user.city}" placeholder="e.g. Lalitpur"
                               class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                    </div>
                    <div>
                        <label for="ward" class="block text-sm font-medium text-gray-700 mb-1">Ward No.</label>
                        <input type="text" id="ward" name="ward" value="${user.ward}" placeholder="e.g. 5"
                               class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                    </div>
                </div>

                <div>
                    <label for="street" class="block text-sm font-medium text-gray-700 mb-1">Street / Tole</label>
                    <input type="text" id="street" name="street" value="${user.street}" placeholder="e.g. Putalisadak"
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                </div>

                <div>
                    <label for="landmark" class="block text-sm font-medium text-gray-700 mb-1">Landmark</label>
                    <input type="text" id="landmark" name="landmark" value="${user.landmark}" placeholder="e.g. Near Shankar Hotel"
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                </div>

                <button type="submit"
                        class="px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium transition">
                    Save Address
                </button>
            </form>
        </section>

        <%-- ===== TAB 3: Change Password ===== --%>
        <section class="tab-panel hidden" id="tab-password">
            <h2 class="text-base font-semibold text-gray-900 mb-5">Change Password</h2>

            <c:if test="${not empty passwordSuccess}">
                <div class="mb-4 px-4 py-3 rounded-lg bg-green-50 text-green-700 text-sm border border-green-200">${passwordSuccess}</div>
            </c:if>
            <c:if test="${not empty passwordError}">
                <div class="mb-4 px-4 py-3 rounded-lg bg-red-50 text-red-700 text-sm border border-red-200">${passwordError}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/profile" method="post" class="space-y-4">
                <input type="hidden" name="action" value="changePassword" />

                <div>
                    <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                </div>

                <div>
                    <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                </div>

                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           class="w-full px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                </div>

                <button type="submit"
                        class="px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium transition">
                    Change Password
                </button>
            </form>
        </section>

    </main>
</div>

<script>
    const tabBtns   = document.querySelectorAll('.tab-btn');
    const tabPanels = document.querySelectorAll('.tab-panel');

    const hasPasswordMsg = ${not empty passwordSuccess or not empty passwordError};
    const hasProfileMsg  = ${not empty profileSuccess  or not empty profileError};

    if (hasPasswordMsg) activateTab('password');
    else if (hasProfileMsg) activateTab('personal');
    else activateTab('personal');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => activateTab(btn.dataset.tab));
    });

    function activateTab(name) {
        tabBtns.forEach(b => {
            const isActive = b.dataset.tab === name;
            b.classList.toggle('bg-white', isActive);
            b.classList.toggle('text-gray-900', isActive);
            b.classList.toggle('shadow-sm', isActive);
            b.classList.toggle('text-gray-500', !isActive);
        });
        tabPanels.forEach(p => {
            p.classList.toggle('hidden', p.id !== 'tab-' + name);
        });
    }
</script>
</body>
</html>