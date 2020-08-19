class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :submit_confirm, :update_confirm]

  def index
    @all_requests = policy_scope(Request)
    authorize(Request)
    if current_user.owner && current_user.sitter
      # TODO: need to figure out how to display all sitter rq & owner rq
      @requests = @all_requests.where(owner_id: current_user.id).or(@all_requests.where(sitter_id: current_user.id))
    elsif current_user.owner
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
    @sitter = User.find(params[:id])
    @request.sitter = @sitter
    authorize(@request)
    if @request.save
      redirect_to submit_confirm_path(@request)
    else
      render 'sitters/show'
    end
  end

  def edit
    authorize(@request)
  end
  
  def update
    # As sitter, I can update rq for accept/decline
    # @request = Request.find(params[:id])
    authorize(@request)
    @request.update(request_params)
    if @request.save
      render :update_confirm
    else
      render 'show'
    end
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
    authorize(@request)
  end

  def update_confirm
    # @request = Request.find(params[:id])
    authorize(@request)
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:service, :start_date, :end_date, :price, :animal, :animal_info, :housing, :message, :accepted)
  end
end
