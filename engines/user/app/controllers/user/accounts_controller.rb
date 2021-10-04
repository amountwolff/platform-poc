require_dependency "user/application_controller"

module User
  class AccountsController < ApplicationController
    before_action :authenticate_account!
    before_action :set_account, only: [:show]

    # GET /customers/1
    def show
      render json: @account.to_json
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_account
    end
  end
end
