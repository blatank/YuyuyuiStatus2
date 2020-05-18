class ApplicationController < ActionController::Base
  def cal_maxmin
    order_list = {hp: :desc, atk: :desc, stamina: :desc, speed: :desc, crt: :desc,
                  cost: :desc, sp: :desc, sp_ratio: :desc, sp_atk: :desc }
    
    @max = {}
    @min = {}
    @average = {}
    order_list.each do |key, value|
      order = {} # tmp
      order[key] = value
      
      # ぽかよけ(SSR=0のときはデータセットしなくてもよい。参照先がなくなる)
      if @ssrs.count > 0
        tmp = unorder_ssrs.order(order)
        @max[key]     = tmp.first.send(key)
        @min[key]     = tmp.last.send(key)
        @average[key] = tmp.average(key)
      end
    end
  end
  
  private
    # 並び順を解除した@ssrsを作成
    def unorder_ssrs
      @ssrs.where(rare: "SSR").unscope(:order)
    end
end
