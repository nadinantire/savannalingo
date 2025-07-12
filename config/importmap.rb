# config/importmap.rb
Rails.application.config.importmap.cdn_template = "https://cdn.jsdelivr.net/npm/%{package}@%{version}/%{path}"

pin "application"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
