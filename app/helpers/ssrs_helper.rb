module SsrsHelper
  def puts_maxmin_class(max=0, min=0, myself=0)
    if min == max
      ""
    elsif myself == max
      "strongest"
    elsif myself == min
      "weakest"
    else
      ""
    end
  end
end
