# WEEKDAYS
collection @xaxis
node :variable do |m|
  m
end

@sorted_final.each_with_index do |value, i|
  @campaigns.each do |campaign|
    if campaign[@yaxis].to_f == value
      node(campaign.title.to_sym, :if => lambda {|m| campaign.send_weekday == m}) do
        campaign[@yaxis]
      end
    end
  end
end