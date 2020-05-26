class HeroTypesController < ApplicationController
  before_action :get_data
  
  def show
  end
  
  def order
    order_check
    render 'hero_types/show'
  end

  private
    def get_data
      @hero_type = HeroType.find(params[:id])
      hero_ids = "SELECT id FROM heros WHERE hero_type_id = :hero_type_id"
      @ssrs = Ssr.where("hero_id IN (#{hero_ids})", hero_type_id: @hero_type.id)
      
      @paths = {
                color_desc: order_hero_type_path(@hero_type, "color_id",      "desc"),
                 color_asc: order_hero_type_path(@hero_type, "color_id",      "asc"),
            hero_name_desc: order_hero_type_path(@hero_type, "hero_id",       "desc"),
             hero_name_asc: order_hero_type_path(@hero_type, "hero_id",       "asc"),
            hero_type_desc: order_hero_type_path(@hero_type, "hero_type_id",  "desc"),
             hero_type_asc: order_hero_type_path(@hero_type, "hero_type_id",  "asc"),
                 name_desc: order_hero_type_path(@hero_type, "name",          "desc"),
                  name_asc: order_hero_type_path(@hero_type, "name",          "asc"),
                  atk_desc: order_hero_type_path(@hero_type, "atk",           "desc"),
                   atk_asc: order_hero_type_path(@hero_type, "atk",           "asc"),
                   hp_desc: order_hero_type_path(@hero_type, "hp",            "desc"),
                    hp_asc: order_hero_type_path(@hero_type, "hp",            "asc"),
              stamina_desc: order_hero_type_path(@hero_type, "stamina",       "desc"),
               stamina_asc: order_hero_type_path(@hero_type, "stamina",       "asc"),
                speed_desc: order_hero_type_path(@hero_type, "speed",         "desc"),
                 speed_asc: order_hero_type_path(@hero_type, "speed",         "asc"),
                  crt_desc: order_hero_type_path(@hero_type, "crt",           "desc"),
                   crt_asc: order_hero_type_path(@hero_type, "crt",           "asc"),
                 cost_desc: order_hero_type_path(@hero_type, "cost",          "desc"),
                  cost_asc: order_hero_type_path(@hero_type, "cost",          "asc"),
                   sp_desc: order_hero_type_path(@hero_type, "sp",            "desc"),
                    sp_asc: order_hero_type_path(@hero_type, "sp",            "asc"),
             sp_ratio_desc: order_hero_type_path(@hero_type, "sp_ratio",      "desc"),
              sp_ratio_asc: order_hero_type_path(@hero_type, "sp_ratio",      "asc"),
               sp_atk_desc: order_hero_type_path(@hero_type, "sp_atk",        "desc"),
                sp_atk_asc: order_hero_type_path(@hero_type, "sp_atk",        "asc"),
      }

      cal_maxmin
    end
end
