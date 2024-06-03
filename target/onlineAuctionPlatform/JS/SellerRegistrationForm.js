(() => {
    'use strict';

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    const forms = document.querySelectorAll('.needs-validation');

    // Loop over them and prevent submission
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                form.classList.add('was-validated');
            } else {
                event.preventDefault(); // Prevent the default form submission
                form.classList.add('was-validated');
                // Perform any additional synchronous operations here
                form.submit(); // Submit the form programmatically
            }
        }, false);
    });
})();