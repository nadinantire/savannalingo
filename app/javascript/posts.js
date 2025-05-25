document.addEventListener('turbo:load', () => {
  const container = document.getElementById('content-blocks');
  const addBtn = document.querySelector('.add-content-block');

  if (!container || !addBtn) return;

  addBtn.addEventListener('click', () => {
    // Get current number of content blocks
    const time = new Date().getTime();
    const regexp = new RegExp('new_post_content_blocks', 'g');

    // Get the template from a hidden div or from the last content block rendered in the form
    const template = document.getElementById('post_content_block_template').innerHTML;

    // Replace placeholder IDs with unique timestamp
    const newFields = template.replace(regexp, time);

    // Append new content block fields to container
    container.insertAdjacentHTML('beforeend', newFields);
  });

  // Optional: Add event listener to remove content block links
  container.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-content-block')) {
      e.target.closest('.content-block').remove();
    }
  });
});
