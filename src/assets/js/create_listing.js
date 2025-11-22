// Image preview
const input = document.getElementById('images');
const preview = document.getElementById('preview-container');
const cancelButton = document.querySelector('.cancel-btn');
const createListingForm = document.querySelector('#create-listing');

let allFiles = [];
let listingType = 'auction';

input.addEventListener('change', () => {
    allFiles = [...allFiles, ...Array.from(input.files)];
    renderPreview();
    input.value = '';
});

const uploadBox = document.querySelector('.upload-box');

function renderPreview() {
    preview.innerHTML = '';

    const newHeight = Math.min(allFiles.length * 100, 300);

    if (allFiles.length > 0) {
        preview.classList.add('expand');
        preview.style.minHeight = `${newHeight}px`;
    } else {
        preview.classList.remove('expand');
        preview.style.minHeight = '0px';
    }

    allFiles.forEach((file, index) => {
        const item = document.createElement('div');
        item.className = 'preview-item';

        const info = document.createElement('div');
        info.className = 'preview-info';

        const thumb = document.createElement('img');
        thumb.src = file.type.startsWith('video/')
            ? 'https://cdn-icons-png.flaticon.com/512/833/833524.png'
            : URL.createObjectURL(file);

        const details = document.createElement('div');
        details.className = 'preview-details';
        const name = document.createElement('span');
        name.className = 'preview-name';
        name.textContent = file.name;
        const size = document.createElement('span');
        size.className = 'preview-size';
        size.textContent = `${(file.size / 1024 / 1024).toFixed(1)} MB`;

        details.appendChild(name);
        details.appendChild(size);
        info.appendChild(thumb);
        info.appendChild(details);

        const del = document.createElement('span');
        del.className = 'delete-btn';
        del.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="15" viewBox="0 0 14 15" fill="none" aria-hidden="true" focusable="false">
            <path d="M11.75 5.87866L10.6786 14.4501H3.17861L2.10718 5.87866" stroke="#DD4649" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M0.5 3.7356H13.3571" stroke="#DD4649" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M4.20703 3.425V1.57143C4.20703 1.28727 4.31991 1.01475 4.52085 0.813814C4.72178 0.612882 4.9943 0.5 5.27846 0.5H8.49275C8.77691 0.5 9.04943 0.612882 9.25036 0.813814C9.45129 1.01475 9.56417 1.28727 9.56417 1.57143V3.71429" stroke="#DD4649" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        `;
        del.setAttribute('role', 'button');
        del.setAttribute('tabindex', '0');
        del.setAttribute('aria-label', 'Remove image');
        del.style.cursor = 'pointer';
        del.addEventListener('click', () => {
            allFiles.splice(index, 1);
            renderPreview();
        });

        item.appendChild(info);
        item.appendChild(del);
        preview.appendChild(item);
    });
}

// Handle form submit
createListingForm.addEventListener('submit', async (e) => {
    e.preventDefault(); 
    const formData = new FormData(createListingForm);
    allFiles.forEach(file => {
        formData.append('images[]', file);
    });

    formData.append('type', listingType);

    try {
        const response = await fetch('index.php?route=upload', {
            method: 'POST',
            body: formData
        });

        const result = await response.json();

        console.log(response);

        if (result.success) {
            alert('Listing created successfully!');
            createListingForm.reset();
            preview.innerHTML = '';
            allFiles = [];
        } else {
            alert('Upload failed: ' + result.message);
        }
    } catch (error) {
        console.error('Error uploading:', error);
        alert('Something went wrong.');
    }
});

// Cancel Button
cancelButton.addEventListener('click', () => {
    createListingForm.classList.remove('visible');
    document.body.style.overflow = '';
});

// Toggle Auction/Swap
document.querySelectorAll('.toggle-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.toggle-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        listingType = btn.dataset.type;
        const auctionElements = document.querySelectorAll('.create-auction-element');
        const swapElements = document.querySelectorAll('.create-swap-element');
        
        if (listingType === 'swap') {
            auctionElements.forEach(el => {
                el.classList.add('remove');
                el.disabled = true;
            });

            swapElements.forEach(el => {
                el.classList.remove('remove');
                el.disabled = false;
            });
        } else {
            auctionElements.forEach(el => {
                el.classList.remove('remove');
                el.disabled = false;
            });

            swapElements.forEach(el => {
                el.classList.add('remove');
                el.disabled = true;
            });
        }
    });
});