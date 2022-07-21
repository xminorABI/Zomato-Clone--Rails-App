class UsersController < ApplicationController

    before_action :authorized, only: [:show]
    
    def new
        if !logged_in?
        @user=User.new
        else
            redirect_to login_path
        end

    end

    def create

      if logged_in?
        flash[:notice]= "Cant create new user while logged in"
        redirect_to login_path
      end

        @user=User.new(user_params)
        @user.email= @user.email.downcase
        if @user.valid?
            @user.save
            flash[:notice]="User Created. Sign in to continue."
            redirect_to @user
        else
            redirect_to signup_path
        end
    end

    def show
      @user=User.find(params[:id])
    
      if session[:user_id] != @user.id
        flash[:notice]="Action not authorized"
        redirect_to login_path
      end
      @city= request.location.city
      @restaurants=Restaurant.all
    end

    def edit
      @user=User.find(params[:id])
      if session[:user_id] != @user.id
        flash[:notice]= "Not Authorized"
       redirect_to login_path 
      end
      @user = User.find(params[:id])
      end
    
      def update
        if !logged_in?
          redirect_to  login_path
        else  
        @user = User.find(params[:id])
     if current_user.id != @user.id
          redirect_to login_path
        end
        if @user.update(user_params)
          redirect_to @user
        else
          render :edit, status: :unprocessable_entity
        end
      end
      end
    
      def user_reviews
        @user= User.find(current_user.id)
        @reviews= Review.where(user_id: @user.id)
      end

      def appointments
        @user=User.find(params[:id])
        if session[:user_id] != @user.id
          flash[:notice]="Action not authorized"
          redirect_to login_path
        end
        @book= Book.where(user_id:current_user.id)
      end
    private

    def user_params
        params.require(:user).permit(:email,:username,:password,:password_confirmation,:isadmin,:latitude,:longitude)
    end
end
