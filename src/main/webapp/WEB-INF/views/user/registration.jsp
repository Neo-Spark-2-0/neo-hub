<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Create Account | NEO-HUB" />
    <jsp:param name="metaDescription" value="Create your NEO-HUB account to buy and build IoT projects." />
    <jsp:param name="metaKeywords" value="NEO-HUB, registration, sign up, create account" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team" />
</jsp:include>

<body class="font-poppins bg-slate-900 min-h-screen flex items-center justify-center p-4 py-12 selection:bg-brand-500 selection:text-white relative overflow-hidden">
    
    <!-- Background glowing ambient orbs -->
    <div class="absolute -top-40 -left-40 w-96 h-96 bg-brand-500/10 rounded-full blur-3xl pointer-events-none"></div>
    <div class="absolute -bottom-40 -right-40 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl pointer-events-none"></div>

    <div class="w-full max-w-lg bg-white rounded-3xl border border-slate-100 p-8 sm:p-10 shadow-2xl relative z-10 space-y-6">
        
        <!-- Brand Header -->
        <div class="text-center space-y-2">
            <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2.5 group mb-2">
                <div class="w-10 h-10 rounded-2xl bg-slate-900 text-white flex items-center justify-center font-black text-sm tracking-widest shadow-md group-hover:scale-105 transition-transform">
                    <span class="text-brand-400">N</span>H
                </div>
                <span class="text-xl font-black tracking-tight text-slate-900">NEO<span class="text-brand-600">HUB</span></span>
            </a>
            <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">Create your account</h1>
            <p class="text-xs text-slate-500 font-medium">Join Nepal's premier electronics &amp; robotics makerspace</p>
        </div>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-4">
            
            <!-- Full Name -->
            <div class="space-y-1.5">
                <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Full Name</label>
                <div class="relative">
                    <i class="fa-solid fa-user absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                    <input type="text"
                           name="fullName"
                           placeholder="Ram Shrestha"
                           value="<c:out value='${param.fullName}'/>"
                           required
                           class="w-full pl-9 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <!-- Email -->
                <div class="space-y-1.5">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Email Address</label>
                    <div class="relative">
                        <i class="fa-solid fa-envelope absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input type="email"
                               name="email"
                               placeholder="ram@example.com"
                               value="<c:out value='${param.email}'/>"
                               required
                               class="w-full pl-9 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                    </div>
                </div>

                <!-- Phone -->
                <div class="space-y-1.5">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Phone (Nepal)</label>
                    <div class="relative">
                        <i class="fa-solid fa-phone absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input type="tel"
                               name="phone"
                               placeholder="98XXXXXXXX"
                               value="<c:out value='${param.phone}'/>"
                               required
                               class="w-full pl-9 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <!-- Password -->
                <div class="space-y-1.5">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Password</label>
                    <div class="relative">
                        <i class="fa-solid fa-lock absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input type="password"
                               name="password"
                               id="password"
                               placeholder="••••••••"
                               required
                               class="w-full pl-9 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                    </div>
                </div>

                <!-- Confirm Password -->
                <div class="space-y-1.5">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">Confirm Password</label>
                    <div class="relative">
                        <i class="fa-solid fa-shield-check absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs"></i>
                        <input type="password"
                               name="confirmPassword"
                               id="confirmPassword"
                               placeholder="••••••••"
                               required
                               class="w-full pl-9 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition" />
                    </div>
                </div>
            </div>

            <p id="matchWarning" class="text-danger text-xs font-bold flex items-center gap-1.5 hidden pt-1">
                <i class="fa-solid fa-triangle-exclamation"></i> Passwords do not match.
            </p>

            <!-- Terms notice -->
            <p class="text-[11px] text-slate-400 leading-relaxed font-medium pt-1">
                By registering, you agree to our Terms of Service and Privacy Policy.
            </p>

            <!-- Submit Button -->
            <button type="submit"
                    class="w-full bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm py-3.5 rounded-2xl transition-all shadow-md hover:shadow-lg flex items-center justify-center gap-2 active:scale-95">
                <span>Create NEO-HUB Account</span>
                <i class="fa-solid fa-arrow-right text-brand-400 text-xs"></i>
            </button>

        </form>

        <div class="pt-4 border-t border-slate-100 text-center text-xs text-slate-500 font-medium">
            Already registered?
            <a href="${pageContext.request.contextPath}/login" class="text-brand-600 hover:text-brand-700 font-bold ml-1 transition">
                Sign in here →
            </a>
        </div>

    </div>

    <script>
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const warning = document.getElementById('matchWarning');

        confirmPasswordInput.addEventListener('input', () => {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            if (confirmPassword.length > 0 && password !== confirmPassword) {
                warning.classList.remove('hidden');
            } else {
                warning.classList.add('hidden');
            }
        });

        <c:if test="${not empty error}">
            showToast("<c:out value='${error}' />", "error");
        </c:if>

        <c:if test="${not empty success}">
            showToast("<c:out value='${success}' />", "success");
        </c:if>
    </script>
</body>
</html>

