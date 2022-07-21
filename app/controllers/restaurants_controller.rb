class RestaurantsController < ApplicationController
  @@search_var
    def index
      if logged_in?
        @restaurant=Restaurant.all
      else
         redirect_to login_path
      end  
    end

    def show
      if logged_in?
        @restaurant=Restaurant.find(params[:id])
      else
          redirect_to login_path
      end   
    end

    def new
      if logged_in? && current_user.isadmin?
        @restaurant=Restaurant.new
      else
         flash[:notice]="Only admins allowed"
          redirect_to login_path
      end   
    end

    def create
      if logged_in? && current_user.isadmin?
        @restaurant=Restaurant.create(params_create)
        if @restaurant.save
            redirect_to @restaurant
        
        else
            render :new, status: :unprocessable_entity
        end
      else
         redirect_to login_path
      end   
    end

    def edit
      if logged_in? && current_user.isadmin?
        @restaurant = Restaurant.find(params[:id])
      else
          redirect_to login_path
      end   
      end
    
      def update
        if logged_in? && current_user.isadmin?
        @restaurant = Restaurant.find(params[:id])
        
        if params[:restaurant][:pictures].present?
          params[:restaurant][:pictures].each do |image|
            @restaurant.pictures.attach(image)
          end
        end
        if @restaurant.update(resturant_params)
          redirect_to @restaurant
        else
          render :edit, status: :unprocessable_entity
        end
      else
         redirect_to login_path
      end  
      end

      def destroy
        @restaurant = Restaurant.find(params[:id])
        @restaurant.destroy
    
        redirect_to restaurants_path, status: :see_other
      end

      def search
        if !logged_in?
          flash[:notice]="Please Signup/Login"
          redirect_to login_path
        end
         
        @searched_item=params[:search]
         @restaurants1= Restaurant.where("name LIKE ?", "%"+params[:search]+"%")
         binding.pry
         @restaurants2= Restaurant.near(params[:search],50).order("distance")
         @restaurants3= Restaurant.where("resturant_type LIKE ?", "%"+params[:search]+"%")

         @restaurants= @restaurants1|@restaurants2|@restaurants3
      end
    
      def search_filter
          @search=params[:search]
          @filter= params[:filter]
          binding.pry
          if params[:filter] == 'Restaurant'
          @restaurants= Restaurant.where("name LIKE ?", "%"+@search+"%")
          elsif params[:filter] == 'Location'
          @restaurants= Restaurant.near(@search,50).order("distance")
          else 
          @restaurants= Restaurant.where("resturant_type LIKE ?", "%"+@search+"%")
          end
          
          render :search_filter , locals:{search: params[:search], filter: params[:filter]}
      end
    
    private

    def params_create
        params.require(:restaurant).permit(:name,:category,:resturant_type,:latitude,:longitude,pictures: [])
    end

    def resturant_params
        params.require(:restaurant).permit(:name,:category,:resturant_type)
    end
end
