# Picked up this lil trick from EJS Demo App.
# Probably a better long term solution.
module Spree
  module Api
    class StatusController < Spree::Api::BaseController
      include Spree::Core::ControllerHelpers::Auth
      include Spree::Core::ControllerHelpers::Order
      
      def show
        #@order = current_order(true)
        #@order = current_order(:create_order_if_necessary => true)
        @order = find_current_order
        @user = user
      end
      
      private

      def user
        @current_api_user || try_spree_current_user
      end
      
      def find_current_order
        current_api_user ? current_api_user.orders.incomplete.order(:created_at).last : nil
      end
    end
  end
end