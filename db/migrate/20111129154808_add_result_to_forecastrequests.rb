class AddResultToForecastrequests < ActiveRecord::Migration
  def self.up
    add_column :forecastrequests, :result, :string
  end

  def self.down
    remove_column :forecastrequests, :result
  end
end
