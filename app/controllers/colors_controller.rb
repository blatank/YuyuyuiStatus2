class ColorsController < ApplicationController
  def show
    @color = Color.find(params[:id])
    @ssrs = Ssr.where(color_id: @color.id)
    cal_maxmin
  end
end
