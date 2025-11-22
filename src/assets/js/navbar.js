const createListingButton = document.getElementById('create-listing-triggr');

createListingButton.addEventListener('click', () => {
    createListingForm.classList.add('visible');
    document.body.style.overflow = 'hidden';
    window.scrollTo({ top: 0, behavior: 'smooth' });
});