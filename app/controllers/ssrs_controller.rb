class SsrsController < ApplicationController
  before_action :get_data
  def index
  end
  
  def order
    order_check
    render 'ssrs/index'
  end
  
  private
    def get_data
      @ssrs = Ssr.all
      
      @paths = {
                color_desc: order_ssrs_path("color_id",      "desc"),
                 color_asc: order_ssrs_path("color_id",      "asc"),
            hero_name_desc: order_ssrs_path("hero_id",       "desc"),
             hero_name_asc: order_ssrs_path("hero_id",       "asc"),
            hero_type_desc: order_ssrs_path("hero_type_id",  "desc"),
             hero_type_asc: order_ssrs_path("hero_type_id",  "asc"),
                 name_desc: order_ssrs_path("name",          "desc"),
                  name_asc: order_ssrs_path("name",          "asc"),
                  atk_desc: order_ssrs_path("atk",           "desc"),
                   atk_asc: order_ssrs_path("atk",           "asc"),
                   hp_desc: order_ssrs_path("hp",            "desc"),
                    hp_asc: order_ssrs_path("hp",            "asc"),
              stamina_desc: order_ssrs_path("stamina",       "desc"),
               stamina_asc: order_ssrs_path("stamina",       "asc"),
                speed_desc: order_ssrs_path("speed",         "desc"),
                 speed_asc: order_ssrs_path("speed",         "asc"),
                  crt_desc: order_ssrs_path("crt",           "desc"),
                   crt_asc: order_ssrs_path("crt",           "asc"),
                 cost_desc: order_ssrs_path("cost",          "desc"),
                  cost_asc: order_ssrs_path("cost",          "asc"),
                   sp_desc: order_ssrs_path("sp",            "desc"),
                    sp_asc: order_ssrs_path("sp",            "asc"),
             sp_ratio_desc: order_ssrs_path("sp_ratio",      "desc"),
              sp_ratio_asc: order_ssrs_path("sp_ratio",      "asc"),
               sp_atk_desc: order_ssrs_path("sp_atk",        "desc"),
                sp_atk_asc: order_ssrs_path("sp_atk",        "asc"),
      }

      cal_maxmin
    end
end
