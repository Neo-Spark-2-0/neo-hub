<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- ============================================================
     External Libraries
     ============================================================ --%>

<%-- Google Fonts (Poppins) --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<%-- HTMX --%>
<script defer src="https://cdn.jsdelivr.net/npm/htmx.org@2.0.10/dist/htmx.min.js"
        integrity="sha384-H5SrcfygHmAuTDZphMHqBJLc3FhssKjG7w/CeCpFReSfwBWDTKpkzPP8c+cLsK+V"
        crossorigin="anonymous"></script>

<%-- Tailwind CSS --%>
<script src="https://cdn.tailwindcss.com"></script>

<%-- Tailwind Config --%>
<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    primary: '#FFFFFF',
                    secondary: '#F5F5F7',
                    accent: '#1D1D1F',
                    dark: '#1F2937',
                    danger: '#DC2626',
                    warning: '#F59E0B',
                    info: '#3B82F6',
                    success: '#16A34A'
                },
                fontFamily: {
                    poppins: ['Poppins', 'sans-serif']
                }
            }
        }
    }
</script>

<%-- Chart.js --%>
<script defer src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<%-- Font Awesome --%>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
      integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
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
        font-family: 'Poppins', sans-serif;
        font-size: 13px;
        font-weight: 500;
        border-radius: 10px;
        padding: 12px 16px;
        box-shadow: 0 6px 18px rgba(0,0,0,.12);
        color: white !important;
        width: auto !important;
        max-width: 420px !important;
        letter-spacing: .2px;
        animation: toastSlide .25s ease;
    }

    @keyframes toastSlide {
        from{
            opacity:0;
            transform:translateX(20px);
        }
        to{
            opacity:1;
            transform:translateX(0);
        }
    }

    .toast-success{
        background:#16A34A!important;
    }

    .toast-error{
        background:#DC2626!important;
    }

    .toast-warning{
        background:#F59E0B!important;
    }

    .toast-info{
        background:#3B82F6!important;
    }

    .swal2-popup{
        border-radius:14px!important;
        font-family:'Poppins',sans-serif!important;
    }

    .swal2-confirm{
        border-radius:8px!important;
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

            confirmButtonColor: "#16A34A",

            customClass: {
                popup: "font-poppins shadow-lg border border-gray-200",
                title: "text-lg font-semibold",
                confirmButton: "rounded-lg px-6 py-2 font-medium"
            }

        });

    }

</script>