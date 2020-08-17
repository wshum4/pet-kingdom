class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy, :submit_confirm, :update_confirm]

  def index
    @requests = Request.all
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
    @request.destroy
  end

  def submit_confirm
  end

  def update_confirm
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end
end
