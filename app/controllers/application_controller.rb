class ApplicationController < ActionController::Base
  include SessionsHelper
  
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
  
  protected
    
    # login check
    def login_check
      unless logged_in?
        flash[:danger] = "無効な操作です"
        redirect_to root_url
      end
    end
    
    def order_check
      param_list = ["color_id", "hero_id", "hero_type_id", "name", "hp", "atk", "stamina", "speed", "crt", "cost", "sp", "sp_ratio", "sp_atk"]
      order_list = ["asc", "desc"]
      
      if param_list.include?(params[:param]) && order_list.include?(params[:order])
        @ssrs = @ssrs.unscope(:order).order({params[:param] => params[:order]})
      else
        flash.now[:danger] = "並び替え情報が異常なので、デフォルトの状態で表示します。"
      end
    end
  
  private
    # 並び順を解除した@ssrsを作成
    def unorder_ssrs
      @ssrs.where(rare: "SSR").unscope(:order)
    end
end
