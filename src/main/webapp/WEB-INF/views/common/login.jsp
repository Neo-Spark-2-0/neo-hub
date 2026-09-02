<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Sign In | NEO-HUB" />
    <jsp:param name="metaDescription" value="Login to your NEO-HUB account." />
    <jsp:param name="metaKeywords" value="NEO-HUB, Login, User Authentication" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-900 min-h-screen flex items-center justify-center p-4 selection:bg-brand-500 selection:text-white relative overflow-hidden">
    
    <!-- Background glowing ambient orbs -->
    <div class="absolute -top-40 -left-40 w-96 h-96 bg-brand-500/10 rounded-full blur-3xl pointer-events-none"></div>
    <div class="absolute -bottom-40 -right-40 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl pointer-events-none"></div>

    <div class="w-full max-w-md bg-white rounded-3xl border border-slate-100 p-8 sm:p-10 shadow-2xl relative z-10 space-y-6">
        
        <!-- Brand Header -->
        <div class="text-center space-y-2">
            <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2.5 group mb-2">
                <div class="w-10 h-10 rounded-2xl bg-slate-900 text-white flex items-center justify-center font-black text-sm tracking-widest shadow-md group-hover:scale-105 transition-transform">
                    <span class="text-brand-400">N</span>H
                </div>
                <span class="text-xl font-black tracking-tight text-slate-900">NEO<span class="text-brand-600">HUB</span></span>
            </a>
            <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">Welcome back</h1>
            <p class="text-xs text-slate-500 font-medium">Sign in with your email to access your account</p>
        </div>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-4">
            
            <!-- Email -->
            <div class="space-y-1.5">
                <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Email Address</label>
                <div class="relative">
                    <i class="fa-solid fa-envelope absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                    <input type="email"
                           name="email"
                           placeholder="name@example.com"
                           value="<c:out value='${param.email}'/>"
                           required
                           class="w-full pl-9 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                </div>
            </div>

            <!-- Password -->
            <div class="space-y-1.5">
                <div class="flex items-center justify-between">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Password</label>
                </div>
                <div class="relative">
                    <i class="fa-solid fa-lock absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                    <input type="password"
                           name="password"
                           id="password"
                           placeholder="••••••••"
                           required
                           class="w-full pl-9 pr-10 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                    <button type="button" onclick="togglePasswordVisibility()" class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 transition text-xs">
                        <i id="eyeIcon" class="fa-solid fa-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit"
                    class="w-full bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm py-3.5 rounded-2xl transition-all shadow-md hover:shadow-lg flex items-center justify-center gap-2 active:scale-95 pt-3">
                <span>Sign In to Account</span>
                <i class="fa-solid fa-arrow-right text-brand-400 text-xs"></i>
            </button>

        </form>

        <div class="pt-4 border-t border-slate-100 text-center text-xs text-slate-500 font-medium">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register" class="text-brand-600 hover:text-brand-700 font-bold ml-1 transition">
                Create one now →
            </a>
        </div>

    </div>

    <script>
        function togglePasswordVisibility() {
            const pwd = document.getElementById('password');
            const icon = document.getElementById('eyeIcon');
            if (pwd.type === 'password') {
                pwd.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                pwd.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }

        <c:if test="${not empty error}">
            showToast("<c:out value='${error}' />", "error");
        </c:if>

        <c:if test="${not empty sessionScope.registerSuccessFlashMessage}">
            showToast("${sessionScope.registerSuccessFlashMessage}", "success");
            <%
                session.removeAttribute("registerSuccessFlashMessage");
            %>
        </c:if>
    </script>
</body>
</html>

