class HerosController < ApplicationController
  before_action :get_data
  
  def show
  end
  
  def spatk_desc
    @ssrs = @ssrs.unscope(:order).order(sp_atk: :desc)

    render 'heros/show'
  end

  def atk_desc
    @ssrs = @ssrs.unscope(:order).order(atk: :desc)

    render 'heros/show'
  end
  
  def order
    order_check
  end
  
  private
    def get_data
      @hero = Hero.find(params[:id])
      @ssrs = @hero.ssrs
      
      @paths = {
                color_desc: order_hero_path(@hero, "color_id",      "desc"),
                 color_asc: order_hero_path(@hero, "color_id",      "asc"),
            hero_name_desc: order_hero_path(@hero, "hero_name_id",  "desc"),
             hero_name_asc: order_hero_path(@hero, "hero_name_id",  "asc"),
            hero_type_desc: order_hero_path(@hero, "hero_type_id",  "desc"),
             hero_type_asc: order_hero_path(@hero, "hero_type_id",  "asc"),
                 name_desc: order_hero_path(@hero, "name",          "desc"),
                  name_asc: order_hero_path(@hero, "name",          "asc"),
                  atk_desc: order_hero_path(@hero, "atk",           "desc"),
                   atk_asc: order_hero_path(@hero, "atk",           "asc"),
                   hp_desc: order_hero_path(@hero, "hp",            "desc"),
                    hp_asc: order_hero_path(@hero, "hp",            "asc"),
              stamina_desc: order_hero_path(@hero, "stamina",       "desc"),
               stamina_asc: order_hero_path(@hero, "stamina",       "asc"),
                speed_desc: order_hero_path(@hero, "speed",         "desc"),
                 speed_asc: order_hero_path(@hero, "speed",         "asc"),
                  crt_desc: order_hero_path(@hero, "crt",           "desc"),
                   crt_asc: order_hero_path(@hero, "crt",           "asc"),
                 cost_desc: order_hero_path(@hero, "cost",          "desc"),
                  cost_asc: order_hero_path(@hero, "cost",          "asc"),
                   sp_desc: order_hero_path(@hero, "sp",            "desc"),
                    sp_asc: order_hero_path(@hero, "sp",            "asc"),
             sp_ratio_desc: order_hero_path(@hero, "sp_ratio",      "desc"),
              sp_ratio_asc: order_hero_path(@hero, "sp_ratio",      "asc"),
               sp_atk_desc: order_hero_path(@hero, "sp_atk",        "desc"),
                sp_atk_asc: order_hero_path(@hero, "sp_atk",        "asc"),
      }

      cal_maxmin
    end
    
    def order_check
      param_list = ["color_id", "hero_name_id", "hero_type_id", "name", "hp", "atk", "stamina", "speed", "crt", "cost", "sp", "sp_ratio", "sp_atk"]
      order_list = ["asc", "desc"]
      
      if param_list.include?(params[:param]) && order_list.include?(params[:order])
        @ssrs = @ssrs.unscope(:order).order({params[:param] => params[:order]})
        render 'heros/show'
      else
        flash.now[:danger] = "並び替え情報が異常なので、デフォルトの状態で表示します。"
        render 'heros/show'
      end
    end
end
