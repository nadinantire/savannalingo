RailsAdmin.config do |config|
  # Use importmap or sprockets depending on setup
  config.asset_source = :sprockets

  # Customize admin panel name
  config.main_app_name = ["SavannaLingo", "Admin"]

  # Add logout link in navigation
  config.navigation_static_links = {
    'Logout' => '/users/sign_out'
  }

  config.navigation_static_label = "Account"

  # Exclude system models
  config.excluded_models << 'ActiveStorage::Attachment'
  config.excluded_models << 'ActiveStorage::Blob'
  config.excluded_models << 'ActiveStorage::VariantRecord'
  config.excluded_models << 'ActionText::RichText'
  config.excluded_models << 'ActionText::EncryptedRichText'

  ### == Devise authentication ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ### == Authorization (admin-only access) ==
  config.authorize_with do |controller|
    unless controller.current_user&.user_role == 'admin'
      controller.redirect_to controller.main_app.root_path, alert: 'Access denied. Admin privileges required.'
    end
  end

  ### == Hide associations from all models ==
  Rails.application.config.to_prepare do
  ActiveRecord::Base.descendants.each do |model|
    next if model.abstract_class?

    config.model model.name do
      [:edit, :show, :create].each do |section|
        send(section) do
          fields_of_type [:has_many, :has_one, :belongs_to] do
            hide
          end
        end
      end
    end
  end
end
 config.model 'Post' do
    list do 
      field :title
      field :status
      field :published_at
      field :view_count do
        pretty_value do
          bindings[:object].views_count
        end
      end
    end
  end

  ### == Customize User model display ==
  config.model 'User' do
    edit do
      exclude_fields :reset_password_sent_at, :remember_created_at, :posts, :books
    end

    create do
      exclude_fields :posts, :books
    end

    show do
      exclude_fields :reset_password_sent_at, :remember_created_at
    end

    list do
      exclude_fields :reset_password_sent_at, :remember_created_at, :posts, :books
    end
  end

  ### == RailsAdmin actions ==
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    # history_index
    # history_show
  end
end
