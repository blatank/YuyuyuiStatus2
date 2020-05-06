class HerosController < ApplicationController
  def show
    @hero = Hero.find(params[:id])
    @ssrs = @hero.ssrs
    cal_maxmin
  end
end
