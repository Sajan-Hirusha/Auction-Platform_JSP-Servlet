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
                event.preventDefault();
                form.classList.add('was-validated');
                form.submit();
            }
        }, false);
    });
})();

//document.addEventListener('DOMContentLoaded', function() {
//    const showPopupButton = document.getElementById('showPopupButton');
//    const hidePopupButton = document.getElementById('hidePopupButton');
//    const row1 = document.getElementById('row1');
//
//    showPopupButton.addEventListener('click', function() {
//        row1.classList.add('visible');
//        hidePopupButton.style.display = 'block';
//    });
//
//    hidePopupButton.addEventListener('click', function() {
//        row1.classList.remove('visible');
//        showPopupButton.style.display = 'block';
//        hidePopupButton.style.display = 'none';
//    });
//
//    // Close popup when clicking outside of it
//    document.addEventListener('click', function(event) {
//        if (!row1.contains(event.target) && event.target !== showPopupButton) {
//            row1.classList.remove('visible');
//            showPopupButton.style.display = 'block';
//            hidePopupButton.style.display = 'none';
//        }
//    });
//});