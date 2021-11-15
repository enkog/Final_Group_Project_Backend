class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:destroy]

  def index
    render json: Reservation.all
  end

  def create
    @reservation = Reservation.new(reservations_params)
    if @reservation.save
      render json: {
        success: 'Reservation successful'
      },
             status: :created
    else
      render json: {
        error: 'Reservation was not created'
      },
             status: :bad_request
    end
  end

  def destroy
    if @reservation.destroy
      render json: { success: 'Reservation was deleted successfully' }
    else
      render json: { error: 'Reservation deletion was unsuccessful' }
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservations_params
    params.require(:reservation).permit(:user_id, :course_id, :start_date)
  end
end
