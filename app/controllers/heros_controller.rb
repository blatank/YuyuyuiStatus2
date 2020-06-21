class HerosController < ApplicationController
  before_action :get_data, only: [:show, :order]
  before_action :login_check, only: [:new, :create, :edit, :update]
  
  def index
    @heros = Hero.where("ssr_count > 0")
    maxmin_ave
  end
  
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
    def maxmin_ave
      @maxmin = {}
      @maxmin[:count_max] = @heros.order(ssr_count: :desc).first.id
      @maxmin[:count_min] = @heros.order(ssr_count: :desc).last.id
      @maxmin[:hp_max] = @heros.order(hp_ave: :desc).first.id
      @maxmin[:hp_min] = @heros.order(hp_ave: :desc).last.id
      @maxmin[:atk_max] = @heros.order(atk_ave: :desc).first.id
      @maxmin[:atk_min] = @heros.order(atk_ave: :desc).last.id
      @maxmin[:stamina_max] = @heros.order(stamina_ave: :desc).first.id
      @maxmin[:stamina_min] = @heros.order(stamina_ave: :desc).last.id
      @maxmin[:speed_max] = @heros.order(speed_ave: :desc).first.id
      @maxmin[:speed_min] = @heros.order(speed_ave: :desc).last.id      
      @maxmin[:crt_max] = @heros.order(crt_ave: :desc).first.id
      @maxmin[:crt_min] = @heros.order(crt_ave: :desc).last.id  
      
      # costは逆にする
      @maxmin[:cost_max] = @heros.order(cost_ave: :desc).last.id
      @maxmin[:cost_min] = @heros.order(cost_ave: :desc).first.id
      
      @maxmin[:sp_max] = @heros.order(sp_ave: :desc).first.id
      @maxmin[:sp_min] = @heros.order(sp_ave: :desc).last.id
      @maxmin[:sp_ratio_max] = @heros.order(sp_ratio_ave: :desc).first.id
      @maxmin[:sp_ratio_min] = @heros.order(sp_ratio_ave: :desc).last.id
      @maxmin[:sp_atk_max] = @heros.order(sp_atk_ave: :desc).first.id
      @maxmin[:sp_atk_min] = @heros.order(sp_atk_ave: :desc).last.id
    end
  
  
  
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
