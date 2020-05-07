class HeroTypesController < ApplicationController
  def show
    @hero_type = HeroType.find(params[:id])
    hero_ids = "SELECT id FROM heros WHERE hero_type_id = :hero_type_id"
    @ssrs = Ssr.where("hero_id IN (#{hero_ids})", hero_type_id: @hero_type.id)
    cal_maxmin
  end
end
