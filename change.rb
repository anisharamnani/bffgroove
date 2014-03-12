GroupCampaign.all.each do |gc|
  if gc.id > 282
    gc.campaigns.destroy_all
    gc.destroy
  end
end

GroupCampaign.all.each do |gc|
  gc.title = Random.paragraphs[0..28]
  gc.campaigns.each_with_index do |c, i|
    c.title = gc.title + " copy(#{i})"
    c.subject = Random.paragraphs[0..28]
    c.total_recipients = Random.number(60000)
    c.successful_deliveries = c.total_recipients - Random.number(1000)
    c.soft_bounces = Random.number(30)
    c.hard_bounces = Random.number(20)
    c.total_bounces = c.soft_bounces + c.hard_bounces
    c.times_forwarded = Random.number(10)
    c.unique_opens = Random.number(4000)
    c.open_rate = Random.number(100) / 100.to_f
    c.total_opens = Random.number(5000)
    c.unique_clicks = Random.number(200)
    c.click_rate = c.total_opens / c.unique_opens.to_f
    c.total_clicks = c.unique_opens + Random.number(30)
    c.unsubscribes = Random.number(60)
    c.abuse_complaints = Random.number(10)
    c.unique_id = Random.alphanumeric
    c.revenue_created = Random.number(40000).to_f
    c.visits = Random.number(2000)
    c.new_visits = c.visits - Random.number(300)
    c.bounce_rate = Random.number(50) / 100.to_f
    c.transactions - Random.number(500)
    c.ecommerce_conversion_rate = Random.number(100) / 100.to_f
    c.save!
  end
  gc.save!
end

List.all.each do |l|
  l.name = /(\w*)\s.*/.match(Random.paragraphs)[1]
  l.save!
end