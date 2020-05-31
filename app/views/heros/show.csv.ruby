require 'csv'

CSV.generate do |csv|
  column = [@hero.name, @hero.filename, @hero.hero_type.name]
  csv << column
  
  @ssrs.each do |ssr|
    column = [ssr.color.name, ssr.rare, ssr.name, ssr.hp, ssr.atk, Ssr.status_str(ssr.stamina), Ssr.status_str(ssr.speed),
              Ssr.status_str(ssr.crt), ssr.cost, ssr.sp, "%.15g"%(ssr.sp_ratio / 10.0)]
    
    # ログインしていたらimage_urlを追加する
    column.append(ssr.image_url) if logged_in?
    csv << column
  end
end
  