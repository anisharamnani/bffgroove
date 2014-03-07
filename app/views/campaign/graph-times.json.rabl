# TIMES OF DAY
collection @xaxis
node :variable do |m|
  m
end

@sorted_final.each_with_index do |value, i|
  @campaigns.each do |campaign|
    if campaign[@yaxis].to_f == value
      node(campaign.title.to_sym, :if => lambda do |m|
        m.split(" ").include? campaign.send_date.in_time_zone("Eastern Time (US & Canada)").strftime("%l%p").strip
      end) do
        campaign[@yaxis]
      end
    end
  end
end