# Pin npm packages by running ./bin/importmap
Rails.application.config.importmap.cdn_template = "https://cdn.jsdelivr.net/npm/%{package}@%{version}/%{path}"
pin "application"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix" # @2.1.15
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"

