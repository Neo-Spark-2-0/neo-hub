<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<header class="bg-white/80 backdrop-blur-xl border-b border-slate-200/80 sticky top-0 z-30 h-16 flex items-center justify-between px-6 sm:px-10">
    <div class="flex items-center gap-3">
        <h1 class="text-xs font-extrabold text-slate-900 uppercase tracking-wider flex items-center gap-2">
            <span class="text-slate-400 font-semibold">Admin Console /</span>
            <span>${param.activePage}</span>
        </h1>
    </div>

    <div class="flex items-center gap-4">
        <a href="${pageContext.request.contextPath}/" target="_blank"
           class="hidden sm:inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold transition">
            <i class="fa-solid fa-arrow-up-right-from-square text-[10px]"></i>
            <span>Live Site</span>
        </a>

        <div class="flex items-center gap-3 pl-3 border-l border-slate-200">
            <div class="hidden md:block text-right">
                <p class="text-xs font-extrabold text-slate-900 leading-tight">${sessionScope.user.fullName}</p>
                <p class="text-[10px] font-bold text-brand-600 uppercase tracking-wider">Super Administrator</p>
            </div>

            <div class="w-9 h-9 rounded-xl bg-slate-900 text-white flex items-center justify-center font-bold text-xs shadow-sm">
                <c:choose>
                    <c:when test="${not empty sessionScope.user.profileImage}">
                        <img src="${pageContext.request.contextPath}/uploads/${sessionScope.user.profileImage}" class="w-full h-full object-cover rounded-xl"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="parts" value="${fn:split(sessionScope.user.fullName, ' ')}" />
                        ${fn:substring(parts[0], 0, 1)}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>