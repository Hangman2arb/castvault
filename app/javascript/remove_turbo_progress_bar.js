document.addEventListener('turbo:load', () => {
    const originalShow = Turbo.navigator.adapter.progressBar.show;
    const originalHide = Turbo.navigator.adapter.progressBar.hide;

    Turbo.navigator.adapter.progressBar.show = function() {
        document.getElementById('loader-overlay').classList.remove('hidden');
    };

    Turbo.navigator.adapter.progressBar.hide = function() {
        document.getElementById('loader-overlay').classList.add('hidden');
    };
});
