collection @weekdays
node :weekday do |m|
  m
end

@sorted_final.each_with_index do |value, i|
  @group_campaigns.each do |gc|
    if gc[@yaxis].to_f == value
      node(gc.title.to_sym, :if => lambda {|m| gc.send_weekday == m}) do
        value
      end
    end
  end
end