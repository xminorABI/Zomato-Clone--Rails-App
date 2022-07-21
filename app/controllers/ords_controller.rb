class OrdsController < ApplicationController

    def index
        if logged_in?
        @restaurant= Restaurant.find(params[:restaurant_id])
        @menu_arr=params[:accept]
        @quantity_arr=params[:quantity]
        @q=@quantity_arr.delete("")
        @test= @menu_arr[0].to_i
        @test=@test-1
        @total=0
        else
            redirect_to login_path
        end    
    end

    def create
        if logged_in?
        @menus= params[:menu_arr].split(' ')
        @restaurant_id=params[:restaurant_id]
        @quantity_arr= params[:quantity_arr].split(' ')
        @add= params[:street]+','+params[:city]+'-'+params[:pincode]
        @order=Ord.new(user_id:current_user.id, restaurant_id:@restaurant_id,Address:@add)
        @order.save
        @menus.each_with_index do |menu,index|
         @order.ord_items.create(menu: menu, quantity: @quantity_arr[index])
        end   
        redirect_to gmapps_path
    else
        redirect_to login_path
    end  
    end
end
