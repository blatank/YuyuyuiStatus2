class SsrsController < ApplicationController
  def home
    @ssrs = Ssr.all
    @title = "SSRステータス"
  end
end
