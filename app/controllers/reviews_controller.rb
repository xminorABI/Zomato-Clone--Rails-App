class ReviewsController < ApplicationController

    def index
        @user= User.find(params[:user_id])        
        if session[:user_id]== @user.id 
        @user=User.find(current_user.id)
        else
            flash[:notice]= "Not Authorized"
            redirect_to login_path
        end      
    end

    def new
        @review=Review.new
    end


    def create
        @restaurant=Restaurant.find(params[:restaurant_id])
        @res=@restaurant.reviews.new(ratings: params[:ratings], stars: params[:stars])
        @res.user_id=current_user.id
        @res.save
        flash[:notice]="Review sent for approval from admin"
        redirect_to @restaurant        
    end

    # Need edit and update actions
  
    def edit
        @review=Review.find(params[:id])
    end
    
    def update
        @review = Review.find(params[:id])

        if logged_in? && current_user.isadmin && @review.update(isApproved: true)
          redirect_to admin_approval_path
        elsif logged_in? && !current_user.isadmin && @review.update(review_params) && @review.update(isApproved: false)
            redirect_to user_path(current_user.id)
        else
          redirect_to login_path, status: :unprocessable_entity
        end
    end
    # def approved
    #     @review=params[:id]
    #     @review.save
    #     redirect_to admin_panel_path
    # end

    # def declined
    #     @review=params[:reviews]
    #     Review.delete(@review.id)
    #     redirect_to admin_panel_path    # end

    # def show
    #     @user=User.find(current_user.id)
    # end
    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        flash[:notice]="Review Deleted"
        redirect_to restaurants_path, status: :see_other
      end

      def accept  
        @review= Review.find(params[:review_id])
        @review.update(isApproved: true)
        flash[:notice]="Review Accepted"
        redirect_to admin_approval_path
    end  
    private
    # def review_params
    #     params.require(:review).permit(:ratings)
    # end
end
