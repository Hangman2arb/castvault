document.addEventListener('turbo:visit-start', () => {
    document.getElementById('loader-overlay').classList.remove('hidden');
});

document.addEventListener('turbo:visit-end', () => {
    document.getElementById('loader-overlay').classList.add('hidden');
});
