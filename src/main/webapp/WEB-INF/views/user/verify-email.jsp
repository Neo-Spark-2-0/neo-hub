<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Email Verification | NEO-HUB" />
    <jsp:param name="metaDescription" value="NEO-HUB Email Verification Status" />
</jsp:include>

<body class="font-poppins bg-slate-900 min-h-screen flex items-center justify-center p-4 selection:bg-brand-500 selection:text-white relative overflow-hidden">
    
    <div class="absolute -top-40 -left-40 w-96 h-96 bg-brand-500/10 rounded-full blur-3xl pointer-events-none"></div>
    <div class="absolute -bottom-40 -right-40 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl pointer-events-none"></div>

    <div class="w-full max-w-md bg-white rounded-3xl border border-slate-100 p-8 sm:p-10 shadow-2xl relative z-10 text-center space-y-6">
        
        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2.5 group mb-2">
            <div class="w-10 h-10 rounded-2xl bg-slate-900 text-white flex items-center justify-center font-black text-sm tracking-widest shadow-md group-hover:scale-105 transition-transform">
                <span class="text-brand-400">N</span>H
            </div>
            <span class="text-xl font-black tracking-tight text-slate-900">NEO<span class="text-brand-600">HUB</span></span>
        </a>

        <c:choose>
            <c:when test="${verifyStatus eq 'success'}">
                <div class="w-16 h-16 rounded-3xl bg-brand-50 text-brand-600 border border-brand-200 flex items-center justify-center mx-auto text-2xl shadow-subtle">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div class="space-y-1.5">
                    <h1 class="text-xl font-extrabold text-slate-900">Email Verified Successfully!</h1>
                    <p class="text-xs text-slate-500 font-medium">${message}</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/login"
                       class="w-full inline-flex items-center justify-center gap-2 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm py-3.5 rounded-2xl transition shadow-md">
                        <span>Proceed to Sign In</span>
                        <i class="fa-solid fa-arrow-right text-brand-400 text-xs"></i>
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="w-16 h-16 rounded-3xl bg-red-50 text-danger border border-red-200 flex items-center justify-center mx-auto text-2xl shadow-subtle">
                    <i class="fa-solid fa-circle-xmark"></i>
                </div>
                <div class="space-y-1.5">
                    <h1 class="text-xl font-extrabold text-slate-900">Verification Link Expired</h1>
                    <p class="text-xs text-slate-500 font-medium">${message}</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/register"
                       class="w-full inline-flex items-center justify-center gap-2 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm py-3.5 rounded-2xl transition shadow-md">
                        <i class="fa-solid fa-arrow-left text-brand-400 text-xs"></i>
                        <span>Return to Registration</span>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="pt-4 border-t border-slate-100 text-xs text-slate-500 font-medium">
            Need help?
            <a href="${pageContext.request.contextPath}/contact" class="text-brand-600 hover:text-brand-700 font-bold ml-1 transition">
                Contact Support →
            </a>
        </div>

    </div>

</body>
</html>

