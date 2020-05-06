class SsrsController < ApplicationController
  def index
    @ssrs = Ssr.all
    cal_maxmin
  end
  
  def cal_maxmin
    order_list = {hp: :desc, atk: :desc, stamina: :desc, speed: :desc, crt: :desc,
                  cost: :desc, sp: :desc, sp_ratio: :desc, sp_atk: :desc }
    
    @max = {}
    @min = {}
    order_list.each do |key, value|
      order = {} # tmp
      order[key] = value
      tmp = unorder_ssrs.order(order)
      @max[key] = tmp.first.send(key)
      @min[key] = tmp.last.send(key)
    end
    
    # hps = unorder_ssrs.order(hp: :desc)
    # @hp_max = hps.first.hp
    # @hp_min = hps.last.hp
    
    # atks = unorder_ssrs.order(atk: :desc)
    # @atk_max = atks.first.atk
    # @atk_min = atks.last.atk    
    
    # stamina = unorder_ssrs.order(stamina: :desc)
    # @stamina_max = atks.first.atk
    # @stamina_min = atks.last.atk    
    
    

    # sp_atks = unorder_ssrs.order(sp_atk: :desc)
    # @sp_atk_max = sp_atks.first.sp_atk
    # @sp_atk_min = sp_atks.last.sp_atk
  end
  
  private
    # 並び順を解除した@ssrsを作成
    def unorder_ssrs
      @ssrs.where(rare: "SSR").unscope(:order)
    end
end
