class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy, :submit_confirm, :update_confirm]

  def index
    @all_requests = policy_scope(Request)
    authorize(Request)
    if current_user.owner
      @requests = @all_requests.where(owner_id: current_user.id)
    elsif current_user.sitter
      @requests = @all_requests.where(sitter_id: current_user.id)
    end
  end

  def show
    # TODO: limit access if you are owner vs sitter
    # @request = Request.find(params[:id])
    authorize(@request)
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
    @request.update(request_params)
    @request.save
    render 'show'
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
    params.require(:requests).permit(:service, :start_date, :end_date, :price, :animal, :animal_info, :housing, :accepted)
  end
end
