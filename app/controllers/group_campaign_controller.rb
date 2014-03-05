class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group_campaigns = GroupCampaign.order(:send_date).reverse

    respond_to do |format|
      format.html
      format.csv { send_data GroupCampaign.to_csv }
      format.json { render "group_campaign/index.json.rabl" }
    end
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])

    respond_to do |format|
      format.html
      format.csv { send_data @group_campaign.to_csv }
      format.json { render "group_campaign/show.json.rabl" }
    end
  end

  def graph
    @group_campaigns = GroupCampaign.order(:send_date).reverse.first(30) # this isn't a certain number of days
    @weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @yaxis = params[:yaxis]

    sorted_temp = []
    @sorted_final = []

    @group_campaigns.each do |group_campaign|
      @sorted_final = (sorted_temp << group_campaign[@yaxis]).sort.reverse
    end

    respond_to do |format|
      format.html
      format.json { render "group_campaign/graph.json.rabl" }
    end
  end


end
