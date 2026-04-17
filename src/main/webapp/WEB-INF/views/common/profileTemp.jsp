<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core"      %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"       %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${user.fullName} Profile – NEO-HUB</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;0,9..40,600&display=swap');
        body { font-family: 'DM Sans', sans-serif; }
        /* Inputs not easily done with Tailwind alone */
        .field-input {
            width: 100%;
            font-size: 0.8125rem;
            padding: 6px 10px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #fff;
            color: #111827;
            outline: none;
            transition: border-color 0.15s;
        }
        .field-input:focus { border-color: #6b7280; }
        .field-input:disabled { background: #f9fafb; color: #9ca3af; cursor: not-allowed; }
        select.field-input { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%236b7280' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 10px center; padding-right: 28px; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen py-10">

<%-- ═══ TOAST ═══ --%>
<div id="toast"
     class="fixed top-5 right-5 z-50 hidden items-center gap-2 bg-gray-900 text-white text-xs px-4 py-2.5 rounded-xl shadow-lg">
    <span class="w-1.5 h-1.5 rounded-full bg-green-400 flex-shrink-0"></span>
    <span id="toast-msg">Saved</span>
</div>

<%-- Server-side toasts --%>
<c:if test="${not empty profileSuccess or not empty photoSuccess}">
    <div id="server-toast"
         class="fixed top-5 right-5 z-50 flex items-center gap-2 bg-gray-900 text-white text-xs px-4 py-2.5 rounded-xl shadow-lg">
        <span class="w-1.5 h-1.5 rounded-full bg-green-400 flex-shrink-0"></span>
        <span>${not empty profileSuccess ? profileSuccess : photoSuccess}</span>
    </div>
</c:if>

<div class="max-w-3xl mx-auto px-4 flex gap-5">

    <%-- ═══ SIDEBAR ═══ --%>
    <aside class="w-44 flex-shrink-0">
        <div class="bg-white border border-gray-200 rounded-2xl p-5 flex flex-col items-center gap-1 sticky top-10">

            <%-- Avatar / Photo Upload --%>
            <form action="${pageContext.request.contextPath}/profile" method="post"
                  enctype="multipart/form-data" id="photoForm">
                <input type="hidden" name="action" value="uploadPhoto"/>
                <div class="w-14 h-14 rounded-full bg-blue-50 border-2 border-gray-200 overflow-hidden
                            flex items-center justify-content-center cursor-pointer
                            hover:border-blue-400 transition-colors mb-2"
                     onclick="document.getElementById('photoInput').click()"
                     title="Click to change photo">
                    <c:choose>
                        <c:when test="${not empty user.profileImage}">
                            <img src="${pageContext.request.contextPath}/${user.profileImage}"
                                 alt="Photo" class="w-full h-full object-cover"/>
                        </c:when>
                        <c:otherwise>
                            <span class="text-base font-semibold text-blue-500 w-full h-full flex items-center justify-center">
                                ${fn:substring(user.fullName, 0, 2)}
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <input type="file" id="photoInput" name="profilePhoto" accept="image/*" class="hidden"
                       onchange="document.getElementById('photoForm').submit()"/>
            </form>

            <p class="text-sm font-semibold text-gray-800">${user.fullName}</p>
            <span class="text-xs bg-gray-100 text-gray-500 px-3 py-0.5 rounded-full mb-4">
                ${user.role eq 'ADMIN' ? 'Admin' : 'Customer'}
            </span>

            <nav class="w-full flex flex-col gap-0.5 text-sm">
                <a href="${pageContext.request.contextPath}/profile"
                   class="px-3 py-2 rounded-lg font-medium bg-gray-900 text-white">Profile</a>
                <a href="${pageContext.request.contextPath}/orders"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 transition-colors">Orders</a>
                <a href="${pageContext.request.contextPath}/rewards"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 transition-colors">Rewards</a>
                <a href="${pageContext.request.contextPath}/logout"
                   class="px-3 py-2 rounded-lg text-red-500 hover:bg-red-50 transition-colors mt-1">Logout</a>
            </nav>
        </div>
    </aside>

    <%-- ═══ MAIN ═══ --%>
    <main class="flex-1 flex flex-col gap-3">

        <%-- ── Personal Information ── --%>
        <section class="bg-white border border-gray-200 rounded-2xl p-6">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-sm font-semibold text-gray-900">Personal information</h2>
                <div id="personal-btns" data-editing="0">
                    <button onclick="toggleEdit('personal')"
                            class="text-xs px-3 py-1.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-gray-700">
                        Edit
                    </button>
                </div>
            </div>

            <%-- Error banner --%>
            <c:if test="${not empty profileError}">
                <p class="text-xs text-red-600 bg-red-50 border border-red-200 rounded-lg px-3 py-2 mb-4">${profileError}</p>
            </c:if>

            <%-- The form wraps the fields; hidden when not editing --%>
            <form id="personal-form" action="${pageContext.request.contextPath}/profile"
                  method="post" class="hidden">
                <input type="hidden" name="action"   value="updateProfile"/>
                <%-- Address fields preserved during personal update --%>
                <input type="hidden" name="province" value="${user.province}"/>
                <input type="hidden" name="district" value="${user.district}"/>
                <input type="hidden" name="city"     value="${user.city}"/>
                <input type="hidden" name="ward"     value="${user.ward}"/>
                <input type="hidden" name="street"   value="${user.street}"/>
                <input type="hidden" name="landmark" value="${user.landmark}"/>
            </form>

            <div class="grid grid-cols-2 gap-x-8 gap-y-4">

                <%-- Full Name --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Full name</label>
                    <p class="text-sm text-gray-800" id="view-fullName">${user.fullName}</p>
                    <input class="field-input hidden" id="edit-fullName"
                           type="text" name="fullName" value="${user.fullName}"
                           form="personal-form" required/>
                </div>

                <%-- Phone --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Phone</label>
                    <p class="text-sm text-gray-800" id="view-phone">+977 ${user.phone}</p>
                    <input class="field-input hidden" id="edit-phone"
                           type="text" name="phone" value="${user.phone}"
                           form="personal-form" placeholder="98XXXXXXXX" required/>
                </div>

                <%-- Email (read-only always) --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Email</label>
                    <p class="text-sm text-gray-800">${user.email}</p>
                </div>

                <%-- Verified --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Verified</label>
                    <c:choose>
                        <c:when test="${!user.emailVerified}">
                            <span class="text-xs bg-green-100 text-green-700 px-2.5 py-0.5 rounded-full">Verified</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-xs bg-red-100 text-red-600 px-2.5 py-0.5 rounded-full">Not verified</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

        <%-- ── Shipping Address ── --%>
        <section class="bg-white border border-gray-200 rounded-2xl p-6">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-sm font-semibold text-gray-900">Shipping address</h2>
                <div id="address-btns" data-editing="0">
                    <button onclick="toggleEdit('address')"
                            class="text-xs px-3 py-1.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-gray-700">
                        Edit
                    </button>
                </div>
            </div>

            <form id="address-form" action="${pageContext.request.contextPath}/profile"
                  method="post" class="hidden">
                <input type="hidden" name="action"   value="updateProfile"/>
                <%-- Personal fields preserved during address update --%>
                <input type="hidden" name="fullName" value="${user.fullName}"/>
                <input type="hidden" name="phone"    value="${user.phone}"/>
            </form>

            <div >

                <%-- Province --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Province</label>
                    <p class="text-sm text-gray-800" id="view-province">
                        ${not empty user.province ? user.province : '—'}
                    </p>
                    <select class="field-input hidden" id="edit-province"
                            name="province" form="address-form">
                        <option value="">— Select —</option>
                        <c:forEach var="p" items="${['Koshi','Madhesh','Bagmati','Gandaki','Lumbini','Karnali','Sudurpashchim']}">
                            <option value="${p}" ${user.province eq p ? 'selected' : ''}>${p}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- City --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">City</label>
                    <p class="text-sm text-gray-800" id="view-city">
                        ${not empty user.city ? user.city : '—'}
                    </p>
                    <input class="field-input hidden" id="edit-city"
                           type="text" name="city" value="${user.city}"
                           form="address-form" placeholder="e.g. Pokhara"/>
                </div>

                <%-- District --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">District</label>
                    <p class="text-sm text-gray-800" id="view-district">
                        ${not empty user.district ? user.district : '—'}
                    </p>
                    <input class="field-input hidden" id="edit-district"
                           type="text" name="district" value="${user.district}"
                           form="address-form" placeholder="e.g. Kaski"/>
                </div>

                <%-- Ward --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Ward no.</label>
                    <p class="text-sm text-gray-800" id="view-ward">
                        ${not empty user.ward ? user.ward : '—'}
                    </p>
                    <input class="field-input hidden" id="edit-ward"
                           type="text" name="ward" value="${user.ward}"
                           form="address-form" placeholder="15"/>
                </div>

                <%-- Street --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Street / tole</label>
                    <p class="text-sm text-gray-800" id="view-street">
                        ${not empty user.street ? user.street : '—'}
                    </p>
                    <input class="field-input hidden" id="edit-street"
                           type="text" name="street" value="${user.street}"
                           form="address-form" placeholder="Tole name"/>
                </div>

                <%-- Landmark --%>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Landmark</label>
                    <p class="text-sm text-gray-800" id="view-landmark">
                        ${not empty user.landmark ? user.landmark : '—'}
                    </p>
                    <input class="field-input hidden" id="edit-landmark"
                           type="text" name="landmark" value="${user.landmark}"
                           form="address-form" placeholder="Near hospital"/>
                </div>
            </div>
        </section>

        <%-- ── Account Info (read-only) ── --%>
        <section class="bg-white border border-gray-200 rounded-2xl p-6">
            <h2 class="text-sm font-semibold text-gray-900 mb-4">Account</h2>
            <div class="grid grid-cols-2 gap-x-8 gap-y-4">
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Role</label>
                    <span class="text-xs bg-gray-100 text-gray-600 px-2.5 py-0.5 rounded-full">
                        ${user.role eq 'ADMIN' ? 'Admin' : 'Customer'}
                    </span>
                </div>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Member since</label>
                    <p class="text-sm text-gray-800"><fmt:formatDate value="${user.createdAt}" pattern="MMM yyyy"/></p>
                </div>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Status</label>
                    <c:choose>
                        <c:when test="${user.active}">
                            <div class="flex items-center gap-1.5">
                                <span class="w-2 h-2 rounded-full bg-green-500"></span>
                                <span class="text-sm text-green-700">Active</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="text-sm text-red-500">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">Rewards</label>
                    <p class="text-sm font-semibold text-yellow-600">
                        ★ <fmt:formatNumber value="${userPoints}" pattern="#,###"/> pts
                    </p>
                </div>
            </div>
        </section>

        <%-- ── Security ── --%>
        <section class="bg-red-50 border border-orange-200 rounded-2xl p-5">
            <div class="flex items-start justify-between">
                <div class="flex-1">
                    <p class="text-sm font-semibold text-gray-800 mb-1">Security</p>
                    <button type="button" onclick="togglePassword()"
                            class="text-sm text-blue-600 hover:underline">
                        Change password →
                    </button>

                    <%-- Inline password form --%>
                    <div id="pw-section" class="mt-4 pt-4 border-t border-orange-200">

                        <c:if test="${not empty passwordError}">
                            <p class="text-xs text-red-600 bg-red-50 border border-red-200 rounded-lg px-3 py-2 mb-3">${passwordError}</p>
                        </c:if>
                        <c:if test="${not empty passwordSuccess}">
                            <p class="text-xs text-green-700 bg-green-50 border border-green-200 rounded-lg px-3 py-2 mb-3">${passwordSuccess}</p>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/profile" method="post"
                              class="flex flex-col gap-3 max-w-xs">
                            <input type="hidden" name="action" value="changePassword"/>

                            <div>
                                <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">
                                    Current password
                                </label>
                                <input class="field-input" type="password" name="currentPassword" required/>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">
                                    New password
                                </label>
                                <input class="field-input" type="password" name="newPassword" required/>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold tracking-wide uppercase text-gray-400 mb-1">
                                    Confirm password
                                </label>
                                <input class="field-input" type="password" name="confirmPassword" required/>
                            </div>

                            <div class="flex gap-2 mt-1">
                                <button type="button" onclick="togglePassword()"
                                        class="text-xs px-3 py-1.5 border border-gray-300 rounded-lg hover:bg-white transition-colors text-gray-600">
                                    Cancel
                                </button>
                                <button type="submit"
                                        class="text-xs px-3 py-1.5 bg-gray-900 text-white rounded-lg hover:bg-gray-700 transition-colors">
                                    Update
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/profile" method="post">
                    <input type="hidden" name="action" value="deleteAccount"/>
                    <button type="submit"
                            onclick="return confirm('Are you sure? This cannot be undone.')"
                            class="text-xs px-3 py-1.5 border border-red-400 text-red-500 bg-white rounded-lg hover:bg-red-50 transition-colors">
                        Delete account
                    </button>
                </form>
            </div>
        </section>

    </main>
</div>

<script>
    <%-- ── Inline edit config ── --%>
    const editFields = {
        personal: ['fullName', 'phone'],
        address:  ['province', 'city', 'district', 'ward', 'street', 'landmark']
    };

    function toggleEdit(section) {
        const fields  = editFields[section];
        const btnsDiv = document.getElementById(section + '-btns');

        fields.forEach(f => {
            document.getElementById('view-' + f).classList.add('hidden');
            document.getElementById('edit-' + f).classList.remove('hidden');
        });

        btnsDiv.innerHTML = `
            <div class="flex gap-2">
                <button type="button" onclick="cancelEdit('${section}')"
                        class="text-xs px-3 py-1.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-gray-600">
                    Cancel
                </button>
                <button type="submit" form="${section}-form"
                        class="text-xs px-3 py-1.5 bg-gray-900 text-white rounded-lg hover:bg-gray-700 transition-colors">
                    Save
                </button>
            </div>`;

        <%-- Show the hidden form so it submits --%>
        document.getElementById(section + '-form').classList.remove('hidden');
        btnsDiv.dataset.editing = '1';
    }

    function cancelEdit(section) {
        const fields  = editFields[section];
        const btnsDiv = document.getElementById(section + '-btns');

        fields.forEach(f => {
            document.getElementById('view-' + f).classList.remove('hidden');
            document.getElementById('edit-' + f).classList.add('hidden');
        });

        btnsDiv.innerHTML = `
            <button onclick="toggleEdit('${section}')"
                    class="text-xs px-3 py-1.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-gray-700">
                Edit
            </button>`;
        btnsDiv.dataset.editing = '0';
    }

    <%-- ── Password section toggle ── --%>
    function togglePassword() {
        document.getElementById('pw-section').classList.toggle('hidden');
    }

    <%-- ── JS toast helper ── --%>
    function showToast(msg) {
        const t = document.getElementById('toast');
        document.getElementById('toast-msg').textContent = msg;
        t.classList.remove('hidden');
        t.classList.add('flex');
        setTimeout(() => { t.classList.add('hidden'); t.classList.remove('flex'); }, 3000);
    }

    <%-- ── Auto-open password section if server returned error/success ── --%>
    <c:if test="${not empty passwordError or not empty passwordSuccess}">
        document.getElementById('pw-section').classList.remove('hidden');
    </c:if>

    <%-- ── Auto-dismiss server toast ── --%>
    const serverToast = document.getElementById('server-toast');
    if (serverToast) setTimeout(() => serverToast.remove(), 3000);
</script>

</body>
</html>
