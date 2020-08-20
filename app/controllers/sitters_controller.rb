class SittersController < ApplicationController
  def index
    @sitters = policy_scope(User).where(sitter: true)
    # unless authorize(User)
    #   redirect_to root_path
    # end
  end

  def show
    @sitter = User.find(params[:id])
    @request = Request.new
    authorize(@sitter)
  end
end
