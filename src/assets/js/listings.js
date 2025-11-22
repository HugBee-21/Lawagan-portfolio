const searchInput = document.getElementById('search');
const cardsContainer = document.getElementById('card-listings');
const spinnerOverlay = document.getElementById('spinner-overlay');
const noResultOverlay = document.getElementById('no-result-overlay');
const resultsLabel = document.getElementById('results-label');
const paginationContainer = document.getElementById('pagination');
const filterForm = document.querySelector('.filter-form');

let currentQuery = '';
let currentPage = 1;

searchInput.addEventListener('input', () => {
    currentQuery = searchInput.value.trim();
    currentPage = 1; // reset page when searching
    loadPage(currentPage, currentQuery);
});

filterForm.addEventListener('change', () => {
    currentQuery = searchInput.value.trim();
    currentPage = 1;
    loadPage(currentPage, currentQuery);
});

paginationContainer.addEventListener('click', (e) => {
    const link = e.target.closest('.pagination-link');
    const ellipsis = e.target.closest('.pagination-ellipsis');
    if (!link && !ellipsis) return;
    e.preventDefault();

    // TODO - Create a Modal for this
    if (ellipsis) {
        const input = prompt("Enter page number:");
        const page = parseInt(input);

        if (isNaN(page)) {
            alert("Please enter a valid number.");
            return;
        }

        if (page < 1) {
            alert("Page number cannot be less than 1.");
            return;
        }

        const totalPages = parseInt(paginationContainer.dataset.totalPages);
        console.log(totalPages);
        if (page > totalPages) {
            alert(`There are only ${totalPages} pages available.`);
            return;
        }

        loadPage(page, currentQuery);
        return;
    }

    const page = link.dataset.page;
    loadPage(page, currentQuery);
});

function loadPage(page = 1, query = '') {
    spinnerOverlay.classList.add('visible');

    // Collect filters
    const formData = new FormData(filterForm);
    const params = new URLSearchParams(formData);
    params.append('page', page);
    params.append('sq', query);

    fetch(`index.php?route=${pageListingType}/search&${params.toString()}`)
        .then(res => res.json())
        .then(data => {
            cardsContainer.classList.remove('visible');
            cardsContainer.classList.add('invisible');

            setTimeout(() => {
                cardsContainer.innerHTML = data.html;
                resultsLabel.textContent = `Show ${data.count} Results`;
                updatePagination(data.currentPage, data.totalPages);
                cardsContainer.classList.remove('invisible');
                cardsContainer.classList.add('visible');
            }, 500);

            if (data.count !== 0) {
                noResultOverlay.classList.remove('visible');
            } else {
                noResultOverlay.classList.add('visible');
            }

        })
        .catch(err => alert("Error loading data: " + err))
        .finally(() => {
            spinnerOverlay.classList.remove('visible');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
}

function updatePagination(currentPage, totalPages) {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    pagination.dataset.totalPages = totalPages;

    if (totalPages <= 1) return; // no pagination needed

    // Prev Button
    if (currentPage > 1) {
        pagination.innerHTML += `<a href="" class="pagination-link" data-page="${currentPage - 1}">Prev</a>`;
    }

    const startPage = Math.max(1, currentPage - 1);
    const endPage = Math.min(totalPages, currentPage + 1);

    if (startPage > 1) {
        pagination.innerHTML += `<a href="" class="pagination-link" data-page="1">1</a>`;
        if (startPage > 2) pagination.innerHTML += `<button class="pagination-ellipsis">...</button>`;
    }

    for (let i = startPage; i <= endPage; i++) {
        const active = i === parseInt(currentPage) ? 'active' : '';
        pagination.innerHTML += `<a href="" class="pagination-link ${active}" data-page="${i}">${i}</a>`;
    }

    if (endPage < totalPages) {
        if (endPage < totalPages - 1) pagination.innerHTML += `<button class="pagination-ellipsis">...</button>`;
        pagination.innerHTML += `<a href="" class="pagination-link" data-page="${totalPages}">${totalPages}</a>`;
    }

    // Next Button
    if (currentPage < totalPages) {
        pagination.innerHTML += `<a href="" class="pagination-link" data-page="${parseInt(currentPage) + 1}">Next</a>`;
    }
}