class HerosController < ApplicationController
  before_action :get_data, only: [:show, :order]
  before_action :login_check, only: [:new, :create, :edit, :update]
  
  def show
    respond_to do |format|
      format.html do
      end
    
      format.csv do
        send_data render_to_string, filename: "#{@hero.filename}.csv", type: :csv
      end
    end
  end
  
  def new
    @hero = Hero.new
  end
  
  def create
    @hero = Hero.new(hero_params)
    
    if @hero.save
      flash[:success] = "#{@hero.name} を登録しました"
      redirect_to @hero
    else
      render 'new'
    end
  end
  
  def edit
    @hero = Hero.find(params[:id])
  end
  
  def update
    @hero = Hero.find(params[:id])
    
    if @hero.update(hero_params)
      flash[:success] = "データ更新完了"
      redirect_to @hero
    else
      render 'edit'
    end
  end
  
  def order
    order_check
    render 'heros/show'
  end
  
  private
    def hero_params
      params.require(:hero).permit(:name, :hero_type_id, :filename, :icon_url)
    end
    
    def get_data
      @hero = Hero.find(params[:id])
      @ssrs = @hero.ssrs
      
      @paths = {
                color_desc: order_hero_path(@hero, "color_id",      "desc"),
                 color_asc: order_hero_path(@hero, "color_id",      "asc"),
            hero_name_desc: order_hero_path(@hero, "hero_id",       "desc"),
             hero_name_asc: order_hero_path(@hero, "hero_id",       "asc"),
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
end
