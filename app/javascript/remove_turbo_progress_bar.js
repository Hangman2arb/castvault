document.addEventListener('turbo:load', () => {
    const originalShow = Turbo.navigator.adapter.progressBar.show;
    const originalHide = Turbo.navigator.adapter.progressBar.hide;

    Turbo.navigator.adapter.progressBar.show = function() {
        let loaderOverlay = document.getElementById('loader-overlay');
        if (loaderOverlay) {
            loaderOverlay.classList.remove('hidden');
        }
    };

    Turbo.navigator.adapter.progressBar.hide = function() {
        let loaderOverlay = document.getElementById('loader-overlay');
        if (loaderOverlay) {
            loaderOverlay.classList.add('hidden');
        }
    };

    document.addEventListener('turbo:before-visit', () => {
        let loaderOverlay = document.getElementById('loader-overlay');
        if (loaderOverlay) {
            loaderOverlay.classList.remove('hidden');
        }
    });

    document.addEventListener('turbo:render', () => {
        let loaderOverlay = document.getElementById('loader-overlay');
        if (loaderOverlay) {
            loaderOverlay.classList.add('hidden');
        }
    });
});
