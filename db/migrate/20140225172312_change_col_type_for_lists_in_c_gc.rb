class ChangeColTypeForListsInCGc < ActiveRecord::Migration
  def up
    execute <<-SQL
      EXEC sp_RENAME 'campaigns.list', 'list_id', 'COLUMN';
      ALTER TABLE campaigns
      ALTER COLUMN list_id TYPE int;
      EXEC sp_RENAME 'group_campaigns.list', 'list_id', 'COLUMN';
      ALTER TABLE group_campaigns
      ALTER COLUMN list_id TYPE int
    SQL
    # rename_column :campaigns, :list, :list_id
    # change_column :campaigns, :list_id, :integer
    # rename_column :group_campaigns, :list, :list_id
    # change_column :group_campaigns, :list_id, :integer
  end

  def down
    rename_column :campaigns, :list_id, :list
    change_column :campaigns, :list, :string
    rename_column :group_campaigns, :list_id, :list
    change_column :group_campaigns, :list, :string
  end
end
