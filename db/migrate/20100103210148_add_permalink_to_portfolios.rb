class AddPermalinkToPortfolios < ActiveRecord::Migration
  def self.up
    add_column :portfolios, :permalink, :string
  end

  def self.down
    remove_column :portfolios, :permalink
  end
end
