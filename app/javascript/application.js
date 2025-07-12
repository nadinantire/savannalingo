import "@hotwired/turbo-rails"
import "./controllers"
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

    const template = document.getElementById('post_content_block_template').innerHTML;
    const newFields = template.replace(regexp, time);

    container.insertAdjacentHTML('beforeend', newFields);
  });

  container.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-content-block')) {
      e.target.closest('.content-block').remove();
    }
  });
});
