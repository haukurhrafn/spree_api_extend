Spree::Api::UsersController.class_eval do
  before_filter :authenticate_user, :except => [:new, :create]
  def create
    authorize! :create, Spree.user_class
    @user = Spree.user_class.new(user_params)
    if @user.save
      @user.generate_spree_api_key!
      respond_with(@user, :status => 201, :default_template => :show)
    else
      invalid_resource!(@user)
    end
  end
end

=begin
# Override create to allow anyone to create
# This No Bueno ?
Spree::Api::UsersController.class_eval do
  def create
    @user = Spree.user_class.new(params[:user])
    if @user.generate_spree_api_key!
      # # Create session for user?
      # sign_in(@user, bypass: true)
      # session[:spree_user_signup] = true
      # associate_user
      respond_with(@user, :status => 201, :default_template => :show)
    else
      invalid_resource!(@user)
    end
  end
end
=end
