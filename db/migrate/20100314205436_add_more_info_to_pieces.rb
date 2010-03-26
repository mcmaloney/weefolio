class AddMoreInfoToPieces < ActiveRecord::Migration
  def self.up
    add_column :pieces, :sale_url, :string
    add_column :pieces, :client_name, :string
    add_column :pieces, :service_type, :string
  end

  def self.down
    remove_column :pieces, :sale_url
    remove_column :pieces, :client_name
    remove_column :pieces, :service_type
  end
end
