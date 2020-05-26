class ColorsController < ApplicationController
  before_action :get_data
  
  def show
  end
  
  def order
    order_check
    render 'colors/show'
  end
  
  private
    def get_data
      @color = Color.find(params[:id])
      @ssrs = Ssr.where(color_id: @color.id)
    
      @paths = {
                color_desc: order_color_path(@color, "color_id",      "desc"),
                 color_asc: order_color_path(@color, "color_id",      "asc"),
            hero_name_desc: order_color_path(@color, "hero_id",       "desc"),
             hero_name_asc: order_color_path(@color, "hero_id",       "asc"),
            hero_type_desc: order_color_path(@color, "hero_type_id",  "desc"),
             hero_type_asc: order_color_path(@color, "hero_type_id",  "asc"),
                 name_desc: order_color_path(@color, "name",          "desc"),
                  name_asc: order_color_path(@color, "name",          "asc"),
                  atk_desc: order_color_path(@color, "atk",           "desc"),
                   atk_asc: order_color_path(@color, "atk",           "asc"),
                   hp_desc: order_color_path(@color, "hp",            "desc"),
                    hp_asc: order_color_path(@color, "hp",            "asc"),
              stamina_desc: order_color_path(@color, "stamina",       "desc"),
               stamina_asc: order_color_path(@color, "stamina",       "asc"),
                speed_desc: order_color_path(@color, "speed",         "desc"),
                 speed_asc: order_color_path(@color, "speed",         "asc"),
                  crt_desc: order_color_path(@color, "crt",           "desc"),
                   crt_asc: order_color_path(@color, "crt",           "asc"),
                 cost_desc: order_color_path(@color, "cost",          "desc"),
                  cost_asc: order_color_path(@color, "cost",          "asc"),
                   sp_desc: order_color_path(@color, "sp",            "desc"),
                    sp_asc: order_color_path(@color, "sp",            "asc"),
             sp_ratio_desc: order_color_path(@color, "sp_ratio",      "desc"),
              sp_ratio_asc: order_color_path(@color, "sp_ratio",      "asc"),
               sp_atk_desc: order_color_path(@color, "sp_atk",        "desc"),
                sp_atk_asc: order_color_path(@color, "sp_atk",        "asc"),
      }

      cal_maxmin
    end
end
