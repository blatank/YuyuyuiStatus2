class StaticPagesController < ApplicationController
  def home
    @heros      = Hero.all
    @colors     = Color.all
    @hero_types = HeroType.all
  end
end
