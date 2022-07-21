class BookOfflineController < ApplicationController
  def index
  end
  
  def new
    if logged_in?
   @book= Book.new
    else
      redirect_to login_path
    end  
  end

  def create
    if logged_in?
    @book=Book.new(user_id:current_user.id, restaurant_id: params[:id], booked_at:params[:booked_at],booked_on:params[:booked_on], head:params[:heads])
    @book.save
    flash[:notice]="Booking Confirmed"
    redirect_to restaurants_path
   else
     redirect_to login_path
   end 
  end

end
