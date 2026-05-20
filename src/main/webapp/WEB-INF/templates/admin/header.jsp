<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="bg-primary border-b border-secondary sticky top-0 z-30 h-16 flex items-center justify-between px-8">
    <div>
        <h1 class="text-sm font-bold text-accent uppercase tracking-widest">
            <span class="text-gray-400 font-normal">Admin /</span> ${param.activePage}
        </h1>
    </div>

    <div class="flex items-center gap-4">
        <div class="hidden md:block text-right">
            <p class="text-sm font-bold text-accent leading-none">${sessionScope.user.fullName}</p>
            <p class="text-[10px] font-bold text-info uppercase mt-1">System Admin</p>
        </div>

        <div class="relative group">
            <div class="w-10 h-10 rounded-full border-2 border-secondary overflow-hidden bg-secondary shadow-sm">
                <c:if test="${not empty sessionScope.user.profileImage}">
                    <div class="w-full h-full flex items-center justify-center font-bold text-accent">AD</div>
                </c:if>
            </div>
        </div>
    </div>
</header>