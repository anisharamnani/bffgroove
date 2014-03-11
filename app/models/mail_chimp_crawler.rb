class MailChimpCrawler

  def all_campaigns
    response = HTTParty.get("https://us5.api.mailchimp.com/2.0/campaigns/list?apikey=#{ENV['API_KEY']}&limit=100&filters[status]=sent&filters[sendtime_end]=#{2.days.ago.strftime("%F")}")
    response["data"]
  end

  def google_analytics(campaign_id)
    HTTParty.get("https://us5.api.mailchimp.com/2.0/reports/google-analytics?apikey=#{ENV['API_KEY']}&cid=#{campaign_id}")
  end

  def all_lists
    response = HTTParty.get("https://us5.api.mailchimp.com/2.0/lists/list?apikey=#{ENV['API_KEY']}&limit=100")
    response["data"]
  end

end
