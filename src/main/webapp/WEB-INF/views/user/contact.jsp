<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="Contact Us | NEO-HUB Support" />
    <jsp:param name="metaDescription" value="Get in touch with NEO-HUB and the NEO-SPARK team for component inquiries, bulk orders, and project support." />
    <jsp:param name="metaKeywords" value="contact NEO-HUB, IoT support Nepal, customer care" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="contact" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-12">
        
        <!-- Hero Header -->
        <section class="bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950 rounded-3xl p-8 sm:p-14 text-white border border-slate-800 shadow-2xl relative overflow-hidden">
            <div class="absolute -right-20 -top-20 w-80 h-80 bg-brand-500/15 rounded-full blur-3xl pointer-events-none"></div>
            <div class="relative z-10 max-w-2xl space-y-4">
                <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/10 backdrop-blur-md text-brand-300 text-xs font-bold border border-white/10">
                    <span class="w-2 h-2 rounded-full bg-brand-400 animate-pulse"></span>
                    <span>24/7 Maker Support</span>
                </div>
                <h1 class="text-3xl sm:text-5xl font-black tracking-tight leading-tight">
                    Let's Talk Hardware.<br/>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-400 to-indigo-300">We're here to power your builds.</span>
                </h1>
                <p class="text-xs sm:text-sm text-slate-400 font-medium leading-relaxed">
                    Have questions about component compatibility, bulk institutional procurement, or need assistance with your order? Reach out directly.
                </p>
            </div>
        </section>

        <!-- Content Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- Left 4 Columns: Direct Contact Pillars -->
            <div class="lg:col-span-4 flex flex-col gap-4">
                
                <!-- Location Card -->
                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start hover:border-slate-300 transition">
                    <div class="w-12 h-12 rounded-2xl bg-blue-50 text-blue-600 border border-blue-100 flex items-center justify-center flex-shrink-0 text-xl">
                        <i class="fa-solid fa-location-dot"></i>
                    </div>
                    <div class="space-y-1 text-xs">
                        <span class="font-extrabold uppercase tracking-wider text-slate-400 text-[10px] block">Hardware Lab</span>
                        <h3 class="font-extrabold text-slate-900 text-sm">NEO-HUB Headquarters</h3>
                        <p class="text-slate-500 font-medium leading-relaxed">Gandaki Province, Pokhara, Nepal</p>
                    </div>
                </div>

                <!-- Phone Card -->
                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start hover:border-slate-300 transition">
                    <div class="w-12 h-12 rounded-2xl bg-emerald-50 text-emerald-600 border border-emerald-100 flex items-center justify-center flex-shrink-0 text-xl">
                        <i class="fa-solid fa-phone"></i>
                    </div>
                    <div class="space-y-1 text-xs">
                        <span class="font-extrabold uppercase tracking-wider text-slate-400 text-[10px] block">Customer Hotline</span>
                        <h3 class="font-extrabold text-slate-900 text-sm">+977 981-2345678</h3>
                        <p class="text-slate-500 font-medium">Sunday &ndash; Friday &bull; 9:00 AM &ndash; 6:00 PM</p>
                    </div>
                </div>

                <!-- Email Card -->
                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start hover:border-slate-300 transition">
                    <div class="w-12 h-12 rounded-2xl bg-purple-50 text-purple-600 border border-purple-100 flex items-center justify-center flex-shrink-0 text-xl">
                        <i class="fa-solid fa-envelope"></i>
                    </div>
                    <div class="space-y-1 text-xs">
                        <span class="font-extrabold uppercase tracking-wider text-slate-400 text-[10px] block">Official Inquiries</span>
                        <h3 class="font-extrabold text-slate-900 text-sm">neohubnepal@gmail.com</h3>
                        <p class="text-slate-500 font-medium">Responses within 24 business hours</p>
                    </div>
                </div>

                <!-- Hours Card -->
                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start hover:border-slate-300 transition">
                    <div class="w-12 h-12 rounded-2xl bg-amber-50 text-amber-600 border border-amber-100 flex items-center justify-center flex-shrink-0 text-xl">
                        <i class="fa-solid fa-clock"></i>
                    </div>
                    <div class="space-y-1 text-xs">
                        <span class="font-extrabold uppercase tracking-wider text-slate-400 text-[10px] block">Dispatch Hours</span>
                        <h3 class="font-extrabold text-slate-900 text-sm">Same-Day Dispatch</h3>
                        <p class="text-slate-500 font-medium">Orders placed before 2:00 PM NPT</p>
                    </div>
                </div>

            </div>

            <!-- Right 8 Columns: Contact Form / Authenticated State -->
            <div class="lg:col-span-8 bg-white border border-slate-200/80 rounded-3xl p-7 sm:p-10 shadow-card space-y-6">
                
                <div class="space-y-1 border-b border-slate-100 pb-5">
                    <h2 class="text-xl font-extrabold text-slate-900">Send an Inquiry Message</h2>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <p class="text-xs text-slate-500 font-medium">
                                Submitting as <span class="font-bold text-slate-900"><c:out value="${sessionScope.user.fullName}" /></span> (<c:out value="${sessionScope.user.email}" />)
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-xs text-slate-500 font-medium">
                                Sign in to link messages directly to your customer account profile.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/contact" method="post" class="space-y-5">
                            
                            <!-- Sender Read-only Info -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Your Full Name</label>
                                    <input type="text" disabled value="<c:out value='${sessionScope.user.fullName}'/>"
                                           class="w-full px-4 py-3 bg-slate-100 border border-slate-200 rounded-2xl text-xs font-bold text-slate-700 cursor-not-allowed"/>
                                </div>
                                <div class="space-y-1.5">
                                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-400">Email Address</label>
                                    <input type="text" disabled value="<c:out value='${sessionScope.user.email}'/>"
                                           class="w-full px-4 py-3 bg-slate-100 border border-slate-200 rounded-2xl text-xs font-bold text-slate-700 cursor-not-allowed"/>
                                </div>
                            </div>

                            <!-- Subject Input -->
                            <div class="space-y-1.5">
                                <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">
                                    Inquiry Subject <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="subject" maxlength="200" required
                                       placeholder="e.g. Inquiring about ESP32-CAM bulk availability for university lab"
                                       value="<c:out value='${param.subject}'/>"
                                       class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-bold text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 transition"/>
                            </div>

                            <!-- Message Textarea -->
                            <div class="space-y-1.5">
                                <label class="block text-xs font-bold uppercase tracking-wider text-slate-600">
                                    Message Details <span class="text-danger">*</span>
                                </label>
                                <textarea name="message" rows="6" required
                                          placeholder="Type your message, project specifications, or questions here..."
                                          class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-medium text-slate-900 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 transition resize-none"><c:out value='${param.message}'/></textarea>
                            </div>

                            <div class="flex items-center justify-end pt-2">
                                <button type="submit"
                                        class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm px-8 py-3.5 rounded-2xl transition shadow-md active:scale-95">
                                    <i class="fa-solid fa-paper-plane text-brand-400 text-xs"></i>
                                    <span>Dispatch Message</span>
                                </button>
                            </div>

                        </form>
                    </c:when>

                    <c:otherwise>
                        <div class="py-12 flex flex-col items-center justify-center text-center space-y-4 max-w-sm mx-auto">
                            <div class="w-16 h-16 rounded-3xl bg-slate-100 text-slate-400 flex items-center justify-center text-2xl">
                                <i class="fa-solid fa-lock"></i>
                            </div>
                            <div class="space-y-1">
                                <h3 class="text-base font-extrabold text-slate-900">Sign In to Send Messages</h3>
                                <p class="text-xs text-slate-500 font-medium">
                                    Please sign in to your NEO-HUB account so our support engineers can track your inquiry ticket.
                                </p>
                            </div>
                            <a href="${pageContext.request.contextPath}/login"
                               class="inline-flex items-center gap-2 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs px-6 py-3 rounded-2xl transition shadow-md">
                                <i class="fa-solid fa-arrow-right-to-bracket text-brand-400 text-xs"></i>
                                <span>Sign In Now</span>
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

        </div>

    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />

    <script>
        <c:if test="${not empty contactError}">
            showToast("<c:out value='${contactError}'/>", "error");
        </c:if>

        <c:if test="${not empty sessionScope.contactSuccess}">
            showToast("<c:out value='${sessionScope.contactSuccess}'/>", "success");
            <c:remove var="contactSuccess" scope="session" />
        </c:if>
    </script>
</body>
</html>

