<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- ============================================================
     External Libraries & Core Assets
     ============================================================ --%>

<%-- Google Fonts (Plus Jakarta Sans & Poppins) --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<%-- HTMX --%>
<script defer src="https://cdn.jsdelivr.net/npm/htmx.org@2.0.10/dist/htmx.min.js"
        integrity="sha384-H5SrcfygHmAuTDZphMHqBJLc3FhssKjG7w/CeCpFReSfwBWDTKpkzPP8c+cLsK+V"
        crossorigin="anonymous"></script>

<%-- Tailwind CSS CDN --%>
<script src="https://cdn.tailwindcss.com"></script>

<%-- Tailwind Config --%>
<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    primary: '#FFFFFF',
                    secondary: '#F8FAFC',
                    accent: '#0F172A',
                    brand: {
                        50: '#F0FDF4',
                        100: '#DCFCE7',
                        200: '#BBF7D0',
                        500: '#10B981',
                        600: '#059669',
                        700: '#047857'
                    },
                    dark: '#0F172A',
                    danger: '#EF4444',
                    warning: '#F59E0B',
                    info: '#3B82F6',
                    success: '#10B981'
                },
                fontFamily: {
                    poppins: ['"Plus Jakarta Sans"', 'Poppins', 'sans-serif'],
                    sans: ['"Plus Jakarta Sans"', 'Poppins', 'sans-serif']
                },
                boxShadow: {
                    'subtle': '0 1px 3px 0 rgba(0, 0, 0, 0.04), 0 1px 2px -1px rgba(0, 0, 0, 0.04)',
                    'card': '0 4px 20px -2px rgba(15, 23, 42, 0.06)',
                    'card-hover': '0 12px 30px -4px rgba(15, 23, 42, 0.12)',
                    'glow': '0 0 25px -5px rgba(16, 185, 129, 0.3)'
                }
            }
        }
    }
</script>

<%-- Chart.js --%>
<script defer src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<%-- Font Awesome 6 --%>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
      crossorigin="anonymous"
      referrerpolicy="no-referrer"/>

<%-- Flowbite --%>
<link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet"/>
<script defer src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>

<%-- SweetAlert2 --%>
<script defer src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%-- Toastify --%>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.css"/>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.js"></script>

<%-- Main CSS --%>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/static/css/main.css"/>

<style>
    .toastify {
        font-family: 'Plus Jakarta Sans', 'Poppins', sans-serif;
        font-size: 13.5px;
        font-weight: 600;
        border-radius: 12px;
        padding: 12px 18px;
        box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.15), 0 8px 10px -6px rgba(15, 23, 42, 0.1);
        color: white !important;
        width: auto !important;
        max-width: 440px !important;
        letter-spacing: -0.01em;
        backdrop-filter: blur(8px);
        animation: toastSlide .28s cubic-bezier(0.16, 1, 0.3, 1);
    }

    @keyframes toastSlide {
        from {
            opacity: 0;
            transform: translateY(-12px) scale(0.96);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }

    .toast-success {
        background: linear-gradient(135deg, #10B981, #059669) !important;
    }

    .toast-error {
        background: linear-gradient(135deg, #EF4444, #DC2626) !important;
    }

    .toast-warning {
        background: linear-gradient(135deg, #F59E0B, #D97706) !important;
    }

    .toast-info {
        background: linear-gradient(135deg, #3B82F6, #2563EB) !important;
    }

    .swal2-popup {
        border-radius: 20px !important;
        font-family: 'Plus Jakarta Sans', 'Poppins', sans-serif !important;
        padding: 1.75rem !important;
    }

    .swal2-title {
        font-weight: 700 !important;
        letter-spacing: -0.02em !important;
    }

    .swal2-confirm {
        border-radius: 10px !important;
        font-weight: 600 !important;
        padding: 0.6rem 1.5rem !important;
    }

    .swal2-cancel {
        border-radius: 10px !important;
        font-weight: 600 !important;
        padding: 0.6rem 1.5rem !important;
    }
</style>

<script>
    function showToast(message, type = "success") {
        Toastify({
            text: message,
            duration: 4000,
            gravity: "top",
            position: "right",
            close: true,
            stopOnFocus: true,
            className: "toast-" + type,
            style: {
                background: ""
            }
        }).showToast();
    }

    function showAlert(message, type = "success") {
        Swal.fire({
            icon: type,
            title: {
                success: "Success",
                error: "Error",
                warning: "Warning",
                info: "Information"
            }[type] || "Notice",
            text: message,
            confirmButtonText: "OK",
            confirmButtonColor: "#0F172A",
            customClass: {
                popup: "font-poppins shadow-2xl border border-slate-100",
                title: "text-lg font-bold text-slate-900",
                confirmButton: "rounded-xl px-6 py-2.5 font-semibold text-sm shadow-sm"
            }
        });
    }
</script>