RailsAdmin.config do |config|
  config.asset_source = :importmap
  
  # Change the admin panel name
  config.main_app_name = ["SavannaLingo", "Admin"]
  
  # Add logout link in navigation
  config.navigation_static_links = {
    'Logout' => '/users/sign_out'
  }
  
  # Or add custom navigation with method specification
  config.navigation_static_label = "Account"
  config.asset_source = :sprockets


  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  
  # Authorization - only allow admin users
  config.authorize_with do |controller|
    unless current_user&.user_role == 'admin'
      redirect_to main_app.root_path, alert: 'Access denied. Admin privileges required.'
    end
  end

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end