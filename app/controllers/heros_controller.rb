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
  
  private
    def get_data
      @hero = Hero.find(params[:id])
      @ssrs = @hero.ssrs
      
      @paths = {
                spatk_desc: spatk_desc_hero_path(@hero),
                  atk_desc: atk_desc_hero_path(@hero)
                }

      cal_maxmin
    end
end
