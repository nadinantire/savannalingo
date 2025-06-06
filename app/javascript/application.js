// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./posts"
import "trix"
import "@rails/actiontext"

document.addEventListener('turbo:load', () => {
  const container = document.getElementById('content-blocks');
  const addBtn = document.querySelector('.add-content-block');

  if (!container || !addBtn) return;

  addBtn.addEventListener('click', () => {
    const time = new Date().getTime();
    const regexp = new RegExp('new_post_content_blocks', 'g');

    // Get template HTML from the hidden div
    const template = document.getElementById('post_content_block_template').innerHTML;

    // Replace the placeholder with unique timestamp
    const newFields = template.replace(regexp, time);

    // Append the new content block fields
    container.insertAdjacentHTML('beforeend', newFields);
  });

  // Remove content block on clicking remove link
  container.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-content-block')) {
      e.target.closest('.content-block').remove();
    }
  });
});

