class SittersController < ApplicationController
  def index
    @sitters = policy_scope(User).where(sitter: true)
    unless authorize(User)
      redirect_to root_path
    end

    @sitters = User.geocoded # returns sitter with coordinates

    @markers = @sitters.map do |sitter|
      {
        lat: sitter.latitude,
        lng: sitter.longitude,
        # infoWindow: render_to_string(partial: "info_window", locals: { address: sitter })
      }
    end
  end

  def show
    @sitter = User.find(params[:id])
    @request = Request.new
    @reviews = @sitter.reviews
    authorize(@sitter)
  end
end
