<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--    importing libraries --%>

    <%--     tailwind css--%>
    <script src="https://cdn.tailwindcss.com"></script>
    <%--    tailwind config--%>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#FFFFFF',
                        secondary: '#F5F5F7',
                        accent: '#1D1D1F',
                        dark: '#1F2937',
                        danger:    '#EF4444',
                        warning:   '#F59E0B',
                        info:      '#3B82F6',
                        success:   '#22C55E', 
                    },
                    fontFamily: {
                        poppins: ['Poppins', 'sans-serif']
                    }
                }
            }
        }
    </script>



    <%--    font awesome--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />


    <%--    Flow byte--%>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>


    <%--    sweet alert --%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <%--toastify css and js --%>
    <%--  CSS --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.js"></script>


    <%--    main css --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>


    
    <style>
        .toastify {
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 500;
            border-radius: 8px;
            padding: 12px 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
            color: #fff !important;
            max-width: none !important;
            width: auto !important;
        }
        .toast-success { background: #22C55E !important; }
        .toast-error   { background: #EF4444 !important; }
        .toast-warning { background: #F59E0B !important; }
        .toast-info    { background: #3B82F6 !important; }

    </style>

    <script>
        function showToast(message, type = "success") {
            Toastify({
                text:        message,
                duration:    4000,
                gravity:     "top",
                position:    "right",
                close:       true,
                stopOnFocus: true,
                className:   "toast-" + type,
                style: { background: "" }
            }).showToast();
        }

        function showAlert(message, type = "success") {
            Swal.fire({
                icon:               type,
                title:              { success: "Success", error: "Error", warning: "Warning", info: "Info" }[type] || "Notice",
                text:               message,
                confirmButtonText:  "OK",
                confirmButtonColor: "#22C55E",
                customClass: {
                    popup:         "font-poppins rounded-xl border border-gray-200 shadow-sm",
                    title:         "text-base font-semibold",
                    confirmButton: "text-sm font-medium rounded-lg px-5 py-2"
                }
            });
        }
    </script>