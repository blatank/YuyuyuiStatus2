class SsrsController < ApplicationController
  def index
    @ssrs = Ssr.all
    cal_maxmin
  end
end
