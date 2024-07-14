 document.addEventListener('DOMContentLoaded', function() {
                if (typeof serverMessage !== 'undefined' && serverMessage !== "") {
                    showAlert(serverMessage);
                }

                const forms = document.querySelectorAll('.needs-validation');
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
            });

            function showAlert(message) {
                const alertContainer = document.getElementById('alertContainer1');
                alertContainer.textContent = message;
                alertContainer.style.display = 'block';

                setTimeout(function() {
                    alertContainer.style.animation = 'slideOutRight 0.5s ease-out forwards';
                    setTimeout(function() {
                        alertContainer.style.display = 'none';
                        alertContainer.style.animation = 'slideInRight 0.5s ease-out forwards';
                    }, 500);
                }, 5000);
            }

