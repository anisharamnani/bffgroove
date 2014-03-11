task :import => :environment do
  List.import_lists
  Campaign.import_response
  Campaign.group_campaigns
  GroupCampaign.aggregate
end