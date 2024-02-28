const getMetaContent = (name) => {
    const element = document.querySelector(`meta[name="${name}"]`);
    return element ? element.getAttribute('content') : null;
};

Turbo.setConfirmMethod((message, element) => {
    return new Promise((resolve) => {
        Swal.fire({
            title: getMetaContent('i18n-confirm-title'),
            text: message,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: getMetaContent('i18n-confirm-button'),
            cancelButtonText: getMetaContent('i18n-cancel-button'),
        }).then((result) => {
            if (result.isConfirmed) {
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });
});
