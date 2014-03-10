class Campaign < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :title, :subject, :list_id, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :unique_id, :analytics_roi, :campaign_cost, :revenue_created, :visits, :new_visits, :pagesvisit, :bounce_rate, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value, :group_campaign_id, :folder_id
  has_one :group_campaign
  belongs_to :list
  attr_reader :api

  def self.get_api_response
    @@api.all_campaigns
  end

  def self.google_analytics(campaign_id)
    @@api.google_analytics(campaign_id)
  end

  def self.import_response
    @@api = MailChimpCrawler.new
    response = get_api_response
    response.each do |campaign|
      current_campaign = find_by_unique_id(campaign["id"]) || new
      current_campaign[:unique_id] = campaign["id"]
      current_campaign[:send_date] = campaign["send_time"]
      if campaign["summary"] != []
        current_campaign[:times_forwarded] = campaign["summary"]["forwards"]
        current_campaign[:total_opens] = campaign["summary"]["opens"]
        current_campaign[:total_clicks] = campaign["summary"]["clicks"]
        current_campaign[:open_rate] = campaign["summary"]["unique_opens"] / campaign["emails_sent"].to_f
        current_campaign[:abuse_complaints] = campaign["summary"]["abuse_reports"]
        current_campaign[:total_bounces] = (campaign["summary"]["soft_bounces"] + campaign["summary"]["hard_bounces"])
      end
      current_campaign[:total_recipients] = campaign["emails_sent"] - current_campaign[:total_bounces]
      google_analytics_hash = google_analytics(current_campaign.unique_id)
      if google_analytics_hash.parsed_response != []
        current_campaign[:revenue_created] = google_analytics_hash["revenue"].to_f
        if current_campaign[:total_recipients] != 0
          conversion_rate = (google_analytics_hash["ecomm_conversions"].to_f / google_analytics_hash["visits"]) * 100
          current_campaign[:ecommerce_conversion_rate] = conversion_rate
        end
        google_analytics_hash.each do |key, val|
          current_campaign.set_attributes(key, val)
        end
      end
      campaign.each do |key, val|
        if key == "summary"
          val.each do |key2, val2|
            if key2 == "industry"
              val2.each do |key3, val3|
                if key3 != "open_rate"
                  current_campaign.set_attributes(key3, val3)
                end
              end
            else
              current_campaign.set_attributes(key2, val2)
            end
          end
        elsif key == "list_id"
          list = List.find_by_list_id(val)
          list.campaigns << current_campaign
          list.save!
        else
          current_campaign.set_attributes(key, val)
        end
      end
      current_campaign.calculate_successful_deliveries
      current_campaign.calculate_click_rate
      current_campaign.save!
      current_campaign.set_send_day
      current_campaign[:send_date].in_time_zone("Eastern Time (US & Canada)")
    end
  end

  def set_send_day
    self.send_weekday = self.send_date.strftime("%A")
    self.save!
  end

  def set_attributes(key, val)
    if Campaign.column_names.include?(key) && key != "id"
      if Campaign.columns_hash[key].type == :integer
        val = val.to_i
      elsif Campaign.columns_hash[key].type == :decimal
        val = val.to_f
      end
      update_attributes(key.to_sym => val)
    end
  end

  def calculate_successful_deliveries
    self[:successful_deliveries] = (self[:total_recipients] - self[:total_bounces])
    self.save!
  end

  def calculate_click_rate 
    self[:click_rate] = (self[:total_clicks].to_f/self[:successful_deliveries])*100
    self.save!
  end 

  def self.group_campaigns
    self.all.each do |campaign|
      if /(.*) \(/.match(campaign["title"])
        title = /(.*) \(/.match(campaign["title"])[1]
      else
        title = campaign.title 
      end
      group_campaign = GroupCampaign.find_or_create_by_title(title)
      group_campaign.campaigns << campaign
      group_campaign.save! 
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |campaign|
        csv << campaign.attributes.values_at(*column_names)
      end
    end
  end

  def to_csv
    CSV.generate do |csv|
      csv << Campaign.column_names
      self.each do |campaign|
        csv << campaign.attributes.values_at(*column_names)
      end
    end
  end

  def self.date_range(from,to)
    datecampaignsfrom = from.to_s + "T00:00:00Z"
    datecampaignsto = to.to_s + "T23:59:59Z"
    campaigns = Campaign.where(:send_date => datecampaignsfrom..datecampaignsto)
  end

end