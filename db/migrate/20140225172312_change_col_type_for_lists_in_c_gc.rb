class ChangeColTypeForListsInCGc < ActiveRecord::Migration
  def up
    remove_column :campaigns, :list
    add_column :campaigns, :list_id, :integer
    remove_column :group_campaigns, :list
    add_column :group_campaigns, :list_id, :integer
  end

  def down
    remove_column :campaigns, :list_id
    add_column :campaigns, :list, :string
    remove_column :group_campaigns, :list_id
    add_column :group_campaigns, :list, :string
  end
end
