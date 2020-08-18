class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy, :submit_confirm, :update_confirm]

  def index
    if current_user.owner
      @requests = current_user.requests_as_owner
    elsif current_user.sitter
      @requests = current_user.requests_as_sitter
    end
  end

  def show
    # TODO: limit access if you are owner vs sitter
    # @request = Request.find(params[:id])
  end

  def create
    @request = Request.new(request_params)
    @request.owner = current_user
    # TODO: find sitter ID from params and set to @request.sitter
    # @request.sitter = ?
    authorize(@request)
    if request.save
      redirect_to submit_confirm_path(@request)
    else
      # render :sitter(@request.sitter)
    end
  end

  def update
    # As sitter, I can update rq for accept/decline
    # @request = Request.find(params[:id])
    authorize(@request)
    # TODO: set accepted if/else
  end

  def destroy
    # As owner, i can destory a rq
    # @request = Request.find(params[:id])
    authorize(@request)
    @request.destroy
    redirect_to requests_path
  end

  def submit_confirm
    # @request = Request.find(params[:id])
  end

  def update_confirm
    # @request = Request.find(params[:id])
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:requests).permit(:service, :start_date, :end_date, :price, :animal, :animal_info, :housing,)
  end
end
