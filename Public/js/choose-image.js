function chooseImage() {
    document.getElementById('imageDelete').value = false;
    document.getElementById('image').click(); }
    function removeImage() { document.getElementById('image').value = null; document.getElementById('imageDelete').value = true; const element = document.getElementById('uploaded-image'); if (element !== null) {
    element.parentNode.removeChild(element); }
    }
    document.getElementById('image') .onchange = function(event) {
    const file = event.target.files[0];
    const blobURL = URL.createObjectURL(file);
    let element = document.getElementById('uploaded-image'); if (element === null) {
    var newElement = document.createElement("img"); newElement.id = 'uploaded-image';
    const sibling = document.getElementById('choose-button'); sibling.parentNode.insertBefore(newElement, sibling); element = newElement;
    }
    element.src = blobURL; }