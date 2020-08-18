class SittersController < ApplicationController
  def index
    @sitters = User.where('sitter = true')
    authorize(@sitters)
  end

  def show
    @sitter = User.find(params[:id])
    authorize(@sitter)
  end
end
