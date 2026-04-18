<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="mt-auto py-6 px-10 border-t border-secondary bg-white">
    <div class="flex flex-col md:flex-row justify-between items-center gap-4">
        <p class="text-[11px] font-bold text-gray-400 uppercase tracking-widest">
            &copy; 2026 <span class="text-accent">NEO-HUB Admin Portal</span> v1.0.4
        </p>
        <div class="flex gap-4 text-[11px] font-bold text-gray-400 uppercase">
            <span class="text-info"><i class="fa-solid fa-circle-check mr-1"></i> System Online</span>
            <span class="text-gray-300">|</span>
            <span>Support: internal@neohub.com</span>
        </div>
    </div>
</footer>

<!-- GLOBAL ADMIN SCRIPTS -->
<script>
    // Global function for Admin Delete Confirms
    function confirmAdminAction(message, formId) {
        Swal.fire({
            title: "Confirm Action",
            text: message || "Are you sure you want to proceed?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#1D1D1F", // Your accent color
            cancelButtonColor: "#EF4444", // Your danger color
            confirmButtonText: "Yes, proceed"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(formId).submit();
            }
        });
    }

    // Initialize Flowbite tooltips/dropdowns if needed
    if (typeof initFlowbite === 'function') {
        initFlowbite();
    }
</script>