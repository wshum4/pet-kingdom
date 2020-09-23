class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :submit_confirm, :update_confirm]

  def index
    @requests = policy_scope(Request)
    authorize(Request)
    if current_user.owner && current_user.sitter
      # TODO: need to figure out how to display all sitter rq & owner rq
      @owner_requests = @requests.where(owner_id: current_user.id)
      @sitter_requests = @requests.where(sitter_id: current_user.id)
    end
  end

  def show
    # TODO: limit access if you are owner vs sitter
    # @request = Request.find(params[:id])
    @review = Review.new
    authorize(@request)
  end

  def create
    @request = Request.new(request_params)
    @request.owner = current_user
    @sitter = User.find(params[:id])
    @request.sitter = @sitter
    @animals = current_user.animals
    # @animals = Animal.where(owner_id: current_user.id)
    # call set price method in request model to set price
    @request.set_price
    authorize(@request)
    if @request.save
      redirect_to submit_confirm_request_path(@request)
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
    # call set price method in request model to set price
    @request.set_price
    if @request.save
      redirect_to update_confirm_request_path(@request)
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
    params.require(:request).permit(:service, :start_date, :end_date, :animal_id, :animal_info, :housing, :message, :accepted)
  end
end
